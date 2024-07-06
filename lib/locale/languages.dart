import 'package:flutter/material.dart';

abstract class BaseLanguage {
  static BaseLanguage of(BuildContext context) => Localizations.of<BaseLanguage>(context, BaseLanguage)!;

  String get language;

  String get tokenExpired;

  String get badRequest;

  String get forbidden;

  String get pageNotFound;

  String get tooManyRequests;

  String get internalServerError;

  String get badGateway;

  String get serviceUnavailable;

  String get gatewayTimeout;

  String get hey;

  String get hello;

  String get thisFieldIsRequired;

  String get contactNumber;

  String get gallery;

  String get camera;

  String get editProfile;

  String get update;

  String get confirm;

  String get reload;

  String get address;

  String get viewAll;

  String get pressBackAgainToExitApp;

  String get invalidUrl;

  String get cancel;

  String get delete;

  String get deleteAccountConfirmation;

  String get taxIncluded;

  String get demoUserCannotBeGrantedForThis;

  String get somethingWentWrong;

  String get yourInternetIsNotWorking;

  String get profileUpdatedSuccessfully;

  String get searchHere;

  String get file;

  String get bookNow;

  String get selectYourPet;

  String get addPetInfo;

  String get additionalInfo;

  String get accept;

  String get rating;

  String get wouldYouLikeToSetProfilePhotoAsEmployee;

  String get wouldYouLikeToSetPictureAs;

  String get sProfilePicture;

  String get yourOldPasswordDoesnT;

  String get yourNewPasswordDoesnT;

  String get findBestporosenocheckAround;

  String get letUsGiveThem;

  String get youCanFindNearEasily;

  String get petSittersWhoAre;

  String get bookingStatus;

  String get schedule;

  String get price;

  String get location;

  String get yes;

  String get cancelBooking;

  String get doYouCancelThisBooking;

  String get noBookingsFound;

  String get thereAreCurrentlyNo;

  String get customerInformation;

  String get date;

  String get time;

  String get petName;

  String get reason;

  String get bookingDetail;

  String get duration;

  String get bookingInformation;

  String get bookingFor;

  String get paymentStatus;

  String get paymentDetails;

  String get total;

  String get rate;

  String get yourReview;

  String get yourFeedbackWillImprove;

  String get writeYourFeedbackHere;

  String get submit;

  String get pleaseSelectRatings;

  String get additionalFacility;

  String get noFacility;

  String get thereAreCurrentlyNoFacilities;

  String get breed;

  String get about;

  String get title;

  String get noteFor;

  String get writeHere;

  String get addAddress;

  String get save;

  String get firstName;

  String get lastName;

  String get writeAddressHere;

  String get pinCode;

  String get changePassword;

  String get yourNewPasswordMust;

  String get password;

  String get newPassword;

  String get confirmNewPassword;

  String get email;

  String get mainStreet;

  String get forgetPassword;

  String get toResetYourNew;

  String get myPets;

  String get addPet;

  String get looksLikeYouHavenT;

  String get addYourFirstPet;

  String get addYourPet;

  String get stayTunedNoNew;

  String get noNewNotificationsAt;

  String get findANewPetForYou;

  String get joinAndDiscoverYour;

  String get signIn;

  String get explore;

  String get pleaseTypeTheVerification;

  String get verify;

  String get donTReceivedACode;

  String get pleaseResend;

  String get profile;

  String get editPet;

  String get gender;

  String get birthday;

  String get weight;

  String get notesFor;

  String get addNote;

  String get noNewNotes;

  String get thereAreCurrentlyNoNotes;

  String get settings;

  String get rateApp;

  String get aboutApp;

  String get logout;

  String get selectAddress;

  String get defaultAddress;

  String get otherAddress;

  String get rememberMe;

  String get forgotPassword;

  String get notAMember;

  String get registerNow;

  String get createYourAccount;

  String get createYourAccountFor;

  String get signUp;

  String get alreadyHaveAnAccount;

  String get yourPasswordHasBeen;

  String get youCanNowLog;

  String get done;

  String get blogs;

  String get choosePetSitter;

  String get chooseService;

  String get petStore;

  String get upcomingAppointment;

  String get event;

  String get blogDetail;

  String get blogList;

  String get eventDetail;

  String get eventList;

  String get editPetInfo;

  String get itAppearsTheAdmin;

  String get youCanUtilizeThe;

  String get sendRequestToAdmin;

  String get petBreed;

  String get chooseBreed;

  String get next;

  String get oopsYouHavenTUploaded;

  String get youCanEnjoyOur;

  String get confirmBooking;

  String get iHaveReadAll;

