//
//  iosTraining_ReeenTests.swift
//  iosTraining-ReeenTests
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import XCTest
@testable import iosTraining_Reeen

final class iosTraining_ReeenTests: XCTestCase {
    var weatherService: YumemiWeatherStub!
    var weatherViewController: WeatherViewController!

    override func setUp() {
        super.setUp()
        weatherService = YumemiWeatherStub()
        weatherViewController = WeatherViewController(weatherService: weatherService)
        weatherViewController.loadViewIfNeeded()
    }

    func testWeatherConditionImageViewIsSunny() {
        // Arrange
        weatherService.weatherDataStub = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "sunny")
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = weatherViewController.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "sunny")?.withTintColor(.red))
    }

    func testWeatherConditionImageViewIsRainy() {
        // Arrange
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
        weatherService.weatherDataStub = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "sunny")
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
        let weatherService = WeatherService()
        do {
            let encodedRequest = try weatherService.encodeRequestParameters()
            XCTAssertNotNil(encodedRequest)
        } catch {
            XCTFail("Encoding failed with error: \(error)")
        }
    }


    func testDecodeWeatherInfo() {
        let weatherService = WeatherService()
        let dummyWeatherInfo = """
            {
                "weather_condition": "sunny",
                "max_temperature": 30,
                "min_temperature": 20
            }
            """
        do {
            let weatherData = try weatherService.decodeWeatherInfo(dummyWeatherInfo)
            XCTAssertEqual(weatherData.weatherCondition, "sunny")
            XCTAssertEqual(weatherData.maxTemperature, 30)
            XCTAssertEqual(weatherData.minTemperature, 20)
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
