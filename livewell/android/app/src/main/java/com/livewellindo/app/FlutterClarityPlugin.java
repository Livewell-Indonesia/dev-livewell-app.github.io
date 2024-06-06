package com.rahulbansal89.flutter_clarity;

import androidx.annotation.NonNull;
import java.util.*;
import android.content.Context;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import com.microsoft.clarity.Clarity;
import com.microsoft.clarity.ClarityConfig;
import com.microsoft.clarity.models.ApplicationFramework;
import com.microsoft.clarity.models.LogLevel;

/** FlutterClarityPlugin */
public class FlutterClarityPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_clarity");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "initialize":
        // Android does not support showing the share sheet at a particular point on screen.
        String projectId = call.argument("projectId");
        String userId = call.argument("userId");
        String logLevel = call.argument("logLevel");
        Boolean allowMeteredNetworkUsage = call.argument("allowMeteredNetworkUsage");
        Boolean enableWebViewCapture = call.argument("enableWebViewCapture");
        List<String> allowedDomains = call.argument("allowedDomains");
        ClarityConfig config = new ClarityConfig(
    "<ProjectId>",
    null, // Default user id
    LogLevel.None,
    false, // Disallow metered network usage
    true, // Enable web view capturing
    Collections.singletonList("*"), // Allowed domains
    ApplicationFramework.Native,
    Collections.emptyList(), // Allowed activities
    Collections.emptyList(), // Disallowed activities (ignore activities)
    false, // Disable on low-end devices
    null // Maximum allowed daily network usage in MB (null = unlimited)
   );
        Clarity.initialize(context, config);
        result.success(null);
        break;
      case "setCustomUserId":
        String customUserId = call.argument("customUserId");
        Clarity.setCustomUserId(customUserId);
        result.success(null);
        break;
      case "getCurrentSessionId":
        result.success(Clarity.getCurrentSessionId());
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}