  String get pleaseAcceptTermsAnd;

  String get chooseYourPet;

  String get boarding;

  String get book;

  String get dropOffAddress;

  String get boarder;

  String get chooseBoarder;

  String get additionalInformation;

  String get pleaseSelectPet;

  String get dropOffDate;

  String get dropOffTime;

  String get oopsItSeemsYouVe;

  String get pickupDate;

  String get pleaseSelectDropOff;

  String get pleaseSelectDropOffTime;

  String get pleaseSelectValidDrop;

  String get pickupTime;

  String get yourAppointmentHasBeen;

  String get addToGoogleCalendar;

  String get goToBookings;

  String get daycare;

  String get daycareTaker;

  String get chooseDaycareTaker;

  String get pleaseSelectDateFirst;

  String get pleaseMakeSureTo;

  String get oopsItSeemsYouVePickupTime;

  String get favoriteFood;

  String get favoriteActivity;

  String get otherMedicalReport;

  String get addFiles;

  String get grooming;

  String get service;

  String get groomer;

  String get chooseGroomer;

  String get payment;

  String get choosePaymentMethod;

  String get payNow;

  String get confirmPayment;

  String get razorPayIsNot;

  String get creditCardOrDebitCard;

  String get razorPay;

  String get cashAfterService;

  String get training;

  String get chooseTraining;

  String get trainer;

  String get chooseTrainer;

  String get pleaseChooseDuration;

  String get veterinaryType;

  String get chooseVeterinaryType;

  String get vet;

  String get chooseVet;

  String get veterinary;

  String get dropoffPickupAddress;

  String get walker;

  String get chooseWalker;

  String get walking;

  String get skip;

  String get home;

  String get bookings;

  String get booking;

  String get deleteAccount;

  String get size;

  String get qty;

  String get rateThisProduct;

  String get myCart;

  String get productDetails;

  String get discount;

  String get discountCoupon;

  String get applyCoupon;

  String get subtotal;

  String get choosePayment;

  String get addCard;

  String get noOnlinePaymentIs;

  String get placeOrder;

  String get creditCard;

  String get orderDetail;

  String get orderId;

  String get dowanloadInvoice;

  String get orderDate;

  String get shippingAddress;

  String get aboutProduct;

  String get printTShirtFor;

  String get dog;

  String get quality;

  String get paymentInformation;

  String get continueHopping;

  String get yourOrders;

  String get myWishlist;

  String get totalItems;

  String get bookSitter;

  String get petSitter;

  String get allReview;

  String get ourMostLoveChewTreats;

  String get enterPincode;

  String get check;

  String get deliveryOptions;

  String get foodPacketSize;

  String get quantity;

  String get ratingAndReviews;

  String get shopByCategory;

  String get shop;

  String get sNotes;

  String get eG;

  String get groomingFor;

  String get merry;

  String get doe;

  String get welcomeBackToThe;

  String get care;

  String get welcomeToThe;

  String get howS;

  String get healthGoingOn;

  String get In;

  String get height;

  String get reminder;

  String get organizerDetail;

  String get uploadPetProfilePhoto;

  String get bulldog;

  String get searchForBreed;

  String get searchForBoarder;

  String get selectDate;

  String get selectTime;

  String get yourPetAppointmentIs;

  String get yourBookingIdIs;

  String get eWillBe;

  String get searchForDaycareTaker;

  String get fish;

  String get playWithBall;

  String get searchForTraining;

  String get searchForTrainer;

  String get searchForVeterinary;

  String get searchForService;

  String get searchForVet;

  String get fever;

  String get searchForWalker;

  String get searchForGroomer;

  String get doYouWantToLogout;

  String get appTheme;

  String get year;

  String get age;

  String get noBlogsFound;

  String get thereAreNoBlogs;

  String get noEventsFound;

  String get thereAreNoEvents;

  String get noDataFound;

  String get totalAmount;

  String get review;

  String get to;

  String get upcomingEvents;

  String get guest;

  String get notifications;

  String get chooseYourConvenientPayment;

  String get areYouSureYou;

  String get chooseLanguage;

  String get veterinarian;

  String get newUpdate;

  String get anUpdateTo;

  String get isAvailableGoTo;

  String get later;

  String get closeApp;

  String get updateNow;

  String get serviceInformation;

  String get serviceDescription;

  String get zoomVideoCall;

  String get discoverPetCareExcellence;

  String get empowerYourPetSWellness;

  String get unleashPetHappinessWith;

  String get exploreAWorldOf;

  String get elevateYourPetSWellBeing;

  String get elevateYourPetSJoy;

  String get medicalReport;

  String get loading;

  String get arrivalTime;

