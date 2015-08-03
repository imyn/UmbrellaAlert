import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   // var pushQuery: PFQuery = PFInstallation.query()!

    
    
  
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    Parse.enableLocalDatastore()
    
    //Initialize Parse
    Parse.setApplicationId("BvAKFBhFItle1pttKMJihqppvQnXg1uoDLoqS7Ra", clientKey: "qnD9m9qcoRQndta2U24pZ5PnzcD14FD7EUNfsFxm")
    
    var userNotificationTypes: UIUserNotificationType = (UIUserNotificationType.Alert|UIUserNotificationType.Badge|UIUserNotificationType.Sound)
                
    var settings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
                
    application.registerUserNotificationSettings(settings)
    application.registerForRemoteNotifications()
    
    return true

    }
    
func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var currentInstallation: PFInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.channels = ["global"]
        currentInstallation.saveInBackground()
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject: AnyObject]) {
        PFPush.handlePush(userInfo)
    }
    

   
    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
      
    }

    func applicationWillEnterForeground(application: UIApplication) {
       
    }

    func applicationDidBecomeActive(application: UIApplication) {
       
    }

    func applicationWillTerminate(application: UIApplication) {
        
    }


}

