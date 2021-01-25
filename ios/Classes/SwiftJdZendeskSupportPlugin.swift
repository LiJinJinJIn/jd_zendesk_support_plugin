import Flutter
import UIKit
import SupportSDK
import ZendeskCoreSDK
import MessagingSDK

//处理zendesk 在ios原生模块的调用
public class SwiftJdZendeskSupportPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "jd_zendesk_support_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftJdZendeskSupportPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method{
      case "init":
        
          guard let dic = call.arguments as? Dictionary<String, Any> else { return }
          let zendeskUrl = dic["zendeskUrl"] as? String ?? ""
          let applicationId = dic["applicationId"] as? String ?? ""
          let oauthClientId = dic["oauthClientId"] as? String ?? ""
          let userIdentifier = dic["userIdentifier"] as? String ?? ""
 
          Zendesk.initialize(appId: applicationId, clientId: oauthClientId, zendeskUrl: zendeskUrl)
          Support.initialize(withZendesk: Zendesk.instance)
          
          let ident = Identity.createJwt(token: userIdentifier)
          Zendesk.instance?.setIdentity(ident)
          
      case "helpCenter":
          guard let dic = call.arguments as? Dictionary<String, Any> else { return }
          let articlesForCategoryIds = dic["articlesForCategoryIds"] as? NSNumber ?? 0
          let deviceType = dic["deviceType"] as? String ?? ""
          let versionName = dic["versionName"] as? String ?? ""
          
          let requestConfig = RequestUiConfiguration()
          requestConfig.tags = [deviceType,versionName]
           
          let hcConfig = HelpCenterUiConfiguration()
          hcConfig.showContactOptions = true
          hcConfig.groupType = .category
          hcConfig.groupIds = [articlesForCategoryIds]
          let helpCenter = HelpCenterUi.buildHelpCenterOverviewUi(withConfigs: [hcConfig,requestConfig])
          
          let rootViewController:UIViewController! = UIApplication.shared.keyWindow?.rootViewController
          if (rootViewController is UINavigationController) {
              (rootViewController as! UINavigationController).pushViewController(helpCenter, animated:true)
          }else {
              let navigationController:UINavigationController! = UINavigationController(rootViewController:helpCenter)
              rootViewController.present(navigationController, animated:true, completion:nil)
          }
    
      case "showArticle":
        guard let dic = call.arguments as? Dictionary<String, Any> else { return }
        let articleId = dic["articleId"] as? NSNumber ?? 0
        let deviceType = dic["deviceType"] as? String ?? ""
        let versionName = dic["versionName"] as? String ?? ""
        
        let requestConfig = RequestUiConfiguration()
        requestConfig.tags = [deviceType,versionName]
        
        let articleController = HelpCenterUi.buildHelpCenterArticleUi(withArticleId: articleId.stringValue, andConfigs: [requestConfig])
    

        let rootViewController:UIViewController! = UIApplication.shared.keyWindow?.rootViewController
        if (rootViewController is UINavigationController) {
            (rootViewController as! UINavigationController).pushViewController(articleController, animated:true)
        }else {
            let navigationController:UINavigationController! = UINavigationController(rootViewController:articleController)
            rootViewController.present(navigationController, animated:true, completion:nil)
        }
        
      case "signOut":
          Zendesk.instance?.setIdentity(Identity.createAnonymous())
      default:
          break;
      }
    }
  }
