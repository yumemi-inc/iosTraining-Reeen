//
//  ModalHolderViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/09.
//

import UIKit

final class ModalHolderViewController: UIViewController {
    
    var heldViewController: UIViewController?
    
    override func viewDidAppear(_ animated: Bool) {
        if heldViewController == nil {
            let weatherViewController = WeatherViewController(weatherService: WeatherService())
            self.heldViewController = weatherViewController
        }
        
        guard let heldViewController else { return }
        heldViewController.modalPresentationStyle = .fullScreen
        present(heldViewController, animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        heldViewController = nil
    }
}
