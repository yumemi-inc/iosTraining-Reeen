//
//  YumemiWeatherMock.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/23.
//

import Foundation

class YumemiWeatherStub: WeatherServiceProtocol {
    var delegate: WeatherServiceDelegate?

    var maxTemperature: Int
    var minTemperature: Int
    var weatherCondition: String

    init(maxTemperature: Int = 0, minTemperature: Int = 0, weatherCondition: String = "") {
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
        self.weatherCondition = weatherCondition
    }

    var yumemiWeatherStub: WeatherData {
        WeatherData(
            maxTemperature: maxTemperature,
            minTemperature: minTemperature,
            weatherCondition: weatherCondition
        )
    }

    func getWeatherInformation() {
        delegate?.weatherService(self, didUpdateCondition: yumemiWeatherStub)
    }
}
