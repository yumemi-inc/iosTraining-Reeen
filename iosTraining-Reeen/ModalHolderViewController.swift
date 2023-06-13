//
//  EmptyViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/09.
//

import UIKit

final class ModalHolderViewController: UIViewController {
    
    private let weatherViewController = WeatherViewController(weatherService: WeatherService())
    
    override func viewDidAppear(_ animated: Bool) {
        weatherViewController.modalPresentationStyle = .fullScreen
        present(weatherViewController, animated: true, completion: nil)
    }
}
