//
//  APICaller.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import Foundation
import YumemiWeather

protocol WeatherServiceProtocol {
    func getWeatherInformation() -> String
}

final class WeatherService: WeatherServiceProtocol {
    func getWeatherInformation() -> String {
        YumemiWeather.fetchWeatherCondition()
    }
}
