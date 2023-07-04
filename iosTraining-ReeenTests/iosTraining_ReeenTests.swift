//
//  iosTraining_ReeenTests.swift
//  iosTraining-ReeenTests
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import XCTest
@testable import iosTraining_Reeen

final class iosTraining_ReeenTests: XCTestCase {
    func testWeatherConditionImageViewIsSunny() {
        // Arrange
        let weatherService = YumemiWeatherStub()
        let weatherViewController = WeatherViewController(weatherService: weatherService)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = weatherViewController.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "sunny")?.withTintColor(.red))
    }

    func testWeatherConditionImageViewIsRainy() {
        // Arrange
        let weatherService = YumemiWeatherStub()
        let weatherViewController = WeatherViewController(weatherService: weatherService)
        weatherService.weatherDataStub = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "rainy")
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = weatherViewController.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "rainy")?.withTintColor(.blue))
    }

    func testWeatherConditionImageViewIsCloudy() {
        // Arrange
        let weatherService = YumemiWeatherStub()
        let weatherViewController = WeatherViewController(weatherService: weatherService)
        weatherService.weatherDataStub = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "cloudy")
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = weatherViewController.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "cloudy")?.withTintColor(.gray))
    }

    func testTempLabelShowAsExpected() {
        // Arrange
        let weatherService = YumemiWeatherStub()
        let weatherViewController = WeatherViewController(weatherService: weatherService)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let maxTempLabel = weatherViewController.maxTemperatureLabel.text
        let mimTempLabel = weatherViewController.minTemperatureLabel.text
        XCTAssertEqual(maxTempLabel, "20")
        XCTAssertEqual(mimTempLabel, "10")
    }

    func testEncodingRequestParameters() {
        // Arrange
        let date = DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(secondsFromGMT: 0), year: 2023, month: 6, day: 23, hour: 12, minute: 1, second: 1).date!
        let request = RequestParameters(area: "tokyo", date: date)

        // Act
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = [.sortedKeys] // .sortedKeysでJsonのキーの順序を指定
        let encodedData = try? encoder.encode(request)
        let jsonString = encodedData != nil ? String(data: encodedData!, encoding: .utf8) : nil

        // Assert
        let expectedJsonString = #"{"area":"tokyo","date":"2023-06-23T12:01:01Z"}"#
        XCTAssertEqual(jsonString, expectedJsonString)
    }

    func testDecodingWeatherData() {
        // Arrange
        let json = """
        {
            "max_temperature": 30,
            "min_temperature": 20,
            "weather_condition": "sunny"
        }
        """
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // Act
        let weatherData = try? decoder.decode(WeatherData.self, from: data)

        // Assert
        XCTAssertEqual(weatherData?.maxTemperature, 30)
        XCTAssertEqual(weatherData?.minTemperature, 20)
        XCTAssertEqual(weatherData?.weatherCondition, "sunny")
    }
}
