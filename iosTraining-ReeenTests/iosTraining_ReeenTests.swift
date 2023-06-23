//
//  iosTraining_ReeenTests.swift
//  iosTraining-ReeenTests
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import XCTest
@testable import iosTraining_Reeen

final class iosTraining_ReeenTests: XCTestCase {
    let weatherService = YumemiWeatherMock()

    func testWeatherConditionImageViewIsSunny() {
        // Arrange
        let weatherViewContoller = WeatherViewController(weatherService: weatherService)

        // Act
        weatherViewContoller.viewDidLoad()
        weatherService.getWeatherInformation()

        // Assert
        let weatherConditionImageView = weatherViewContoller.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "sunny")?.withTintColor(.red))
    }

    func testWeatherConditionImageViewIsRainy() {
        // Arrange
        let weatherViewContoller = WeatherViewController(weatherService: weatherService)
        weatherService.weatherDataMock = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "rainy")

        // Act
        weatherViewContoller.viewDidLoad()
        weatherService.getWeatherInformation()

        // Assert
        let weatherConditionImageView = weatherViewContoller.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "rainy")?.withTintColor(.blue))
    }

    func testWeatherConditionImageViewIsCloudy() {
        // Arrange
        let weatherViewContoller = WeatherViewController(weatherService: weatherService)
        weatherService.weatherDataMock = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "cloudy")

        // Act
        weatherViewContoller.viewDidLoad()
        weatherService.getWeatherInformation()

        // Assert
        let weatherConditionImageView = weatherViewContoller.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "cloudy")?.withTintColor(.gray))
    }
}
