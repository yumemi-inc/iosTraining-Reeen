//
//  WeatherError.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/16.
//

import Foundation

enum WeatherError: Error {
    case invalidParameterError
    case unknownError
    case dataNotExistsError
    case encodingConversionError
    
    var errorDescription: String? {
        switch self {
        case .invalidParameterError:
            "Invalid parameter error occurred."
        case .unknownError:
            "Unknown error occurred."
        case .dataNotExistsError:
            "Weather data is not exist"
        case .encodingConversionError:
            "Encoding conversion is failure"
        }
    }
}
