//
//  WeatherData.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/16.
//

import Foundation

struct WeatherData: Codable {
    let max_temperature: Int
    let min_temperature: Int
    let date: String
    let weather_condition: String
}
