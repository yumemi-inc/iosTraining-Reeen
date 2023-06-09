//
//  EmptyViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/09.
//

import UIKit

final class EmptyViewController: UIViewController {
    
    private let weatherViewController = WeatherViewController(weatherService: WeatherService())
    override func viewDidAppear(_ animated: Bool) {
        present(weatherViewController, animated: true)
    }
}
