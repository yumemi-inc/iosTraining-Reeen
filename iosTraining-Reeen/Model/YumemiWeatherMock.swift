//
//  YumemiWeatherMock.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/23.
//

import Foundation

class YumemiWeatherMock: WeatherServiceProtocol {
    var weatherDataMock = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "sunny")

    func getWeatherInformation(completion: @escaping (Result<WeatherData, WeatherError>) -> Void) {
        completion(.success(weatherDataMock))
    }
}
