//
//  UITabBarController.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 13.04.21.
//

import UIKit

extension UITabBar {
    static func setTransparentTabBar(){
        UITabBar.appearance().backgroundColor = .red
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().clipsToBounds = true
    }
}
