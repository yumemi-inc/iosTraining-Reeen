//
//  WeatherEncoder.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/07.
//

import Foundation

struct WeatherEncoder {
    func encodeRequestParameters(_ requestParameters: WeatherInformationRequest) throws -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .sortedKeys
        let encodedRequest = try encoder.encode(requestParameters)
        guard let jsonString = String(data: encodedRequest, encoding: .utf8) else {
            throw WeatherError.encodingConversionError
        }
        return jsonString
    }
}