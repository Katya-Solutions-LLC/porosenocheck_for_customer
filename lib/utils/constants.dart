// ignore_for_file: constant_identifier_names

import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';
import 'package:porosenocheck/main.dart';

import '../screens/dashboard/dashboard_res_model.dart';

const DEFAULT_QUANTITY = '1';
const PERMISSION_STATUS = 'permissionStatus';
const LATITUDE = 'LATITUDE';
const LONGITUDE = 'LONGITUDE';
const CURRENT_ADDRESS = 'CURRENT_ADDRESS';
const IS_ADMIN = 'admin';
const UNKNOWN = 'Unknown';

class Constants {
  static const perPageItem = 20;
  static var labelTextSize = 15;
  static var googleMapPrefix = 'https://www.google.com/maps/search/?api=1&query=';
  static const DEFAULT_EMAIL = 'john@gmail.com';
  static const DEFAULT_PASS = '12345678';
  static const appLogoSize = 98.0;
  static const DECIMAL_POINT = 2;
}

//region DateFormats
class DateFormatConst {
  static const DD_MM_YY = "dd-MM-yy"; //TODO Use to show only in UI
  static const MMMM_D_yyyy = "MMMM d, y"; //TODO Use to show only in UI
  static const D_MMMM_yyyy = "d MMMM, y"; //TODO Use to show only in UI
  static const D_MMM_yyyy = "d MMM y"; //TODO Use to show only in UI
  static const MMMM_D_yyyy_At_HH_mm_a = "MMMM d, y @ hh:mm a"; //TODO Use to show only in UI
  static const EEEE_D_MMMM_At_HH_mm_a = "EEEE d MMMM @ hh:mm a"; //TODO Use to show only in UI
  static const dd_MMM_yyyy_HH_mm_a = "dd MMM y, hh:mm a"; //TODO Use to show only in UI
  static const yyyy_MM_dd_HH_mm = 'yyyy-MM-dd HH:mm';
  static const yyyy_MM_dd = 'yyyy-MM-dd';
  static const HH_mm12Hour = 'hh:mm a';
  static const HH_mm24Hour = 'HH:mm';
}
//endregion

//region THEME MODE TYPE
const THEME_MODE_LIGHT = 0;
const THEME_MODE_DARK = 1;
const THEME_MODE_SYSTEM = 2;
//endregion

//region LOGIN TYPE
class LoginTypeConst {
  static const LOGIN_TYPE_USER = 'user';
  static const LOGIN_TYPE_GOOGLE = 'google';
  static const LOGIN_TYPE_APPLE = 'apple';
  static const LOGIN_TYPE_OTP = 'mobile';
}
//endregion

//region SharedPreference Keys
class SharedPreferenceConst {
  static const IS_LOGGED_IN = 'IS_LOGGED_IN';
  static const USER_DATA = 'USER_LOGIN_DATA';
  static const USER_EMAIL = 'USER_EMAIL';
  static const USER_PASSWORD = 'USER_PASSWORD';
  static const FIRST_TIME = 'FIRST_TIME';
  static const IS_REMEMBER_ME = 'IS_REMEMBER_ME';
  static const USER_NAME = 'USER_NAME';
  static const AUTO_SLIDER_STATUS = 'AUTO_SLIDER_STATUS';
}
//endregion

const USER_NOT_CREATED = "User not created";

class UserKeys {
  static String firstName = 'first_name';
  static String lastName = 'last_name';
  static String userType = 'user_type';
  static String username = 'username';
  static String email = 'email';
  static String password = 'password';
  static String mobile = 'mobile';
  static String address = 'address';
  static String displayName = 'display_name';
  static String profileImage = 'profile_image';
  static String oldPassword = 'old_password';
  static String newPassword = 'new_password';
  static String playerId = 'player_id';
  static String loginType = 'login_type';
  static String contactNumber = 'contact_number';
}

