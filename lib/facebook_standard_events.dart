import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const channelName =
    "com.halloglobal.facebook_standard_events/facebook_standard_events";

class FacebookStandardEvents {
  static const MethodChannel _channel = const MethodChannel(channelName);

  Future<void> logEvent(
      {@required String name,
      Map<String, dynamic> parameters,
      double valueToSum}) {
    final args = {
      'name': name,
      'parameters': parameters,
      '_valueToSum': valueToSum,
    };
    return _channel.invokeMethod<void>('logEvent', _filterOutNulls(args));
  }

  Future<void> logAchieveLevelEvent(String level) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_ACHIEVED_LEVEL,
        parameters: {AppEventsConstants.EVENT_PARAM_LEVEL: level});
  }

  Future<void> logActivateAppEvent() {
    return logEvent(name: AppEventsConstants.EVENT_NAME_ACTIVATED_APP);
  }

  Future<void> logAdClickEvent(String adType) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_ACTIVATED_APP,
        parameters: {AppEventsConstants.EVENT_PARAM_AD_TYPE: adType});
  }

  Future<void> logAdImpressionEvent(String adType) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_AD_IMPRESSION,
        parameters: {AppEventsConstants.EVENT_PARAM_AD_TYPE: adType});
  }

  Future<void> logAddPaymentInfoEvent(bool success) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_ADDED_PAYMENT_INFO,
        parameters: {AppEventsConstants.EVENT_PARAM_SUCCESS: success});
  }

  Future<void> logAddToCartEvent(String contentData, String contentId,
      String contentType, String currency, double price) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_ADDED_TO_CART,
        parameters: {
          AppEventsConstants.EVENT_PARAM_CONTENT: contentData,
          AppEventsConstants.EVENT_PARAM_CONTENT_ID: contentId,
          AppEventsConstants.EVENT_PARAM_CONTENT_TYPE: contentType,
          AppEventsConstants.EVENT_PARAM_CURRENCY: price
        });
  }

  Future<void> logAddToWishlistEvent(String contentData, String contentId,
      String contentType, String currency, double price) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_ADDED_TO_WISHLIST,
        parameters: {
          AppEventsConstants.EVENT_PARAM_CONTENT: contentData,
          AppEventsConstants.EVENT_PARAM_CONTENT_ID: contentId,
          AppEventsConstants.EVENT_PARAM_CONTENT_TYPE: contentType,
          AppEventsConstants.EVENT_PARAM_CURRENCY: price
        });
  }

  Future<void> logCompleteRegistrationEvent(String registrationMethod) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_COMPLETED_REGISTRATION,
        parameters: {
          AppEventsConstants.EVENT_PARAM_REGISTRATION_METHOD: registrationMethod
        });
  }

  Future<void> logCompleteTutorialEvent(String contentData, String contentId,
      bool success,) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_COMPLETED_TUTORIAL,
        parameters: {
          AppEventsConstants.EVENT_PARAM_CONTENT: contentData,
          AppEventsConstants.EVENT_PARAM_CONTENT_ID: contentId,
          AppEventsConstants.EVENT_PARAM_SUCCESS: success,
        });
  }

  Future<void> logContactEvent(String contentData, String contentId,
      bool success,) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_CONTACT);
  }

  Future<void> logCustomizeProductEvent(String contentData, String contentId,
      bool success,) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_CUSTOMIZE_PRODUCT);
  }

  Future<void> logFindLocationEvent(String contentData, String contentId,
      bool success,) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_FIND_LOCATION);
  }

  Future<void> logInitiatedCheckoutEvent(String contentData, String contentId,
      String contentType, int numItems, String paymentInfoAvailable, String currency, double totalPrice) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_INITIATED_CHECKOUT,
        parameters: {
          AppEventsConstants.EVENT_PARAM_CONTENT: contentData,
          AppEventsConstants.EVENT_PARAM_CONTENT_ID: contentId,
          AppEventsConstants.EVENT_PARAM_CONTENT_TYPE: contentType,
          AppEventsConstants.EVENT_PARAM_CURRENCY: currency,
          AppEventsConstants.EVENT_PARAM_PAYMENT_INFO_AVAILABLE: paymentInfoAvailable,
          AppEventsConstants.EVENT_PARAM_NUM_ITEMS: numItems,
        },valueToSum: totalPrice);
  }

  Future<void> logRateEvent(String contentData, String contentId,
      String contentType, int maxRatingValue, double ratingGiven) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_INITIATED_CHECKOUT,
        parameters: {
          AppEventsConstants.EVENT_PARAM_CONTENT: contentData,
          AppEventsConstants.EVENT_PARAM_CONTENT_ID: contentId,
          AppEventsConstants.EVENT_PARAM_CONTENT_TYPE: contentType,
          AppEventsConstants.EVENT_PARAM_MAX_RATING_VALUE: maxRatingValue
        },valueToSum: ratingGiven);
  }

  Future<void> logScheduleEvent(){
      return logEvent(name: AppEventsConstants.EVENT_NAME_SCHEDULE);
  }

  Future<void> logSearchEvent(String contentData, String contentId,
      String contentType, String searchString, bool success) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_SEARCHED,
        parameters: {
          AppEventsConstants.EVENT_PARAM_CONTENT: contentData,
          AppEventsConstants.EVENT_PARAM_CONTENT_ID: contentId,
          AppEventsConstants.EVENT_PARAM_CONTENT_TYPE: contentType,
          AppEventsConstants.EVENT_PARAM_SEARCH_STRING: searchString,
          AppEventsConstants.EVENT_PARAM_SUCCESS: success
        });
  }

  Future<void> logSpendCreditsEvent(String contentData, String contentId,
      String contentType, double totalValue) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_SPENT_CREDITS,
        parameters: {
          AppEventsConstants.EVENT_PARAM_CONTENT: contentData,
          AppEventsConstants.EVENT_PARAM_CONTENT_ID: contentId,
          AppEventsConstants.EVENT_PARAM_CONTENT_TYPE: contentType
        }, valueToSum: totalValue);
  }

  Future<void> logStartTrialEvent(String orderId, String currency, double price) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_START_TRIAL,
        parameters: {
          AppEventsConstants.EVENT_PARAM_ORDER_ID: orderId,
          AppEventsConstants.EVENT_PARAM_CURRENCY: currency,
        }, valueToSum: price);
  }

  Future<void> logSubmitApplicationEvent(){
      return logEvent(name: AppEventsConstants.EVENT_NAME_SUBMIT_APPLICATION);
  }

  Future<void> logSubscribeEvent(String orderId, String currency, double price) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_SUBSCRIBE,
        parameters: {
          AppEventsConstants.EVENT_PARAM_ORDER_ID: orderId,
          AppEventsConstants.EVENT_PARAM_CURRENCY: currency,
        }, valueToSum: price);
  }

  Future<void> logUnlockAchievementEvent(String description) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_UNLOCKED_ACHIEVEMENT,
        parameters: {
          AppEventsConstants.EVENT_PARAM_DESCRIPTION: description,
        });
  }

  Future<void> logViewContentEvent(String contentData, String contentId,
      String contentType, String currency, double price) {
    return logEvent(
        name: AppEventsConstants.EVENT_NAME_VIEWED_CONTENT,
        parameters: {
          AppEventsConstants.EVENT_PARAM_CONTENT: contentData,
          AppEventsConstants.EVENT_PARAM_CONTENT_ID: contentId,
          AppEventsConstants.EVENT_PARAM_CONTENT_TYPE: contentType,
          AppEventsConstants.EVENT_PARAM_CURRENCY: currency
        },valueToSum: price);
  }

  Future<void> logPurchaseEvent(double purchaseAmount, String currency, Map<String,dynamic> parameters){
    final args = {
      'purchaseAmount': purchaseAmount,
      'parameters': parameters,
      'currency': currency
    };
      return _channel.invokeMethod('logPurchaseEvent', args);
  }

  /// Creates a new map containing all of the key/value pairs from [parameters]
  /// except those whose value is `null`.
  Map<String, dynamic> _filterOutNulls(Map<String, dynamic> parameters) {
    final Map<String, dynamic> filtered = <String, dynamic>{};
    parameters.forEach((String key, dynamic value) {
      if (value != null) {
        filtered[key] = value;
      }
    });
    return filtered;
  }
}

