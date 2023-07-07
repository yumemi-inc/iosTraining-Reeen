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

    func testWeatherConditionImageViewIsSunny() async throws {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherData: .init(weatherCondition: "sunny"))
        weatherViewController = await WeatherViewController(weatherService: weatherDataStub)
        await weatherViewController.loadViewIfNeeded()
        // Act
        await weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = await weatherViewController.weatherView.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "sunny")?.withTintColor(.red))
    }

    func testWeatherConditionImageViewIsRainy() async throws {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherData: .init(weatherCondition: "rainy"))
        weatherViewController = await WeatherViewController(weatherService: weatherDataStub)
        await weatherViewController.loadViewIfNeeded()
        // Act
        await weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = await weatherViewController.weatherView.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "rainy")?.withTintColor(.blue))
    }

    func testWeatherConditionImageViewIsCloudy() async throws {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherData: .init(weatherCondition: "cloudy"))
        weatherViewController = await WeatherViewController(weatherService: weatherDataStub)
        await weatherViewController.loadViewIfNeeded()
        // Act
        await weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let weatherConditionImageView = await weatherViewController.weatherView.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "cloudy")?.withTintColor(.gray))
    }

    func testTempLabelShowAsExpected() async throws {
        // Arrange
        let weatherDataStub = YumemiWeatherStub(weatherData: .init(maxTemperature: 20, minTemperature: 10))
        weatherViewController = await WeatherViewController(weatherService: weatherDataStub)
        await weatherViewController.loadViewIfNeeded()
        // Act
        await weatherViewController.weatherView.reloadButton.sendActions(for: .touchUpInside)
        // Assert
        let maxTempLabel = await weatherViewController.weatherView.maxTemperatureLabel.text
        let mimTempLabel = await weatherViewController.weatherView.minTemperatureLabel.text
        XCTAssertEqual(maxTempLabel, "20")
        XCTAssertEqual(mimTempLabel, "10")
    }
}