//region CacheConst Keys
class APICacheConst {
  static const DASHBOARD_RESPONSE = 'HOME_SCREEN_RESPONSE';
  static const STATUS_RESPONSE = 'STATUS_RESPONSE';
  static const ABOUT_RESPONSE = 'ABOUT_RESPONSE';
  static const APP_CONFIGURATION_RESPONSE = 'APP_CONFIGURATION_RESPONSE';
  static const PET_TYPES = 'PET_TYPES';
  static const PET_CENTER_RESPONSE = 'PET_CENTER_RESPONSE';
}

//set Them

class SettingsLocalConst {
  static const THEME_MODE = 'THEME_MODE';
}
//endregion

//region CacheConst Keys
class ServicesKeyConst {
  static const boarding = 'boarding';
  static const veterinary = 'veterinary';
  static const grooming = 'grooming';
  static const walking = 'walking';
  static const training = 'training';
  static const dayCare = 'daycare';

  ///video-consultancy key
  static const videoConsultancyId = 19;
  static const videoConsultancyName = 'Video Consultancy';
}
//endregion

//region CacheConst Keys
class EmployeeKeyConst {
  static const boarding = 'boarder';
  static const veterinary = 'vet';
  static const grooming = 'groomer';
  static const walking = 'walker';
  static const training = 'trainer';
  static const dayCare = 'day_taker';
  static const petSitter = 'pet_sitter';
}
//endregion

//region Status
class StatusConst {
  static const pending = 'pending';
  static const upcoming = 'upcoming';
  static const confirmed = 'confirmed';
  static const completed = 'completed';
  static const reject = 'reject';
  static const cancel = 'cancel';
  static const inprogress = 'inprogress';
}

//endregion
//region Status
class NotificationConst {
  static const newBooking = 'new_booking';
  static const completeBooking = 'complete_booking';
  static const rejectBooking = 'reject_booking';
  static const acceptBooking = 'accept_booking';
  static const cancelBooking = 'cancel_booking';
  static const changePassword = 'change_password';
  static const forgetEmailPassword = 'forget_email_password';
  static const orderPlaced = 'order_placed';
  static const orderPending = 'order_pending';
  static const orderAccepted = 'order_accepted';
  static const orderProcessing = 'order_proccessing';
  static const orderDelivered = 'order_delivered';
  static const orderCancelled = 'order_cancelled';
  static const booking = 'booking';
  static const shop = 'shop';
}

class FirebaseTopicConst{
//region Firebase Notification
static const additionalDataKey = 'additional_data';
static const notificationGroupKey = 'notification_group';
static const shopKey = 'shop';
static const orderCodeKey = 'order_code';
static const bookingServicesNameKey = 'booking_services_names';
static const idKey = 'id';
static const itemIdKey = 'item_id';

static const notificationKey = 'Notification';

static const onMessageListen= "Error On Message Listen";
static const onMessageOpened="Error On Message Opened App";
static const onGetInitialMessage='Error On Get Initial Message';

static const messageDataCollapseKey='MessageData Collapse Key';

static const messageDataMessageIdKey='MessageData Message Id';

static const messageDataMessageTypeKey='MessageData Type';
static const userWithUnderscoreKey = 'user_';
static const notificationDataKey = 'Notification Data';

static const fcmNotificationTokenKey = 'FCM Notification Token';
static const apnsNotificationTokenKey = 'APNS Notification Token';
static const notificationErrorKey = 'Notification Error';
static const notificationTitleKey = 'Notification Title';
static const notificationBodyKey = 'Notification Body';
static const backgroundChannelIdKey='background_channel';
static const backgroundChannelNameKey='background_channel';

static const notificationChannelIdKey='notification';
static const notificationChannelNameKey='Notification';

static const topicSubscribed='topic-----subscribed---->';

static const topicUnSubscribed='topic-----UnSubscribed---->';

//endregion
}

//endregion
class OrderStatus {
  static const OrderPlaced = 'order_placed';
  static const Pending = 'pending';
  static const Accepted = 'accepted';
  static const Processing = 'processing';
  static const Delivered = 'delivered';
  static const Cancelled = 'cancelled';
  static const Accept = 'accept';
}

