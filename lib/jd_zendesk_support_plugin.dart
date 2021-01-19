
import 'dart:async';

import 'package:flutter/services.dart';

class JdZendeskSupportPlugin {
  static const MethodChannel _channel =
      const MethodChannel('jd_zendesk_support_plugin');

  //初始化设置
  Future<void> init({String zendeskUrl, String applicationId, String oauthClientId, String userIdentifier}) async {
    await _channel.invokeMethod('init', <String, dynamic>{
      'zendeskUrl': zendeskUrl,
      'applicationId': applicationId,
      'oauthClientId': oauthClientId,
      'userIdentifier': userIdentifier,
    });
  }

  //打开帮助中心
  Future<void> helpCenter(
      {int articlesForCategoryIds,
        String deviceType,
        String versionName,
        bool categoriesCollapsed,
        bool contactUsButtonVisible,
        bool showConversationsMenuButton}) async {
    await _channel.invokeMethod('helpCenter', <String, dynamic>{
      'articlesForCategoryIds': articlesForCategoryIds,
      'deviceType': deviceType,
      'versionName': versionName,
      'categoriesCollapsed': categoriesCollapsed,
      'contactUsButtonVisible': contactUsButtonVisible,
      'showConversationsMenuButton': showConversationsMenuButton,
    });
  }


  //退出登录
  Future<dynamic> signOut() async {
    return await _channel.invokeMethod('signOut');
  }
}
