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
}

struct WeatherData: Decodable, Hashable {
    let maxTemperature: Int
    let minTemperature: Int
    let weatherCondition: String
}
