package com.halloglobal.facebook_standard_events

import android.os.Bundle
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import com.facebook.appevents.AppEventsLogger
import com.facebook.appevents.AppEventsConstants
import java.math.BigDecimal
import java.util.*

class FacebookStandardEventsPlugin(registrar: Registrar): MethodCallHandler {
  var appEventsLogger: AppEventsLogger = AppEventsLogger.newLogger(registrar.context())

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "com.halloglobal.facebook_standard_events/facebook_standard_events")
      channel.setMethodCallHandler(FacebookStandardEventsPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method){
      "logEvent" -> handleLogEvent(call,result)
      "logPurchaseEvent" -> handlePurchaseLogEvent(call,result)
      else -> result.notImplemented()
    }
  }

  private fun handleLogEvent(call: MethodCall, result: Result) {
    val eventName = call.argument("name") as? String
    val parameters = call.argument("parameters") as? Map<String, Object>
    val valueToSum = call.argument("_valueToSum") as? Double

    if (valueToSum != null && parameters != null) {
      val parameterBundle = createBundleFromMap(parameters)
      appEventsLogger.logEvent(eventName, valueToSum, parameterBundle)
    } else if (valueToSum != null) {
      appEventsLogger.logEvent(eventName, valueToSum)
    } else if (parameters != null) {
      val parameterBundle = createBundleFromMap(parameters)
      appEventsLogger.logEvent(eventName, parameterBundle)
    } else {
      appEventsLogger.logEvent(eventName)
    }

    result.success(null)
  }

  private fun handlePurchaseLogEvent(call: MethodCall, result: Result) {
    val purchaseAmount = call.argument("purchaseAmount") as? Double
    val parameters = call.argument("parameters") as? Map<String, Object>
    val currency = call.argument("currency") as? String

    appEventsLogger.logPurchase(BigDecimal.valueOf(purchaseAmount!!), Currency.getInstance(currency), createBundleFromMap(parameters))

    result.success(null)
  }
  
  private fun createBundleFromMap(parameterMap: Map<String, Any>?): Bundle? {
    if (parameterMap == null) {
      return null
    }

    val bundle = Bundle()
    for (jsonParam in parameterMap.entries) {
      val value = jsonParam.value
      val key = jsonParam.key
      if (value is String) {
        bundle.putString(key, value)
      } else if (value is Int) {
        bundle.putInt(key, value)
      } else if (value is Long) {
        bundle.putLong(key, value)
      } else if (value is Double) {
        bundle.putDouble(key, value)
      } else if (value is Boolean) {
        bundle.putBoolean(key, value)
      } else if (value is Map<*, *>) {
        val nestedBundle = createBundleFromMap(value as Map<String, Any>)
        bundle.putBundle(key, nestedBundle as Bundle)
      } else {
        throw IllegalArgumentException(
                "Unsupported value type: " + value.javaClass.kotlin)
      }
    }
    return bundle
  }
}
