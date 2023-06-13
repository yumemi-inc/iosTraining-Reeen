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

protocol WeatherServiceDelegate: AnyObject {
    func weatherService(_ weatherService: WeatherServiceProtocol, conditonUpdate weatherInfo: String)
}

final class WeatherService: WeatherServiceProtocol {
    
    weak var delegate: WeatherServiceDelegate?
    
    func getWeatherInformation() {
        let weatherInfo = YumemiWeather.fetchWeatherCondition()
        delegate?.weatherService(WeatherService(), conditonUpdate: weatherInfo)
    }
}


