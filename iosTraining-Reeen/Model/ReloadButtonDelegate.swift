//
//  ReloadButtonDelegate.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/07.
//

import Foundation

protocol ReloadButtonDelegate: AnyObject {
    func reloadButtonDidTap()
}

class WeatherReloadButtonHandler: ReloadButtonDelegate {
    weak var weatherViewController: WeatherViewController?

    func reloadButtonDidTap() {
        guard let weatherViewController else { return }
        weatherViewController.getWeatherInformation()
    }
}