  String get leaveTime;

  String get facilityListIsEmpty;

  String get theFacilityListIs;

  String get durationListIsEmpty;

  String get theDurationListIs;

  String get areYouSureWantDeleteNote;

  String get ohNoAreYouLeaving;

  String get areYouSureWant;

  String get doYouConfirmThisBooking;

  String get payWithFlutterwave;

  String get transactionFailed;

  String get transactionCancelled;

  String get paystack;

  String get flutterWave;

  String get cashPayment;

  String get thisItemIsNot;

  String get filterBy;

  String get reset;

  String get category;

  String get productBrands;

  String get searchBrand;

  String get more;

  String get inclusiveOfAllTaxes;

  String get doYouConfirmThisPayment;

  String get stripe;

  String get signInFailed;

  String get userCancelled;

  String get appleSigninIsNot;

  String get eventStatus;

  String get eventAddedSuccessfully;

  String get readMore;

  String get readLess;

  String get female;

  String get pleaseSelectService;

  String get male;

  String get pleaseSelectVeterinaryType;

  String get bookingCancelSuccessfully;

  String get youHaveSuccessfullyAdded;

  String get app;

  String get notRegistered;

  String get signInWithGoogle;

  String get signInWithApple;

  String get orSignInWith;

  String get pawlcomeToYourPetSHaven;

  String get unlockAWorldOf;

  String get daycareTakerListIsEmpty;

  String get thereAreNoDaycare;

  String get walkerListIsEmpty;

  String get thereAreNoWalkers;

  String get veterinaryTypeListIs;

  String get thereAreNoVeterinary;

  String get serviceListIsEmpty;

  String get thereAreNoServices;

  String get vetListIsEmpty;

  String get thereAreNoVeterinarians;

  String get trainingListIsEmpty;

  String get thereAreNoTraining;

  String get trainerListIsEmpty;

  String get thereAreNoTrainers;

  String get groomerListIsEmpty;

  String get thereAreNoGroomers;

  String get boarderListIsEmpty;

  String get thereAreNoBoarders;

  String get order;

  String get ohNoYouAreLeaving;

  String get chooseYourConvenientPaymentOptions;

  String get oldPassword;

  String get breedListIsEmpty;

  String get thereAreNoBreeds;

  String get oldAndNewPassword;

  String get selectBirthday;

  String get personalizeYourProfile;

  String get petProfileDetails;

  String get addYourPetInformation;

  String get themeAndMore;

  String get showSomeLoveShare;

  String get privacyPolicyTerms;

  String get securelyLogOutOfAccount;

  String get off;

  String get areYouSureYouWantRemove;

  String get remove;

  String get cart;

  String get yourCartIsEmpty;

  String get productPriceDetails;

  String get noProductsFound;

  String get yourFavouriteProductsWill;

  String get deliveryStatus;

  String get shippingDetail;

  String get alternativeContactNumber;

  String get cancelOrder;

  String get doYouWantToCancelOrder;

  String get noOrdersFound;

  String get thereAreNoOrders;

  String get priceDetails;

  String get totalTaxAmount;

  String get deliveryCharge;

  String get edit;

  String get deleteReview;

  String get doYouWantToDeleteReview;

  String get no;

  String get addReview;

  String get addPhoto;

  String get ratingIsRequired;

  String get customerDetail;

  String get fullName;

  String get alternateContactNumber;

  String get thankYouForReview;

  String get selectUpToThreeImages;

  String get noDetailsFound;

  String get theOrderHasBeen;

  String get orders;

  String get confirmOrder;

  String get orderSuccessfullyPlaced;

  String get yourOrderHasBeen;

  String get yourOrderIdIs;

  String get orderSummary;

  String get productReviews;

  String get noReviewsFound;

  String get thanksForVoting;

  String get brand;

  String get ratings;

  String get noRatingsYet;

  String get totalReviewsAndRatings;

  String get noDetailFound;

  String get noCategoryFound;

  String get featuredProducts;

  String get outOfStock;

  String get atThisTimeThere;

  String get pending;

  String get completed;

  String get confirmed;

  String get cancelled;

  String get rejected;

  String get reject;

  String get processing;

  String get delivered;

  String get placed;

  String get inProgress;

  String get enterYourReview;

  String get myAddresses;

  String get country;

  String get selectCountry;

  String get state;

  String get selectState;

  String get city;

  String get selectCity;

  String get addressLine;

  String get apt;

  String get saveChanges;

  String get setAsPrimary;

  String get seeYourOrders;

  String get manageYourAddresses;

  String get oppsLooksLikeYou;

  String get addNewAddress;

  String get primary;

