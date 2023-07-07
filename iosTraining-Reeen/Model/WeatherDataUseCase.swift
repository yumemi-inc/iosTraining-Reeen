//
//  WeatherDataUseCase.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/07.
//

import UIKit

class WeatherDataUseCase {
    private let weatherService: WeatherServiceProtocol
    private var viewController: WeatherViewController?

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        self.viewController = WeatherViewController(weatherService: weatherService)
    }

  
}
