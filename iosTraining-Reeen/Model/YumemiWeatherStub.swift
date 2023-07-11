//
//  YumemiWeatherMock.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/23.
//

import Foundation

class YumemiWeatherStub: WeatherServiceProtocol {
    var delegate: WeatherServiceDelegate?

    var maxTemperature = 0
    var minTemperature = 0
    var weatherCondition = ""

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
