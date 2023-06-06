//
//  APICaller.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import Foundation
import YumemiWeather

protocol WeatherService {
    func getWeatherInformation() -> String
}

class ConcreteWeatherService: WeatherService {
    func getWeatherInformation() -> String {
        YumemiWeather.fetchWeatherCondition()
    }
}
