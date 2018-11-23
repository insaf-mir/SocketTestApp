//
//  AppDelegate.swift
//  SocketTestApp
//
//  Created by Инсаф Мухаметшин on 18.08.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit
import SciChart

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let interfaceController = InterfaceController.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = interfaceController.window
        interfaceController.openInitialScreen()
        registerCharts()
        return true
    }
    
    func registerCharts() {
        SCIChartSurface.setRuntimeLicenseKey(ChartAccessKey)
    }
}

