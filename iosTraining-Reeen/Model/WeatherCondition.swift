//
//  WeatherCondition.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import Foundation

enum WeatherCondition: String {
    case sunny
    case cloudy
    case rainy
}

struct WeatherInformationRequest: Encodable {
    let areas: [String]
    let date: String
}
