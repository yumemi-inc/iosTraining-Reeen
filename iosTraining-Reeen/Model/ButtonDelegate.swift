//
//  ButtonDelegate.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/07.
//

import Foundation

protocol ReloadButtonDelegate: AnyObject {
    func reloadButtonDidTapped()
}

class ReloadButtonActionImpl: ReloadButtonDelegate {
    weak var weatherService: WeatherServiceProtocol?
    func reloadButtonDidTapped() {
        weatherService?.getWeatherInformation()
    }
}
