//
//  YumemiWeatherMock.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/23.
//

import Foundation

class YumemiWeatherStub: WeatherServiceProtocol {
    var delegate: WeatherServiceDelegate?

    var weatherData: WeatherData

    init(weatherData: WeatherData) {
        self.weatherData = weatherData
    }

    func getWeatherInformation() {
        delegate?.weatherService(self, didUpdateCondition: weatherData)
    }
}
