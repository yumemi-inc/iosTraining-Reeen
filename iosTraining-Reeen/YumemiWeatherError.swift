//
//  YumemiWeatherError.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/16.
//

import Foundation

enum YumemiWeatherError: Error {
    case invalidParameterError
    case unknownError
    
    var errorMessage: String? {
        switch self {
        case .invalidParameterError:
            return "Invalid parameter provided. Please check the input and try again."
        case .unknownError:
            return "An unknown error occurred. Please try again later."
        }
    }
}
