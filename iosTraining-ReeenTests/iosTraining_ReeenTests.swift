//
//  iosTraining_ReeenTests.swift
//  iosTraining-ReeenTests
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import XCTest
@testable import iosTraining_Reeen

final class iosTraining_ReeenTests: XCTestCase {
    var yumemiWeatherStub: YumemiWeatherStub!
    var weatherViewController: WeatherViewController!

    override func setUp() {
        super.setUp()
        yumemiWeatherStub = YumemiWeatherStub()
    }

    func testWeatherConditionImageViewIsSunny() {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherCondition: "sunny")
        weatherViewController = WeatherViewController(weatherService: weatherDataStub)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = weatherViewController.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "sunny")?.withTintColor(.red))
    }

    func testWeatherConditionImageViewIsRainy() {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherCondition: "rainy")
        weatherViewController = WeatherViewController(weatherService: weatherDataStub)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = weatherViewController.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "rainy")?.withTintColor(.blue))
    }

    func testWeatherConditionImageViewIsCloudy() {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherCondition: "cloudy")
        weatherViewController = WeatherViewController(weatherService: weatherDataStub)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = weatherViewController.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "cloudy")?.withTintColor(.gray))
    }

    func testTempLabelShowAsExpected() {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(maxTemperature: 20, minTemperature: 10)
        weatherViewController = WeatherViewController(weatherService: weatherDataStub)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let maxTempLabel = weatherViewController.maxTemperatureLabel.text
        let mimTempLabel = weatherViewController.minTemperatureLabel.text
        XCTAssertEqual(maxTempLabel, "20")
        XCTAssertEqual(mimTempLabel, "10")
    }

    func testEncodeRequestParameters() {
        let encoder = WeatherEncoder()
        let date = DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(secondsFromGMT: 0), year: 2023, month: 7, day: 7, hour: 12, minute: 1, second: 1).date!
        let dummyRequestParameters = RequestParameters(area: "tokyo", date: date)
        let expectData = #"{"area":"tokyo","date":"2023-07-07T12:01:01Z"}"#

        do {
            let encodedRequest = try encoder.encodeRequestParameters(dummyRequestParameters)
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
