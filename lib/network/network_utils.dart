import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/api_end_points.dart';

import '../configs.dart';
import '../main.dart';
import '../screens/auth/services/auth_service_apis.dart';
import '../utils/app_common.dart';
import '../utils/common_base.dart';
import '../utils/constants.dart';
import '../utils/local_storage.dart';

Map<String, String> buildHeaderTokens({
  Map? extraKeys,
  String? endPoint,
}) {
  /// Initialize & Handle if key is not present
  if (extraKeys == null) {
    extraKeys = {};
    extraKeys.putIfAbsent('isFlutterWave', () => false);
    extraKeys.putIfAbsent('isAirtelMoney', () => false);
  }
  Map<String, String> header = {
    HttpHeaders.cacheControlHeader: 'no-cache',
    'Access-Control-Allow-Headers': '*',
    'Access-Control-Allow-Origin': '*',
    'global-localization': selectedLanguageCode.value,
  };

  if (endPoint == APIEndPoints.register) {
    header.putIfAbsent(HttpHeaders.acceptHeader, () => 'application/json');
  }
  header.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json; charset=utf-8');

  if (isLoggedIn.value && extraKeys.containsKey('isFlutterWave') && extraKeys['isFlutterWave']) {
    header.putIfAbsent(HttpHeaders.authorizationHeader, () => "Bearer ${extraKeys!['flutterWaveSecretKey']}");
  } else if (isLoggedIn.value && extraKeys.containsKey('isAirtelMoney') && extraKeys['isAirtelMoney']) {
    header.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json; charset=utf-8');
    header.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer ${extraKeys!['access_token']}');
    header.putIfAbsent('X-Country', () => '${extraKeys!['X-Country']}');
    header.putIfAbsent('X-Currency', () => '${extraKeys!['X-Currency']}');
  } else if (isLoggedIn.value) {
    header.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer ${loginUserData.value.apiToken}');
  }

  // log(jsonEncode(header));
  return header;
}

Uri buildBaseUrl(String endPoint) {
  if (!endPoint.startsWith('http')) {
    return Uri.parse('$BASE_URL$endPoint');
  } else {
    return Uri.parse(endPoint);
  }
}

Future<Response> buildHttpResponse(
  String endPoint, {
  HttpMethodType method = HttpMethodType.GET,
  Map? request,
  Map? extraKeys,
}) async {
  var headers = buildHeaderTokens(extraKeys: extraKeys, endPoint: endPoint);
  Uri url = buildBaseUrl(endPoint);

  Response response;
  log('URL (${method.name}): $url');

  try {
    if (method == HttpMethodType.POST) {
      log('Request: ${jsonEncode(request)}');
      response = await http.post(url, body: jsonEncode(request), headers: headers);
    } else if (method == HttpMethodType.DELETE) {
      response = await delete(url, headers: headers);
    } else if (method == HttpMethodType.PUT) {
      response = await put(url, body: jsonEncode(request), headers: headers);
    } else {
      response = await get(url, headers: headers);
    }
    apiPrint(
      url: url.toString(),
      endPoint: endPoint,
      headers: jsonEncode(headers),
      hasRequest: method == HttpMethodType.POST || method == HttpMethodType.PUT,
      request: jsonEncode(request),
      statusCode: response.statusCode,
      responseBody: response.body.trim(),
      methodtype: method.name,
    );
    // log('Response (${method.name}) ${response.statusCode}: ${response.body.trim().trim()}');

    if (isLoggedIn.value && response.statusCode == 401 && !endPoint.startsWith('http')) {
      return await reGenerateToken().then((value) async {
        return await buildHttpResponse(endPoint, method: method, request: request, extraKeys: extraKeys);
      }).catchError((e) {
        throw errorSomethingWentWrong;
      });
    } else {
      return response;
    }
  } on Exception catch (e) {
    log(e);
    if (!await isNetworkAvailable()) {
      throw locale.value.yourInternetIsNotWorking;
    } else {
      throw errorSomethingWentWrong;
    }
  }
}

Future<void> reGenerateToken() async {
  log('Regenerating Token');
  final userPASSWORD = getValueFromLocal(SharedPreferenceConst.USER_PASSWORD);

  Map req = {
    UserKeys.email: loginUserData.value.email,
    UserKeys.playerId: playerId.value,
    UserKeys.userType: LoginTypeConst.LOGIN_TYPE_USER,
  };
  if (loginUserData.value.isSocialLogin) {
    log('LOGINUSERDATA.VALUE.ISSOCIALLOGIN: ${loginUserData.value.isSocialLogin}');
    req[UserKeys.loginType] = loginUserData.value.loginType;
  } else {
    req[UserKeys.password] = userPASSWORD;
  }
  return await AuthServiceApis.loginUser(request: req, isSocialLogin: loginUserData.value.isSocialLogin).then((value) async {
    loginUserData.value.apiToken = value.userData.apiToken;
  }).catchError((e) {
    throw e;
  });
}

