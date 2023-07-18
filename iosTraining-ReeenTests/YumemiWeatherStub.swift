//
//  YumemiWeatherMock.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/23.
//

import Foundation

import Foundation

class YumemiWeatherStub: WeatherServiceProtocol {
    var weatherResponse: [WeatherResponse]

    init(weatherResponse: [WeatherResponse]) {
        self.weatherResponse = weatherResponse
    }

    func getWeatherInformation() async throws -> [WeatherResponse] {
        weatherResponse
    }
}
