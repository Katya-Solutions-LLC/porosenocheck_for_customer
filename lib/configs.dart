// ignore_for_file: constant_identifier_names
import 'package:firebase_core/firebase_core.dart';

const APP_NAME = 'Porosenocheck';
const APP_LOGO_URL = '$DOMAIN_URL/img/logo/mini_logo.png';
const DEFAULT_LANGUAGE = 'en';
const GREEK_LANGUAGE = 'el';
const DASHBOARD_AUTO_SLIDER_SECOND = 5;

///Live Url
const DOMAIN_URL = "https://apps.iqonic.design/pawlly";

const BASE_URL = '$DOMAIN_URL/api/';

//Airtel Money Payments
///It Supports ["UGX", "NGN", "TZS", "KES", "RWF", "ZMW", "CFA", "XOF", "XAF", "CDF", "USD", "XAF", "SCR", "MGA", "MWK"]
const airtel_currency_code = "MWK";
const airtel_country_code = "MW";
const AIRTEL_BASE = 'https://openapiuat.airtel.africa/'; //Test Url
// const AIRTEL_BASE = 'https://openapi.airtel.africa/'; // Live Url

//region STRIPE
const STRIPE_URL = 'https://api.stripe.com/v1/payment_intents';
const STRIPE_merchantIdentifier = "merchant.flutter.stripe.test";
const STRIPE_MERCHANT_COUNTRY_CODE = 'IN';
const STRIPE_CURRENCY_CODE = 'INR';
//endregion

const APP_PLAY_STORE_URL = 'https://play.google.com/store/apps/details?id=com.porosenocheck.customer';
const APP_APPSTORE_URL = 'https://apps.apple.com/in/app/porosenocheck';

const TERMS_CONDITION_URL = '$DOMAIN_URL/page/terms-conditions';
const PRIVACY_POLICY_URL = '$DOMAIN_URL/page/privacy-policy';
const INQUIRY_SUPPORT_EMAIL = 'support@rechain.email';

/// You can add help line number here for contact. It's demo number
const HELP_LINE_NUMBER = '+79152568965';

///firebase configs
const FirebaseOptions firebaseConfig = FirebaseOptions(
  appId: "1:170165120225:ios:6dcf71b86309fbf6d35ba0",
  apiKey: 'AIzaSyAFbseD2-IHcICbd95NWTsxf1Qn9fkxkE8',
  projectId: 'porosenocheck-52801',
  messagingSenderId: '170165120225',
  storageBucket: 'porosenocheck-52801.appspot.com',
  iosBundleId: 'com.porosenocheck.customer',
);
