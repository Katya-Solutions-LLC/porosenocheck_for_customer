import 'package:nb_utils/nb_utils.dart';

import '../../../models/base_response_model.dart';
import '../../../network/network_utils.dart';
import '../../../utils/api_end_points.dart';
import '../../../utils/constants.dart';
import '../model/address_models/address_list_response.dart';
import '../model/address_models/city_list_response.dart';
import '../model/address_models/country_list_response.dart';
import '../model/address_models/logistic_zone_response.dart';
import '../model/address_models/state_list_response.dart';

class UserAddressesApis {
  /* static Future<RegUserResp> createUser({required Map request}) async {
    return RegUserResp.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.register, request: request, method: HttpMethodType.POST)));
  } */

  static Future<List<UserAddress>> getAddressList({
    int page = 1,
    var perPage = Constants.perPageItem,
    required List<UserAddress> addressList,
    Function(bool)? lastPageCallBack,
  }) async {
    var res = AddressListResponse.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getAddressList}?per_page=$perPage&page=$page", method: HttpMethodType.GET)));

    if (page == 1) addressList.clear();
    addressList.addAll(res.userAddress.validate());

    lastPageCallBack?.call(res.userAddress.validate().length != perPage);

    return addressList;
  }

  static Future<BaseResponseModel> removeAddress({required int addressId}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.removeAddress}?id=$addressId', method: HttpMethodType.GET)));
  }

  static Future<BaseResponseModel> addEditAddress({required Map request, bool isEdit = false}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(isEdit ? APIEndPoints.editAddress : APIEndPoints.addAddress, request: request, method: HttpMethodType.POST)));
  }

  static Future<List<CountryData>> getCountryList() async {
    var res = CountryListResponse.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.countryList, method: HttpMethodType.GET)));

    return res.data.validate();
  }

  static Future<List<StateData>> getStateList({required int countryId}) async {
    var res = StateListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.stateList}?country_id=$countryId', method: HttpMethodType.GET)));

    return res.data.validate();
  }

  static Future<List<CityData>> getCityList({required int stateId}) async {
    var res = CityListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.cityList}?state_id=$stateId', method: HttpMethodType.GET)));

    return res.data.validate();
  }

  static Future<List<LogisticZoneData>> getLogisticZone({required int addressId}) async {
    var res = LogisticZoneResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.getLogisticZoneList}?address_id=$addressId', method: HttpMethodType.GET)));
    return res.data.validate();
  }
}
