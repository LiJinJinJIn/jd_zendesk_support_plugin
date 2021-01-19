import 'package:flutter/material.dart';
import 'package:jd_zendesk_support_plugin/jd_zendesk_support_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  JdZendeskSupportPlugin _flutterPlugin = JdZendeskSupportPlugin();

  var _token = "";
  var _zendeskUrl = "";
  var _applicationId = "";
  var _oauthClientId = "";
  var _articlesForCategoryIds = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  ///初始化项目
  void initPlatformState() async {
    _flutterPlugin.init(
      zendeskUrl: _zendeskUrl,
      applicationId: _applicationId,
      oauthClientId: _oauthClientId,
      userIdentifier: _token,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('测试插件'),
        ),
        body: Center(
          child: InkWell(
            child: Container(
              width: 200,
              height: 100,
              alignment: Alignment.center,
              color: Colors.red,
              child: Text('帮助中心'),
            ),
            onTap: () {
              openHelpCenter();
            },
          ),
        ),
      ),
    );
  }

  ///打开帮助中心
  void openHelpCenter() async {
    await _flutterPlugin.helpCenter(articlesForCategoryIds: _articlesForCategoryIds);
  }
}
