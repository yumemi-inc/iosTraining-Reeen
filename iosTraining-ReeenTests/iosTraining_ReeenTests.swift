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

    func testWeatherConditionImageViewIsSunny() {
        // Act
        weatherService.getWeatherInformation()
        // Assert
        assertWeatherConditionImageView(withCondition: "sunny", tintColor: .red)
    }

    func testWeatherConditionImageViewIsRainy() {
        // Arrange
        weatherService.weatherDataMock = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "rainy")
        // Act
        weatherService.getWeatherInformation()
        // Assert
        assertWeatherConditionImageView(withCondition: "rainy", tintColor: .blue)
    }

    func testWeatherConditionImageViewIsCloudy() {
        // Arrange
        weatherService.weatherDataMock = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "cloudy")
        // Act
        weatherService.getWeatherInformation()
        // Assert
        assertWeatherConditionImageView(withCondition: "cloudy", tintColor: .gray)
    }

    private func assertWeatherConditionImageView(withCondition condition: String, tintColor: UIColor) {
        let weatherConditionImageView = weatherViewController.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: condition)?.withTintColor(tintColor))
    }

    func testTempLabelShowAsExpected() {
        // Act
        weatherService.getWeatherInformation()
        // Assert
        let maxTempLabel = weatherViewController.maxTemperatureLabel.text
        let mimTempLabel = weatherViewController.minTemperatureLabel.text
        XCTAssertEqual(maxTempLabel, "20")
        XCTAssertEqual(mimTempLabel, "10")
    }
}