// ignore_for_file: non_constant_identifier_names
class AppEventsConstants {
  static final String EVENT_NAME_ACTIVATED_APP = "fb_mobile_activate_app";
  static final String EVENT_NAME_DEACTIVATED_APP = "fb_mobile_deactivate_app";
  static final String EVENT_NAME_SESSION_INTERRUPTIONS = "fb_mobile_app_interruptions";
  static final String EVENT_NAME_TIME_BETWEEN_SESSIONS = "fb_mobile_time_between_sessions";
  static final String EVENT_NAME_COMPLETED_REGISTRATION = "fb_mobile_complete_registration";
  static final String EVENT_NAME_VIEWED_CONTENT = "fb_mobile_content_view";
  static final String EVENT_NAME_SEARCHED = "fb_mobile_search";
  static final String EVENT_NAME_RATED = "fb_mobile_rate";
  static final String EVENT_NAME_COMPLETED_TUTORIAL = "fb_mobile_tutorial_completion";
  static final String EVENT_NAME_PUSH_TOKEN_OBTAINED = "fb_mobile_obtain_push_token";
  static final String EVENT_NAME_ADDED_TO_CART = "fb_mobile_add_to_cart";
  static final String EVENT_NAME_ADDED_TO_WISHLIST = "fb_mobile_add_to_wishlist";
  static final String EVENT_NAME_INITIATED_CHECKOUT =
      "fb_mobile_initiated_checkout";
  static final String EVENT_NAME_ADDED_PAYMENT_INFO =
      "fb_mobile_add_payment_info";
  static final String EVENT_NAME_PURCHASED = "fb_mobile_purchase";
  static final String EVENT_NAME_ACHIEVED_LEVEL = "fb_mobile_level_achieved";
  static final String EVENT_NAME_UNLOCKED_ACHIEVEMENT =
      "fb_mobile_achievement_unlocked";
  static final String EVENT_NAME_SPENT_CREDITS = "fb_mobile_spent_credits";
  static final String EVENT_NAME_CONTACT = "Contact";
  static final String EVENT_NAME_CUSTOMIZE_PRODUCT = "CustomizeProduct";
  static final String EVENT_NAME_NONATE = "Donate";
  static final String EVENT_NAME_FIND_LOCATION = "FindLocation";
  static final String EVENT_NAME_SCHEDULE = "Schedule";
  static final String EVENT_NAME_START_TRIAL = "StartTrial";
  static final String EVENT_NAME_SUBMIT_APPLICATION = "SubmitApplication";
  static final String EVENT_NAME_SUBSCRIBE = "Subscribe";
  static final String EVENT_NAME_AD_IMPRESSION = "AdImpression";
  static final String EVENT_NAME_AD_CLICK = "AdClick";
  static final String EVENT_NAME_LIVE_STREAMING_START =
      "fb_sdk_live_streaming_start";
  static final String EVENT_NAME_LIVE_STREAMING_STOP =
      "fb_sdk_live_streaming_stop";
  static final String EVENT_NAME_LIVE_STREAMING_PAUSE =
      "fb_sdk_live_streaming_pause";
  static final String EVENT_NAME_LIVE_STREAMING_RESUME =
      "fb_sdk_live_streaming_resume";
  static final String EVENT_NAME_LIVE_STREAMING_ERROR =
      "fb_sdk_live_streaming_error";
  static final String EVENT_NAME_LIVE_STREAMING_UPDATE_STATUS =
      "fb_sdk_live_streaming_update_status";
  static final String EVENT_NAME_PRODUCT_CATALOG_UPDATE =
      "fb_mobile_catalog_update";
  static final String EVENT_PARAM_LIVE_STREAMING_PREV_STATUS =
      "live_streaming_prev_status";
  static final String EVENT_PARAM_LIVE_STREAMING_STATUS =
      "live_streaming_status";
  static final String EVENT_PARAM_LIVE_STREAMING_ERROR = "live_streaming_error";
  static final String EVENT_PARAM_CURRENCY = "fb_currency";
  static final String EVENT_PARAM_REGISTRATION_METHOD =
      "fb_registration_method";
  static final String EVENT_PARAM_CONTENT_TYPE = "fb_content_type";
  static final String EVENT_PARAM_CONTENT = "fb_content";
  static final String EVENT_PARAM_CONTENT_ID = "fb_content_id";
  static final String EVENT_PARAM_SEARCH_STRING = "fb_search_string";
  static final String EVENT_PARAM_SUCCESS = "fb_success";
  static final String EVENT_PARAM_MAX_RATING_VALUE = "fb_max_rating_value";
  static final String EVENT_PARAM_PAYMENT_INFO_AVAILABLE =
      "fb_payment_info_available";
  static final String EVENT_PARAM_NUM_ITEMS = "fb_num_items";
  static final String EVENT_PARAM_LEVEL = "fb_level";
  static final String EVENT_PARAM_DESCRIPTION = "fb_description";
  static final String EVENT_PARAM_SOURCE_APPLICATION =
      "fb_mobile_launch_source";
  static final String EVENT_PARAM_VALUE_YES = "1";
  static final String EVENT_PARAM_VALUE_NO = "0";
  static final String EVENT_PARAM_AD_TYPE = "ad_type";
  static final String EVENT_PARAM_ORDER_ID = "fb_order_id";
  static final String EVENT_PARAM_VALUE_TO_SUM = "_valueToSum";
  static final String EVENT_PARAM_PRODUCT_CUSTOM_LABEL_0 =
      "fb_product_custom_label_0";
  static final String EVENT_PARAM_PRODUCT_CUSTOM_LABEL_1 =
      "fb_product_custom_label_1";
  static final String EVENT_PARAM_PRODUCT_CUSTOM_LABEL_2 =
      "fb_product_custom_label_2";
  static final String EVENT_PARAM_PRODUCT_CUSTOM_LABEL_3 =
      "fb_product_custom_label_3";
  static final String EVENT_PARAM_PRODUCT_CUSTOM_LABEL_4 =
      "fb_product_custom_label_4";
  static final String EVENT_PARAM_PRODUCT_CATEGORY = "fb_product_category";
  static final String EVENT_PARAM_PRODUCT_APPLINK_IOS_URL =
      "fb_product_applink_ios_url";
  static final String EVENT_PARAM_PRODUCT_APPLINK_IOS_APP_STORE_ID =
      "fb_product_applink_ios_app_store_id";
  static final String EVENT_PARAM_PRODUCT_APPLINK_IOS_APP_NAME =
      "fb_product_applink_ios_app_name";
  static final String EVENT_PARAM_PRODUCT_APPLINK_IPHONE_URL =
      "fb_product_applink_iphone_url";
  static final String EVENT_PARAM_PRODUCT_APPLINK_IPHONE_APP_STORE_ID =
      "fb_product_applink_iphone_app_store_id";
  static final String EVENT_PARAM_PRODUCT_APPLINK_IPHONE_APP_NAME =
      "fb_product_applink_iphone_app_name";
  static final String EVENT_PARAM_PRODUCT_APPLINK_IPAD_URL =
      "fb_product_applink_ipad_url";
  static final String EVENT_PARAM_PRODUCT_APPLINK_IPAD_APP_STORE_ID =
      "fb_product_applink_ipad_app_store_id";
  static final String EVENT_PARAM_PRODUCT_APPLINK_IPAD_APP_NAME =
      "fb_product_applink_ipad_app_name";
  static final String EVENT_PARAM_PRODUCT_APPLINK_ANDROID_URL =
      "fb_product_applink_android_url";
  static final String EVENT_PARAM_PRODUCT_APPLINK_ANDROID_PACKAGE =
      "fb_product_applink_android_package";
  static final String EVENT_PARAM_PRODUCT_APPLINK_ANDROID_APP_NAME =
      "fb_product_applink_android_app_name";
  static final String EVENT_PARAM_PRODUCT_APPLINK_WINDOWS_PHONE_URL =
      "fb_product_applink_windows_phone_url";
  static final String EVENT_PARAM_PRODUCT_APPLINK_WINDOWS_PHONE_APP_ID =
      "fb_product_applink_windows_phone_app_id";
  static final String EVENT_PARAM_PRODUCT_APPLINK_WINDOWS_PHONE_APP_NAME =
      "fb_product_applink_windows_phone_app_name";
}
