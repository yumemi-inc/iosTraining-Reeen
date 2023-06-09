//
//  WeatherCondition.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import UIKit

enum WeatherCondition: String {
    case sunny
    case cloudy
    case rainy
    
    func displayConditionImage() -> UIImage? {
        switch self {
        case .sunny:
            return UIImage(named: "sunny")?.withTintColor(.red)
        case .cloudy:
            return UIImage(named: "cloudy")?.withTintColor(.gray)
        case .rainy:
            return UIImage(named: "rainy")?.withTintColor(.blue)
        }
    }
}
