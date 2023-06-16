//
//  WeatherError.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/16.
//

import Foundation
 
enum WeatherError: LocalizedError {
    case invalidParameterError
    case unknownError
    case weatherDataNotExist
    
    var errorDescription: String? {
        switch self {
        case .invalidParameterError:
            "Invalid parameter error occurred."
        case .unknownError:
            "Unknown error occurred."
        case .weatherDataNotExist:
            "Weather data is not exist"
        }
    }
}
