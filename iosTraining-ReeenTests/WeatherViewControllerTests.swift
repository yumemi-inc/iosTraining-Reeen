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
    let expectation = XCTestExpectation(description: "Wait for weather data to update")

    func testWeatherConditionImageViewIsSunny() throws {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherData: .init(weatherCondition: "sunny"))
        weatherViewController = WeatherViewController(weatherService: weatherDataStub)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let weatherConditionImageView = self.weatherViewController.weatherView.weatherConditionImageView.image
            XCTAssertEqual(weatherConditionImageView, UIImage(named: "sunny")?.withTintColor(.red))
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testWeatherConditionImageViewIsRainy() throws {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherData: .init(weatherCondition: "rainy"))
        weatherViewController = WeatherViewController(weatherService: weatherDataStub)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let weatherConditionImageView = self.weatherViewController.weatherView.weatherConditionImageView.image
            XCTAssertEqual(weatherConditionImageView, UIImage(named: "rainy")?.withTintColor(.blue))
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testWeatherConditionImageViewIsCloudy() throws {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherData: .init(weatherCondition: "cloudy"))
        weatherViewController = WeatherViewController(weatherService: weatherDataStub)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let weatherConditionImageView = self.weatherViewController.weatherView.weatherConditionImageView.image
            XCTAssertEqual(weatherConditionImageView, UIImage(named: "cloudy")?.withTintColor(.gray))
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func testTempLabelShowAsExpected() throws {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherData: .init(maxTemperature: 20, minTemperature: 10))
        weatherViewController = WeatherViewController(weatherService: weatherDataStub)
        weatherViewController.loadViewIfNeeded()
        // Act
        weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let maxTempLabel = self.weatherViewController.weatherView.maxTemperatureLabel.text
            let mimTempLabel = self.weatherViewController.weatherView.minTemperatureLabel.text
            XCTAssertEqual(maxTempLabel, "20")
            XCTAssertEqual(mimTempLabel, "10")
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)

    }
}