Future handleResponse(Response response, {HttpResponseType httpResponseType = HttpResponseType.JSON, bool? avoidTokenError, bool? isFlutterWave}) async {
  if (!await isNetworkAvailable()) {
    throw errorInternetNotAvailable;
  }

  if (response.statusCode.isSuccessful()) {
    if (response.body.trim().isJson()) {
      Map body = jsonDecode(response.body.trim());

      if (body.containsKey('status')) {
        if (isFlutterWave.validate()) {
          if (body['status'] == 'success') {
            return body;
          } else {
            throw body['message'] ?? errorSomethingWentWrong;
          }
        } else {
          if (body['status']) {
            return body;
          } else {
            throw body['message'] ?? errorSomethingWentWrong;
          }
        }
      } else {
        return body;
      }
    } else {
      throw errorSomethingWentWrong;
    }
  } else if (response.statusCode == 400) {
    throw locale.value.badRequest;
  } else if (response.statusCode == 403) {
    throw locale.value.forbidden;
  } else if (response.statusCode == 404) {
    throw locale.value.pageNotFound;
  } else if (response.statusCode == 429) {
    throw locale.value.tooManyRequests;
  } else if (response.statusCode == 500) {
    throw locale.value.internalServerError;
  } else if (response.statusCode == 502) {
    throw locale.value.badGateway;
  } else if (response.statusCode == 503) {
    throw locale.value.serviceUnavailable;
  } else if (response.statusCode == 504) {
    throw locale.value.gatewayTimeout;
  } else {
    Map body = jsonDecode(response.body.trim());

    if (body.containsKey('status') && body['status']) {
      return body;
    } else {
      throw body['message'] ?? errorSomethingWentWrong;
    }
  }
}

//region CommonFunctions
Future<Map<String, String>> getMultipartFields({required Map<String, dynamic> val}) async {
  Map<String, String> data = {};

  val.forEach((key, value) {
    data[key] = '$value';
  });

  return data;
}

Future<MultipartRequest> getMultiPartRequest(String endPoint, {String? baseUrl}) async {
  String url = baseUrl ?? buildBaseUrl(endPoint).toString();
  // log(url);
  return MultipartRequest('POST', Uri.parse(url));
}

Future<void> sendMultiPartRequest(MultipartRequest multiPartRequest, {Function(dynamic)? onSuccess, Function(dynamic)? onError}) async {
  http.Response response = await http.Response.fromStream(await multiPartRequest.send());
  apiPrint(
      url: multiPartRequest.url.toString(), headers: jsonEncode(multiPartRequest.headers), request: jsonEncode(multiPartRequest.fields), hasRequest: true, statusCode: response.statusCode, responseBody: response.body.trim(), methodtype: "MultiPart");
  // log("Result: ${response.statusCode} - ${multiPartRequest.fields}");
  // log(response.body.trim());
  if (response.statusCode.isSuccessful()) {
    onSuccess?.call(response.body.trim());
  } else {
    onError?.call(errorSomethingWentWrong);
  }
}

Future<List<MultipartFile>> getMultipartImages({required List<PlatformFile> files, required String name}) async {
  List<MultipartFile> multiPartRequest = [];

  await Future.forEach<PlatformFile>(files, (element) async {
    int i = files.indexOf(element);

    multiPartRequest.add(await MultipartFile.fromPath('$name[${i.toString()}]', element.path.validate()));
  });

  return multiPartRequest;
}

Future<List<MultipartFile>> getMultipartImages2({required List<XFile> files, required String name}) async {
  List<MultipartFile> multiPartRequest = [];

  await Future.forEach<XFile>(files, (element) async {
    int i = files.indexOf(element);

    multiPartRequest.add(await MultipartFile.fromPath('$name[${i.toString()}]', element.path.validate()));
    log('MultipartFile: $name[${i.toString()}]');
  });

  return multiPartRequest;
}

String parseStripeError(String response) {
  try {
    var body = jsonDecode(response);
    return parseHtmlString(body['error']['message']);
  } on Exception catch (e) {
    log(e);
    throw errorSomethingWentWrong;
  }
}

void apiPrint({
  String url = "",
  String endPoint = "",
  String headers = "",
  String request = "",
  int statusCode = 0,
  String responseBody = "",
  String methodtype = "",
  bool hasRequest = false,
  bool fullLog = false,
}) {
  if (fullLog) {
    dev.log("┌───────────────────────────────────────────────────────────────────────────────────────────────────────");
    dev.log("\u001b[93m Url: \u001B[39m $url");
    dev.log("\u001b[93m endPoint: \u001B[39m \u001B[1m$endPoint\u001B[22m");
    dev.log("\u001b[93m header: \u001B[39m \u001b[96m$headers\u001B[39m");
    if (hasRequest) {
      dev.log('\u001b[93m Request: \u001B[39m \u001b[95m$request\u001B[39m');
    }
    dev.log(statusCode.isSuccessful() ? "\u001b[32m" : "\u001b[31m");
    dev.log('Response ($methodtype) $statusCode: $responseBody');
    dev.log("\u001B[0m");
    dev.log("└───────────────────────────────────────────────────────────────────────────────────────────────────────");
  } else {
    log("┌───────────────────────────────────────────────────────────────────────────────────────────────────────");
    log("\u001b[93m Url: \u001B[39m $url");
    log("\u001b[93m endPoint: \u001B[39m \u001B[1m$endPoint\u001B[22m");
    log("\u001b[93m header: \u001B[39m \u001b[96m$headers\u001B[39m");
    if (hasRequest) {
      log('\u001b[93m Request: \u001B[39m \u001b[95m$request\u001B[39m');
    }
    log(statusCode.isSuccessful() ? "\u001b[32m" : "\u001b[31m");
    log('Response ($methodtype) $statusCode: ${formatJson(responseBody)}');
    log("\u001B[0m");
    log("└───────────────────────────────────────────────────────────────────────────────────────────────────────");
  }
}

String formatJson(String jsonStr) {
  try {
    final dynamic parsedJson = jsonDecode(jsonStr);
    const formatter = JsonEncoder.withIndent('  ');
    return formatter.convert(parsedJson);
  } on Exception catch (e) {
    dev.log("\x1b[31m formatJson error ::-> ${e.toString()} \x1b[0m");
    return jsonStr;
  }
}
