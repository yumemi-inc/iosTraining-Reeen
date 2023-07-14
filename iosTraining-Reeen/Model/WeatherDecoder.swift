//
//  WeatherDecoder.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/07.
//

import Foundation

struct WeatherDecoder {
    func decodeWeatherInfo(_ weatherInfo: String) throws -> WeatherData {
        let decoder = JSONDecoder()
        guard let data = weatherInfo.data(using: .utf8) else {
            throw WeatherError.encodingConversionError
        }
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(WeatherData.self, from: data)
    }
}
