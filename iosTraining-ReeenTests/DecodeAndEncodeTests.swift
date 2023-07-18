//
//  TestDecodeAndEncode.swift
//  iosTraining-ReeenTests
//
//  Created by 高橋 蓮 on 2023/07/14.
//

import XCTest
@testable import iosTraining_Reeen

final class DecodeAndEncodeTests: XCTestCase {
    
//    func testEncodeRequestParameters() {
//        let date = DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(secondsFromGMT: 0), year: 2023, month: 7, day: 7, hour: 12, minute: 1, second: 1).date!
//        let dummyRequestParameters = WeatherInformationRequest(areas: ["tokyo"], date: date)
//        let expectData = #"{"areas":["tokyo"],"date":"2023-07-07T12:01:01Z"}"#
//
//        do {
//            let encodedRequest = try WeatherEncoder.encodeRequestParameters(dummyRequestParameters)
//            XCTAssertEqual(encodedRequest, expectData)
//        } catch {
//            XCTFail("Encoding failed with error: \(error)")
//        }
//    }


    func testDecodeWeatherInfo() {
        let dummyWeatherInfo = """
            {
                "weather_condition": "sunny",
                "max_temperature": 30,
                "min_temperature": 20
            }
            """
        do {
            let weatherData = try WeatherDecoder.decodeWeatherInfo(dummyWeatherInfo)
            XCTAssertEqual(weatherData[0].weatherCondition, "sunny")
            XCTAssertEqual(weatherData[0].maxTemperature, 30)
            XCTAssertEqual(weatherData[0].minTemperature, 20)
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