//region BOOKING STATUS
class BookingStatusConst {
  static const COMPLETED = 'completed';
  static const PENDING = 'pending';
  static const CONFIRMED = 'confirmed';
  static const CHECK_IN = 'check_in';
  static const CHECKOUT = 'checkout';
  static const CANCELLED = 'cancelled';
}
//endregion

//region ORDER STATUS
class OrderStatusConst {
  static const ORDER_PLACED = 'order_placed';
  static const PENDING = 'pending';
  static const PROCESSING = 'processing';
  static const DELIVERED = 'delivered';
  static const CANCELLED = 'cancelled';
}
//endregion

//region Status
class PriceStatusConst {
  static const pending = 'pending';
  static const upcoming = 'upcoming';
  static const confirmed = 'confirmed';
  static const cancel = 'cancel';
}
//endregion

//region TaxType Keys
class TaxType {
  static const FIXED = 'fixed';
  static const PERCENT = 'percent';
}
//endregion

//region PaymentStatus
class PaymentStatus {
  static const PAID = 'paid';
  static const pending = 'pending';
  static const failed = 'failed';
}
//endregion

//region Gender TYPE
class GenderTypeConst {
  static const MALE = 'male';
  static const FEMALE = 'female';
}
//endregion

//region PaymentMethods Keys
class PaymentMethods {
  static const PAYMENT_METHOD_CASH = 'cash';
  static const PAYMENT_METHOD_STRIPE = 'stripe';
  static const PAYMENT_METHOD_RAZORPAY = 'razorpay';
  static const PAYMENT_METHOD_PAYPAL = 'paypal';
  static const PAYMENT_METHOD_PAYSTACK = 'paystack';
  static const PAYMENT_METHOD_FLUTTER_WAVE = 'flutterwave';
  static const PAYMENT_METHOD_AIRTEL = 'airtel';
  static const PAYMENT_METHOD_PHONEPE = 'phonepe';
  static const PAYMENT_METHOD_MIDTRANS = 'midtrans';
}
//endregion

Country get defaultCountry {
  return Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 91,
    geographic: true,
    level: 1,
    name: 'India',
    example: '23456789',
    displayName: 'India (IN) [+91]',
    displayNameNoCountryCode: 'India (IN)',
    e164Key: '91-IN-0',
    fullExampleWithPlusSign: '+919123456789',
  );
}

Rx<UnitModel> defaulHEIGHT = UnitModel.fromJson({
  "id": 1,
  "name": "cm",
  "type": "PET_HEIGHT_UNIT",
  "value": "CM",
  "sequence": 0,
  "status": 1,
}).obs;

Rx<UnitModel> defaulWEIGHT = UnitModel.fromJson({
  "id": 2,
  "name": "kg",
  "type": "PET_WEIGHT_UNIT",
  "value": "KG",
  "sequence": 0,
  "status": 1,
}).obs;

// Currency position

//endregion

//region Currency position
class CurrencyPosition {
  static const CURRENCY_POSITION_LEFT = 'left';
  static const CURRENCY_POSITION_RIGHT = 'right';
  static const CURRENCY_POSITION_LEFT_WITH_SPACE = 'left_with_space';
  static const CURRENCY_POSITION_RIGHT_WITH_SPACE = 'right_with_space';
}

//endregion
class ProductModelKey {
  static String productId = 'product_id';
  static String employeeId = 'employee_id';
  static String cartId = 'cart_id';
  static String productVariationId = 'product_variation_id';
  static String qty = 'qty';
  static String reviewId = 'review_id';
  static String isLike = 'is_like';
  static String isDislike = 'dislike_like';
  static String locationId = 'location_id';
}

class ShippingDeliveryType {
  static String regular = 'regular';
}

