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
        DispatchQueue.main.async {
            let weatherDataStub = YumemiWeatherStub(weatherData: .init(weatherCondition: "sunny"))
            self.weatherViewController = WeatherViewController(weatherService: weatherDataStub)
            self.weatherViewController.loadViewIfNeeded()
            // Act
            self.weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
            // Assert
            let weatherConditionImageView = self.weatherViewController.weatherView.weatherConditionImageView.image
            XCTAssertEqual(weatherConditionImageView, UIImage(named: "sunny")?.withTintColor(.red))
        }
    }

    func testWeatherConditionImageViewIsRainy() {
        // Arrange
        DispatchQueue.main.async {
            let weatherDataStub = YumemiWeatherStub(weatherData: .init(weatherCondition: "rainy"))
            self.weatherViewController = WeatherViewController(weatherService: weatherDataStub)
            self.weatherViewController.loadViewIfNeeded()
            // Act
            self.weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
            // Assert
            let weatherConditionImageView = self.weatherViewController.weatherView.weatherConditionImageView.image
            XCTAssertEqual(weatherConditionImageView, UIImage(named: "rainy")?.withTintColor(.blue))
        }
    }

    func testWeatherConditionImageViewIsCloudy() {
        // Arrange
        DispatchQueue.main.async {
            let weatherDataStub = YumemiWeatherStub(weatherData: .init(weatherCondition: "cloudy"))
            self.weatherViewController = WeatherViewController(weatherService: weatherDataStub)
            self.weatherViewController.loadViewIfNeeded()
            // Act
            self.weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
            // Assert
            let weatherConditionImageView = self.weatherViewController.weatherView.weatherConditionImageView.image
            XCTAssertEqual(weatherConditionImageView, UIImage(named: "cloudy")?.withTintColor(.gray))
        }
    }

    func testTempLabelShowAsExpected() {
        // Arrange
        DispatchQueue.main.async {
            let weatherDataStub = YumemiWeatherStub(weatherData: .init(maxTemperature: 20, minTemperature: 10))
            self.weatherViewController = WeatherViewController(weatherService: weatherDataStub)
            self.weatherViewController.loadViewIfNeeded()
            // Act
            self.weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
            // Assert
            let maxTempLabel = self.weatherViewController.weatherView.maxTemperatureLabel.text
            let mimTempLabel = self.weatherViewController.weatherView.minTemperatureLabel.text
            XCTAssertEqual(maxTempLabel, "20")
            XCTAssertEqual(mimTempLabel, "10")
        }
    }
}
