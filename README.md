# jd_zendesk_support_plugin

flutter plug-in, compatible with zendesk's ios and android functions

## Getting Started



```
​```
初始化方法：

//指定首页url地址，appid信息，client认证信息，用户token认证信息
 _flutterPlugin.init(
      zendeskUrl: _zendeskUrl,
      applicationId: _applicationId,
      oauthClientId: _oauthClientId,
      userIdentifier: _token,
    );
    
打开帮助中心：

//打开指定的id文章页面，此外可以指定渠道以及版本信息绑定
_flutterPlugin.helpCenter(articlesForCategoryIds: _articlesForCategoryIds);

​```
```

