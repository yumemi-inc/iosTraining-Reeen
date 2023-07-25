//
//  WeatherViewControllerTests.swift
//  iosTraining-ReeenTests
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import XCTest
@testable import iosTraining_Reeen

extension WeatherResponse {
    init(stubArea: String = "Tokyo", stubInfo: WeatherData = .init()) {
        self.init(area: stubArea, info: stubInfo)
    }
}

extension WeatherData {
    init(stubMaxTemperature: Int = 30, stubMinTemperature: Int = 20, stubWeatherCondition: String = "sunny") {
        self.init(maxTemperature: stubMaxTemperature, minTemperature: stubMinTemperature, weatherCondition: stubWeatherCondition)
    }
}

final class WeatherViewControllerTests: XCTestCase {
    var weatherListViewController: WeatherListViewController!
    let indexPath = IndexPath(item: 0, section: 0)

    func testWeatherConditionImageViewIsSunny() async throws {
        // Arrange

        let yumemiWeatherStub = YumemiWeatherStub(weatherResponse: [.init(info: .init(weatherCondition: "sunny"))])
        weatherListViewController = await WeatherListViewController(weatherService: yumemiWeatherStub)

        // Act
        await weatherListViewController.reloadWeatherData()
        await weatherListViewController.configureDataSource()
        guard let collectionViewCell = await weatherListViewController.weatherListView.weatherListColelctionView.cellForItem(at: indexPath) as? WeatherListViewCell else { return }
        // Assert
        let weatherConditionImageView = await collectionViewCell.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "sunny")?.withTintColor(.red))
    }

    func testWeatherConditionImageViewIsRainy() async throws {
        // Arrange
        let yumemiWeatherStub = YumemiWeatherStub(weatherResponse: [.init(info: .init(weatherCondition: "rainy"))])
        weatherListViewController = await WeatherListViewController(weatherService: yumemiWeatherStub)
        // Act
        await weatherListViewController.reloadWeatherData()
        guard let collectionViewCell = await weatherListViewController.weatherListView.weatherListColelctionView.cellForItem(at: indexPath) as? WeatherListViewCell else { return }
        // Assert
        let weatherConditionImageView = await collectionViewCell.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "rainy")?.withTintColor(.blue))
    }

    func testWeatherConditionImageViewIsCloudy() async throws {
        // Arrange
        let yumemiWeatherStub = YumemiWeatherStub(weatherResponse: [.init(info: .init(weatherCondition: "cloudy"))])
        weatherListViewController = await WeatherListViewController(weatherService: yumemiWeatherStub)
        // Act
        await weatherListViewController.reloadWeatherData()
        guard let collectionViewCell = await weatherListViewController.weatherListView.weatherListColelctionView.cellForItem(at: indexPath) as? WeatherListViewCell else { return }
        // Assert
        let weatherConditionImageView = await collectionViewCell.weatherConditionImageView.image
        XCTAssertEqual(weatherConditionImageView, UIImage(named: "cloudy")?.withTintColor(.gray))
    }

    func testTempLabelShowAsExpected() async throws {
        // Arrange
        let yumemiWeatherStub = YumemiWeatherStub(weatherResponse: [.init(info: .init(maxTemperature: 30, minTemperature: 20))])
        weatherListViewController = await WeatherListViewController(weatherService: yumemiWeatherStub)
        guard let collectionViewCell = await weatherListViewController.weatherListView.weatherListColelctionView.cellForItem(at: indexPath) as? WeatherListViewCell else { return }
        // Act
        await weatherListViewController.reloadWeatherData()
        // Assert
        let maxTempLabel = await collectionViewCell.maxTemperatureLabel.text
        let mimTempLabel = await collectionViewCell.minTemperatureLabel.text
        XCTAssertEqual(maxTempLabel, "20")
        XCTAssertEqual(mimTempLabel, "10")
    }
}