// region AirtelMoney Const
class AirtelMoneyResponseCodes {
  static const AMBIGUOUS = "DP00800001000";
  static const SUCCESS = "DP00800001001";
  static const INCORRECT_PIN = "DP00800001002";
  static const LIMIT_EXCEEDED = "DP00800001003";
  static const INVALID_AMOUNT = "DP00800001004";
  static const INVALID_TRANSACTION_ID = "DP00800001005";
  static const IN_PROCESS = "DP00800001006";
  static const INSUFFICIENT_BALANCE = "DP00800001007";
  static const REFUSED = "DP00800001008";
  static const DO_NOT_HONOR = "DP00800001009";
  static const TRANSACTION_NOT_PERMITTED = "DP00800001010";
  static const TRANSACTION_TIMED_OUT = "DP00800001024";
  static const TRANSACTION_NOT_FOUND = "DP00800001025";
  static const FORBIDDEN = "DP00800001026";
  static const FETCHED_ENCRYPTION_KEY_SUCCESSFULLY = "DP00800001027";
  static const ERROR_FETCHING_ENCRYPTION_KEY = "DP00800001028";
  static const TRANSACTION_EXPIRED = "DP00800001029";
}

(String, String) getAirtelMoneyReasonTextFromCode(String code) {
  switch (code) {
    case AirtelMoneyResponseCodes.AMBIGUOUS:
      return (locale.value.ambiguous, locale.value.theTransactionIsStill);
    case AirtelMoneyResponseCodes.SUCCESS:
      return (locale.value.success, locale.value.transactionIsSuccessful);
    case AirtelMoneyResponseCodes.INCORRECT_PIN:
      return (locale.value.incorrectPin, locale.value.incorrectPinHasBeen);
    case AirtelMoneyResponseCodes.LIMIT_EXCEEDED:
      return (locale.value.exceedsWithdrawalAmountLimit, locale.value.theUserHasExceeded);
    case AirtelMoneyResponseCodes.INVALID_AMOUNT:
      return (locale.value.invalidAmount, locale.value.theAmountUserIs);
    case AirtelMoneyResponseCodes.INVALID_TRANSACTION_ID:
      return (locale.value.transactionIdIsInvalid, locale.value.userDidnTEnterThePin);
    case AirtelMoneyResponseCodes.IN_PROCESS:
      return (locale.value.inProcess, locale.value.transactionInPendingState);
    case AirtelMoneyResponseCodes.INSUFFICIENT_BALANCE:
      return (locale.value.notEnoughBalance, locale.value.userWalletDoesNot);
    case AirtelMoneyResponseCodes.REFUSED:
      return (locale.value.refused, locale.value.theTransactionWasRefused);
    case AirtelMoneyResponseCodes.DO_NOT_HONOR:
      return (locale.value.doNotHonor, locale.value.thisIsAGeneric);
    case AirtelMoneyResponseCodes.TRANSACTION_NOT_PERMITTED:
      return (locale.value.transactionNotPermittedTo, locale.value.payeeIsAlreadyInitiated);
    case AirtelMoneyResponseCodes.TRANSACTION_TIMED_OUT:
      return (locale.value.transactionTimedOut, locale.value.theTransactionWasTimed);
    case AirtelMoneyResponseCodes.TRANSACTION_NOT_FOUND:
      return (locale.value.transactionNotFound, locale.value.theTransactionWasNot);
    case AirtelMoneyResponseCodes.FORBIDDEN:
      return (locale.value.forbidden, locale.value.xSignatureAndPayloadDid);
    case AirtelMoneyResponseCodes.FETCHED_ENCRYPTION_KEY_SUCCESSFULLY:
      return (locale.value.successfullyFetchedEncryptionKey, locale.value.encryptionKeyHasBeen);
    case AirtelMoneyResponseCodes.ERROR_FETCHING_ENCRYPTION_KEY:
      return (locale.value.errorWhileFetchingEncryption, locale.value.couldNotFetchEncryption);
    case AirtelMoneyResponseCodes.TRANSACTION_EXPIRED:
      return (locale.value.transactionExpired, locale.value.transactionHasBeenExpired);
    default:
      return (locale.value.somethingWentWrong, locale.value.somethingWentWrong);
  }
}
//endregion AirtelMoney
