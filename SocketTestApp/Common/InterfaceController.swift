//
//  InterfaceController.swift
//  SocketTestApp
//
//  Created by Инсаф Мухаметшин on 18.08.2018.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit

class InterfaceController: NSObject {
    let window: UIWindow
    static let shared = InterfaceController()
    
    override init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        super.init()
    }
    
    func openInitialScreen() {
        let tabBarController = UINavigationController(rootViewController: ChartViewController())
        window.rootViewController = tabBarController
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }
    
}
