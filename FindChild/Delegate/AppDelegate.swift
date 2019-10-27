//
//  AppDelegate.swift
//  FindChild
//
//  Created by Артем Стратиенко on 26/10/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import UIKit
import NMAKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    
   // reg info
      let registrationData =
          (appId: "7T8UgnMEkQDNCeJH182A",
           appCode: "wfyqs2ZxyVaiTgdkqDnIcQ",
           licenseKey: "jeIu9BLuTcfoEU507jgaDsvT4HIbNtw2sQIRP/m79HmG30JoZpv76clpwwvF4H8+ka7/cNq0a7+T91YmPCjG7w+sFJQ5vXbcw4c0aI3/7rn0tl0SsWjl4qY2RKbjgRVl2mYNHZKTOSyknknHR0ECTFKL3WOs8EYpTM4DBAnrhtmGvUDK0CK/s5uKT1uqf1UJ+ggj2GrXJMp9dfxmQJFPDtPBeZj8tUdE7nH+nV4+xiVQkFKCpu27pk/+m8j8x6LggIuPRqRu7bzpTwifcKgwoyRdcCySRvrVU1AUoC1L+jRxkUe/3AKnPpd0v7rNe2sHcZ+Jahqp2l7NwP0TTl/ck/w7Ire45k0ekVv7FQBUCENDi4eAFqJm0BrHIczDOSZVryfmnvPkCv7QF1pcEMNsl/n/vK21wKyPsg9k4CrlJF+xcz9f+xVNNdjSDQb23crYF3NJ+auVc/4AVtPMl0/TbfCTcJZWAh9QX4kQsN37uGCjqt1GTpI7A6nAMNbVLLJCIjhMDAALW7nYGvvDzCu4tNr6gONWCo1MPezWk+U9+GSrdYff9DML5yZRiGkf7ohxTJP5GnvS4+cu1SsSd/ck3LZl9ukpsI8uXsxIRsF6qGynfiFwkRQ9TBAeaWxT2tDg5PaK1Lp6tdjbUzxc/lafF8PpYZWkQgkkpP6a1J/CA+s="
      )
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       NMAApplicationContext.setAppId(registrationData.appId, appCode: registrationData.appCode, licenseKey: registrationData.licenseKey)
//    let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "CustomLaunchScreen", bundle: nil)
//    let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "LaunchScreenViewController") as! LaunchScreenViewController
//    self.window = UIWindow(frame: UIScreen.main.bounds)
//    self.window?.rootViewController = initialViewControlleripad
//    self.window?.makeKeyAndVisible()
       return true
   }
   
    @available(iOS 13.0, *)
   func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
          // Called when a new scene session is being created.
          // Use this method to select a configuration to create the new scene with.
          return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
      }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
          // Called when the user discards a scene session.
          // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
          // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
      }
    
}

