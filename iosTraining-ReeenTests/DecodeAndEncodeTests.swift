//
//  TestDecodeAndEncode.swift
//  iosTraining-ReeenTests
//
//  Created by 高橋 蓮 on 2023/07/14.
//

import XCTest
@testable import iosTraining_Reeen

final class DecodeAndEncodeTests: XCTestCase {

    func testEncodeRequestParameters() {
        let date = DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(secondsFromGMT: 0), year: 2023, month: 7, day: 7, hour: 12, minute: 1, second: 1).date!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let dateString = formatter.string(from: date)
        let dummyRequestParameters = WeatherInformationRequest(areas: ["tokyo"], date: dateString)
        let expectData = #"{"areas":["tokyo"],"date":"2023-07-07T21:01:01+09:00"}"#

        do {
            let encodedRequest = try WeatherEncoder.encodeRequestParameters(dummyRequestParameters)
            XCTAssertEqual(encodedRequest, expectData)
        } catch {
            XCTFail("Encoding failed with error: \(error)")
        }
    }


    func testDecodeWeatherInfo() {
        let dummyWeatherInfo = """
            [{
                "area": "Tokyo",
                "info": {
                    "weather_condition": "sunny",
                    "max_temperature": 30,
                    "min_temperature": 20
                }
            }]
            """
        do {
            let response = try WeatherDecoder.decodeWeatherInfo(dummyWeatherInfo)
            XCTAssertEqual(response[0].info.weatherCondition, "sunny")
            XCTAssertEqual(response[0].info.maxTemperature, 30)
            XCTAssertEqual(response[0].info.minTemperature, 20)
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
