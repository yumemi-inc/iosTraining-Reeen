//
//  iosTraining_ReeenTests.swift
//  iosTraining-ReeenTests
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import XCTest
@testable import iosTraining_Reeen

final class iosTraining_ReeenTests: XCTestCase {
    var weatherService: YumemiWeatherMock!
    var weatherViewController: WeatherViewController!

    // Arrange
    override func setUp() {
        super.setUp()
        weatherService = YumemiWeatherMock()
        weatherViewController = WeatherViewController(weatherService: weatherService)
        weatherViewController.viewDidLoad()
    }

    func testWeatherConditionImageViewIsSunny() async throws {
        // Act
        await weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        try await assertWeatherConditionImageView(withCondition: "sunny", tintColor: .red)
    }

    func testWeatherConditionImageViewIsRainy() async throws {
        // Arrange
        weatherService.weatherDataMock = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "rainy")
        // Act
        await weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        try await assertWeatherConditionImageView(withCondition: "rainy", tintColor: .blue)
    }

    func testWeatherConditionImageViewIsCloudy() async throws {
        // Arrange
        weatherService.weatherDataMock = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "cloudy")
        // Act
        await weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        try await assertWeatherConditionImageView(withCondition: "cloudy", tintColor: .gray)
    }

    private func assertWeatherConditionImageView(withCondition condition: String, tintColor: UIColor) async throws {
        let weatherConditionImageView = await self.weatherViewController.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: condition)?.withTintColor(tintColor))
    }

    func testTempLabelShowAsExpected() async throws {
        // Act
        await weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let maxTempLabel = await weatherViewController.maxTemperatureLabel.text
        let mimTempLabel = await weatherViewController.minTemperatureLabel.text
        XCTAssertEqual(maxTempLabel, "20")
        XCTAssertEqual(mimTempLabel, "10")
    }

    func testEncodingRequestParameters() {
        // Arrange
        let date = DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(secondsFromGMT: 0), year: 2023, month: 6, day: 23, hour: 12, minute: 1, second: 1).date!
        let formattedDate = ISO8601DateFormatter().string(from: date)
        let request = RequestParameters(area: "tokyo", date: formattedDate)

        // Act
        let encoder = JSONEncoder()
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
