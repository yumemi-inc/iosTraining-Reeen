//
//  APICaller.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import Foundation
import YumemiWeather

protocol WeatherServiceProtocol {
    func getWeatherInformation()
}

protocol WeatherUpdateDelegate: AnyObject {
    func weatherConditionDidUpdate(weatherInfo: String)
}

final class WeatherService: WeatherServiceProtocol {
    
    weak var delegate: WeatherUpdateDelegate?
    
    func getWeatherInformation() {
        let weatherInfo = YumemiWeather.fetchWeatherCondition()
        delegate?.weatherConditionDidUpdate(weatherInfo: weatherInfo)
    }
}