  String get deliverHere;

  String get areYouSureYouWantToDeleteThisAddress;

  String get weAreNotShipping;

  String get byCreatingAAccountYou;

  String get termsOfService;

  String get goToCart;

  String get addToCart;

  String get successfully;

  String get petProfileUpdate;

  String get proceed;

  String get deliveredOn;

  String get tax;

  String get bestSellerProduct;

  String get dealsForYou;

  String get allCategories;

  String get discountedAmount;

  String get productRemoveToWishlist;

  String get productAddedToWishlist;

  String get addressDeleteSuccessfully;

  String get thereAreCurrentlyNoItemsInYourCart;

  String get thereAreCurrentlyNoItemsInYourWishlist;

  String get petEvents;

  String get doYouWantToAddEvent;

  String get noDashboardData;

  String get thereIsSomethingMight;

  String get searchProducts;

  String get bookAgain;

  String get doYouWantToBookThisBooking;

  String get paid;

  String get clearAll;

  String get areYouSureWantTORemoveNotification;

  String get notificationDeleted;

  String get areYouSureWantToClearAll;

  String get newBooking;

  String get completeBooking;

  String get rejectBooking;

  String get acceptBooking;

  String get forgetEmailPassword;

  String get orderPlaced;

  String get orderPending;

  String get orderProcessing;

  String get orderDelivered;

  String get orderCancelled;

  String get noBookingDetailsFound;

  String get thereAreCurrentlyNoDetails;

  String get bookingId;

  String get tryReloadOrCheckingLater;

  String get doYouWantToRemoveNotification;

  String get doYouWantToClearAllNotification;

  String get doYouWantToCancelBooking;

  String get doYouWantToRemoveThisItem;

  String get statusListIsEmpty;

  String get thereAreNoStatus;

  String get filters;

  String get clearFilter;

  String get bookingTime;

  String get apply;

  String get optional;

  String get iHaveReadAllDetailFillFormOrder;

  String get orderStatus;

  String get orderTime;

  String get searchBookings;

  String get searchForStatus;

  String get readTime;

  String get min;

  String get number;

  String get youMayAlsoLike;

  String get lbl;

  String get locationPermissionDenied;

  String get permisionDeniedPermanently;

  String get enableLocation;

  String get nearBy;

  String get distance;

  String get showNearby;

  String get milesAway;

  String get pleaseSelectAnItem;

  String get administratorHasDeactivatedThis;

  String get petSitters;

  String get hasNotSharedTheir;

  String get hasNotSharedTheirEmail;

  String get aboutEmployee;

  String get personalInfo;

  String get expertise;

  String get paymentSuccess;

  String get redirectingToBookings;

  String get pleaseCheckThePayment;

  String get transactionIsInProcess;

  String get enterYourMsisdnHere;

  String get walkerIsCurrentlyNot;

  String get rescheduleBooking;

  String get ambiguous;

  String get success;

  String get incorrectPin;

  String get exceedsWithdrawalAmountLimit;

  String get inProcess;

  String get transactionTimedOut;

  String get notEnoughBalance;

  String get refused;

  String get doNotHonor;

  String get transactionNotPermittedTo;

  String get transactionIdIsInvalid;

  String get errorWhileFetchingEncryption;

  String get transactionExpired;

  String get doYouWantTo;

  String get invalidAmount;

  String get transactionNotFound;

  String get successfullyFetchedEncryptionKey;

  String get theTransactionIsStill;

  String get transactionIsSuccessful;

  String get incorrectPinHasBeen;

  String get theUserHasExceeded;

  String get theAmountUserIs;

  String get userDidnTEnterThePin;

  String get transactionInPendingState;

  String get userWalletDoesNot;

  String get theTransactionWasRefused;

  String get encryptionKeyHasBeen;

  String get transactionHasBeenExpired;

  String get payeeIsAlreadyInitiated;

  String get theTransactionWasNot;

  String get thisIsAGeneric;

  String get theTransactionWasTimed;

  String get xSignatureAndPayloadDid;

  String get couldNotFetchEncryption;

  String get doYouWantToRemoveThisReview;

  String get reschedule;

  String get sorryUserCannotSignin;

  String get iAgreeToThe;

  String get noteYourSelectedService;

  String get petNotes;

  String get seePetProfile;

  String get employeeInformation;

  String get name;

  String get designation;

  String get petInformation;

  String get failed;

  String get doYouWantTurnOffNearByEvents;

  String get doYouWantSeeYourNearByEvents;

  String get setAsPrivateNote;

  String get soldBy;

  String get billingAddress;

  String get otherItemsInProduct;

  String get grandTotal;
}
