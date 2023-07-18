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
        let encodeRequest = WeatherInformationRequest(area: "tokyo", date: date)
        let expectData = #"{"area":"tokyo","date":"2023-07-07T12:01:01Z"}"#

        do {
            let encodedRequest = try WeatherEncoder().encodeRequestParameters(encodeRequest)
            XCTAssertEqual(encodedRequest, expectData)
        } catch {
            XCTFail("Encoding failed with error: \(error)")
        }
    }


    func testDecodeWeatherInfo() {
        let decoder = WeatherDecoder()
        let dummyWeatherInfo = """
            {
                "weather_condition": "sunny",
                "max_temperature": 30,
                "min_temperature": 20
            }
            """
        do {
            let weatherData = try decoder.decodeWeatherInfo(dummyWeatherInfo)
            XCTAssertEqual(weatherData.weatherCondition, "sunny")
            XCTAssertEqual(weatherData.maxTemperature, 30)
            XCTAssertEqual(weatherData.minTemperature, 20)
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
