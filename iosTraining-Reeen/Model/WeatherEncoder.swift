//
//  WeatherEncoder.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/07.
//

import Foundation

struct WeatherEncoder {
    static func encodeRequestParameters(_ encodeRequest: WeatherInformationRequest) throws -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .sortedKeys
        let encodedRequest = try encoder.encode(encodeRequest)
        guard let jsonString = String(data: encodedRequest, encoding: .utf8) else {
            fatalError("unexpected error occurred.")
        }
        return jsonString
    }
}
