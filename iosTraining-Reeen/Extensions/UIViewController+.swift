//
//  UIViewController+.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/04.
//

import UIKit

extension UIViewController {
    static var topMostViewController: UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        var topController = windowScene.windows.first?.rootViewController
        while let presentedViewController = topController?.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
}
