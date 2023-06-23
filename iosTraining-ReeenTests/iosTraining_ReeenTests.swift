//
//  iosTraining_ReeenTests.swift
//  iosTraining-ReeenTests
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import XCTest
@testable import iosTraining_Reeen

final class iosTraining_ReeenTests: XCTestCase {

    func testWeatherViewController() {
        // Arrange
        let weatherService = YumemiWeatherMock()
        let weatherViewContoller = WeatherViewController(weatherService: weatherService)
        weatherService.weatherDataMock = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "rainy")

        // Act
        weatherViewContoller.viewDidLoad()
        weatherService.getWeatherInformation()

        // Assert
        let weatherConditionImageView = weatherViewContoller.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "rainy")?.withTintColor(.blue))
    }
}
