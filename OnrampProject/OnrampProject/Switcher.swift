//
//  Switcher.swift
//  OnrampProject
//
//  Created by Bart on 3/5/20.
//

import Foundation
import UIKit

class Switcher {
    
    // MARK: Update root view controller based on Auth response.
    @available(iOS 13.0, *)
    static func sceneUpdateRootVC() {
        
        print("updateRootVC()")
        
        let isAuth = UserDefaults.standard.bool(forKey: "isAuth")
        var rootVC: UIViewController?
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
          return
        }
        
        if isAuth {
            let storyboard = UIStoryboard(name: "MainTabBarController", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarControllerSB")
            
            rootVC = vc
        } else {
            let storyboard = UIStoryboard(name: "Signin", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SigninSB") as! SigninVC
            
            rootVC = vc
        }
        
        sceneDelegate.window?.rootViewController = rootVC
    }
    
    // MARK: Backwards compatibility for ios versions less than (13.0)
    static func appDelegateRootVC() {
        
        let isAuth = UserDefaults.standard.bool(forKey: "isAuth")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var rootVC: UIViewController?
        
        if isAuth {
            let storyboard = UIStoryboard(name: "MainTabBarController", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarControllerSB")
            
            rootVC = vc
        } else {
            let storyboard = UIStoryboard(name: "Signin", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SigninSB") as! SigninVC
            
            rootVC = vc
        }
        
        appDelegate.window?.rootViewController = rootVC
    }
}
