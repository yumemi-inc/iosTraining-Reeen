//
//  WeatherData.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/16.
//

import Foundation

struct WeatherResponse: Decodable, Hashable, Identifiable {
    var id: String {
        return area
    }
    let area: String
    let info: WeatherData

    init(area: String = "Tokyo", info: WeatherData = .init()) {
        self.area = area
        self.info = info
    }
}

struct WeatherData: Decodable, Hashable {
    let maxTemperature: Int
    let minTemperature: Int
    let weatherCondition: String

    init(maxTemperature: Int = 30, minTemperature: Int = 20, weatherCondition: String = "sunny") {
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
        self.weatherCondition = weatherCondition
    }
}
