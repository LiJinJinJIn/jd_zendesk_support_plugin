import 'dart:async';

import 'package:flutter/services.dart';

class JdZendeskSupportPlugin {
  static const MethodChannel _channel = const MethodChannel('jd_zendesk_support_plugin');

  ///初始化设置
  Future<void> init({String zendeskUrl, String applicationId, String oauthClientId, String userIdentifier}) async {
    await _channel.invokeMethod('init', <String, dynamic>{
      'zendeskUrl': zendeskUrl,
      'applicationId': applicationId,
      'oauthClientId': oauthClientId,
      'userIdentifier': userIdentifier,
    });
  }

  ///打开帮助中心
  ///相关展示控件可不用配置信息，使用默认值均可
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

  ///打开指定的文章
  ///展示固定的文章信息
  Future<void> showArticle({int articleId, String deviceType, String versionName}) async {
    await _channel.invokeMethod('showArticle', <String, dynamic>{
      'articleId': articleId,
      'deviceType': deviceType,
      'versionName': versionName,
    });
  }

  ///退出登录
  Future<dynamic> signOut() async {
    return await _channel.invokeMethod('signOut');
  }
}
