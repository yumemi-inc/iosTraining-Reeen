//
//  WeatherDecoder.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/07.
//

import Foundation

struct WeatherDecoder {
    static func decodeWeatherInfo(_ weatherInfo: String) throws -> [WeatherResponse] {
        let decoder = JSONDecoder()
        guard let data = weatherInfo.data(using: .utf8) else {
            fatalError("unexpected error occurred.")
        }
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedDeta = try decoder.decode([WeatherResponse].self, from: data)
        return decodedDeta.map { WeatherResponse(area: $0.area, info: $0.info)  }
    }
}
