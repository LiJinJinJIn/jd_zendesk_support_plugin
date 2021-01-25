package com.jd.jd_zendesk_support_plugin

import android.app.Activity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import zendesk.core.AnonymousIdentity
import zendesk.core.Identity
import zendesk.core.JwtIdentity
import zendesk.core.Zendesk
import zendesk.support.Support
import zendesk.support.guide.HelpCenterActivity
import zendesk.support.guide.ViewArticleActivity
import zendesk.support.request.RequestActivity

/** FlutterPluginDemoPlugin */
class JdZendeskSupportPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "jd_zendesk_support_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "init" -> {
                val zendeskUrl = call.argument<String>("zendeskUrl") ?: ""
                val applicationId = call.argument<String>("applicationId") ?: ""
                val oauthClientId = call.argument<String>("oauthClientId") ?: ""
                val userIdentifier = call.argument<String>("userIdentifier") ?: ""

                //1.Zendes SDK
                Zendesk.INSTANCE.init(activity, zendeskUrl, applicationId, oauthClientId)

                //2.Support SDK init
                Support.INSTANCE.init(Zendesk.INSTANCE)

                //3.setIdentity
                val identity: Identity = JwtIdentity(userIdentifier)
                Zendesk.INSTANCE.setIdentity(identity)
            }

            "helpCenter" -> {
                val articlesForCategoryIds = call.argument<Long>("articlesForCategoryIds") ?: 0L
                val deviceType = call.argument<String>("deviceType") ?: ""
                val versionName = call.argument<String>("versionName") ?: ""
                val categoriesCollapsed = call.argument<Boolean>("categoriesCollapsed") ?: false
                val contactUsButtonVisible = call.argument<Boolean>("contactUsButtonVisible")
                        ?: true
                val showConversationsMenuButton = call.argument<Boolean>("showConversationsMenuButton")
                        ?: true

                val requestConfig =
                        RequestActivity.builder()
                                .withTags(deviceType, versionName).config()

                HelpCenterActivity.builder()
                        .withCategoriesCollapsed(categoriesCollapsed)
                        .withContactUsButtonVisible(contactUsButtonVisible)
                        .withShowConversationsMenuButton(showConversationsMenuButton)
                        .withArticlesForCategoryIds(articlesForCategoryIds)
                        .show(activity, requestConfig)

            }

            "showArticle" -> {
                val articleId = call.argument<Long>("articleId") ?: 0L
                val deviceType = call.argument<String>("deviceType") ?: ""
                val versionName = call.argument<String>("versionName") ?: ""

                val requestConfig =
                        RequestActivity.builder()
                                .withTags(deviceType, versionName).config()


                ViewArticleActivity.builder(articleId).show(activity, requestConfig)

            }

            "signOut" -> {
                Zendesk.INSTANCE.setIdentity(AnonymousIdentity())
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

}
