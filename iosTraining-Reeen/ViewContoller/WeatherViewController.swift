//
//  WeatherViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    private let weatherService: WeatherServiceProtocol
    let weatherView = WeatherView()

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("WeatherViewController deinitialized")
    }

    override func loadView() {
        super.loadView()
        view = weatherView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addNotificationCenter()
    }

}

private extension WeatherViewController {
    func setupViews() {
        weatherService.delegate = self

        let reloadAction = UIAction { [weak self] _ in
            self?.weatherService.getWeatherInformation()
        }

        weatherView.reloadButton.addAction(reloadAction, for: .touchUpInside)

        let closeAction = UIAction { [weak self] _ in
            self?.closeWeatherViewController()
        }
        weatherView.closeButton.addAction(closeAction, for: .touchUpInside)
    }

    func addNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.willEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
    }

    @objc func willEnterForeground() {
        if self.presentedViewController != weatherView.errorAlert {
            weatherService.getWeatherInformation()
        }
    }

    func closeWeatherViewController() {
        dismiss(animated: true, completion: nil)
    }

    func getImage(for condition: String) -> UIImage? {
        guard let condition = WeatherCondition(rawValue: condition) else { return UIImage() }

        switch condition {
        case .sunny:
            return UIImage(named: "sunny")?.withTintColor(.red)
        case .cloudy:
            return UIImage(named: "cloudy")?.withTintColor(.gray)
        case .rainy:
            return UIImage(named: "rainy")?.withTintColor(.blue)
        }
    }
}

extension WeatherViewController: WeatherServiceDelegate {
    func weatherService(_ weatherService: WeatherServiceProtocol, didUpdateCondition weatherData: WeatherData) {
        let image = getImage(for: weatherData.weatherCondition)
        weatherView.weatherConditionImageView.image = image
        weatherView.maxTemperatureLabel.text = weatherData.maxTemperature.description
        weatherView.minTemperatureLabel.text = weatherData.minTemperature.description
    }

    func weatherService(_ weatherService: WeatherServiceProtocol, didFailWithError error: Error) {
        weatherView.errorAlert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        weatherView.errorAlert.addAction(alertAction)
        present(weatherView.errorAlert, animated: true, completion: nil)
    }
}
