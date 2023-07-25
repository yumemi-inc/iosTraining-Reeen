//
//  WeatherViewControllerTests.swift
//  iosTraining-ReeenTests
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import XCTest
@testable import iosTraining_Reeen

extension WeatherData {
    init(weatherCondition: String = "", maxTemperature: Int = 0, minTemperature: Int = 0) {
        self.init(
            maxTemperature: maxTemperature,
            minTemperature: minTemperature,
            weatherCondition: weatherCondition
        )
    }
}

final class WeatherViewControllerTests: XCTestCase {
    var weatherViewController: WeatherViewController!

    func testWeatherConditionImageViewIsSunny() {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherData: .init(weatherCondition: "sunny"))
        weatherViewController = WeatherViewController(weatherService: weatherDataStub)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = weatherViewController.weatherView.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "sunny")?.withTintColor(.red))
    }

    func testWeatherConditionImageViewIsRainy() {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherData: .init(weatherCondition: "rainy"))
        weatherViewController = WeatherViewController(weatherService: weatherDataStub)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = weatherViewController.weatherView.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "rainy")?.withTintColor(.blue))
    }

    func testWeatherConditionImageViewIsCloudy() {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherData: .init(weatherCondition: "cloudy"))
        weatherViewController = WeatherViewController(weatherService: weatherDataStub)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = weatherViewController.weatherView.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "cloudy")?.withTintColor(.gray))
    }

    func testTempLabelShowAsExpected() {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherData: .init(maxTemperature: 20, minTemperature: 10))
        weatherViewController = WeatherViewController(weatherService: weatherDataStub)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let maxTempLabel = weatherViewController.weatherView.maxTemperatureLabel.text
        let mimTempLabel = weatherViewController.weatherView.minTemperatureLabel.text
        XCTAssertEqual(maxTempLabel, "20")
        XCTAssertEqual(mimTempLabel, "10")
    }
}
