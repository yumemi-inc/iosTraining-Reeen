//
//  YumemiWeatherMock.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/23.
//

import Foundation

class YumemiWeatherMock: YumemiWeatherProtocol {
    static var mockResponse: String?
    static var mockError: Error?

    static func fetchWeather(_ jsonString: String) throws -> String {
        if let error = mockError {
            throw error
        }
        return mockResponse ?? ""
    }
}
