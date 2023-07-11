//
//  WeatherData.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/16.
//

import Foundation

struct WeatherData: Decodable {
    var maxTemperature: Int
    var minTemperature: Int
    var weatherCondition: String
}
