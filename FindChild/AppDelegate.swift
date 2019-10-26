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
        return true
    }
}

