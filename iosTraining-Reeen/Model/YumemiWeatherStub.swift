//
//  YumemiWeatherMock.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/23.
//

import Foundation

class YumemiWeatherStub: WeatherServiceProtocol {
    var maxTemperature = 0
    var minTemperature = 0
    var weatherCondition = ""

    init(maxTemperature: Int = 0, minTemperature: Int = 0, weatherCondition: String = "") {
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
        self.weatherCondition = weatherCondition
    }

    var weatherDataStub: WeatherData {
        WeatherData(
            maxTemperature: maxTemperature,
            minTemperature: minTemperature,
            weatherCondition: weatherCondition
        )
    }

    func getWeatherInformation(completion: @escaping (Result<WeatherData, WeatherError>) -> Void) {
        completion(.success(weatherDataStub))
    }
}
