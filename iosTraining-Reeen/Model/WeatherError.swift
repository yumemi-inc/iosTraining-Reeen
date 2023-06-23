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
            return "Invalid parameter error occurred."
        case .unknownError:
            return "Unknown error occurred."
        case .weatherDataNotExist:
            return "Weather data is not exist"
        }
    }
}
