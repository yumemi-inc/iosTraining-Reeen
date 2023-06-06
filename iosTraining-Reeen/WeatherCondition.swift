//
//  WeatherCondition.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import UIKit

enum WeatherCondition {
    case sunny
    case cloudy
    case rainy
    
    init?(weatherString: String) {
        switch weatherString.lowercased() {
        case "sunny":
            self = .sunny
        case "rainy":
            self = .rainy
        case "cloudy":
            self = .cloudy
        default:
            return nil
        }
    }
    
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
