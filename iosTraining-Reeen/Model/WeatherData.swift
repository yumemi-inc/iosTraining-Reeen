//
//  WeatherData.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/16.
//

import Foundation

struct WeatherData: Decodable {
    let maxTemperature: Int
    let minTemperature: Int
    let weatherCondition: String
}

extension WeatherData {
    init(weatherCondition: String = "", maxTemperature: Int = 0, minTemperature: Int = 0) {
        self.weatherCondition = weatherCondition
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
    }
}
