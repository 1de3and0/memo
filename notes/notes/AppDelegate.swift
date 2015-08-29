//
//  AppDelegate.swift
//  notes
//
//  Created by Hidemi Ando on 2015/07/19.
//  Copyright (c) 2015年 Hidemi Ando. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    //アプリケーションを起動する時に呼ばれるメソッド
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
    
        
        // viewConrollerを生成.　Xcode上のviewConrollerを作る。
        let myViewController = ViewController()
        
        // navigationControllerを生成.
        let navigationController = UINavigationController(rootViewController: myViewController)
        
        
        // windowを生成.　画面を作るための下地？
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // rootViewControllerにnavigationControllerを設定.
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
        
        return true
    }

 

}

