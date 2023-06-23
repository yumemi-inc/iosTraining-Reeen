//
//  YumemiWeatherMock.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/23.
//

import Foundation

class YumemiWeatherMock: WeatherServiceProtocol {
    var delegate: WeatherServiceDelegate?

    var weatherDataMock = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "sunny")

    func getWeatherInformation() {
        delegate?.weatherService(self, didUpdateCondition: weatherDataMock)
    }

}
