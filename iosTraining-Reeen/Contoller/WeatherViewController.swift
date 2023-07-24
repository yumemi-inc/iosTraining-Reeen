//
//  WeatherViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import UIKit

protocol WeatherViewDelegate: AnyObject {
    func didRequestUpdate(_ reloadButton: UIButton)
    func didRequestClose(_ closeButton: UIButton)
}

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
        weatherView.weatherViewDelegate = self
    }

    func addNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.willEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }

    @objc func willEnterForeground() {
        if self.presentedViewController == nil {
            weatherService.getWeatherInformation()
        }
    }
}

extension WeatherViewController: WeatherViewDelegate {
    func didRequestUpdate(_ reloadButton: UIButton) {
        weatherService.getWeatherInformation()
    }

    func didRequestClose(_ closeButton: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension WeatherViewController: WeatherServiceDelegate {
    func weatherService(_ weatherService: WeatherServiceProtocol, didUpdateCondition weatherData: WeatherData) {
        let image = WeatherCondition(rawValue: weatherData.weatherCondition)?.getImage()
        weatherView.displayWeatherConditions(data: weatherData, image: image)
    }

    func weatherService(_ weatherService: WeatherServiceProtocol, didFailWithError error: Error) {
        let errorAlert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        errorAlert.addAction(alertAction)
        present(errorAlert, animated: true)
    }
}

private extension WeatherCondition {
    func getImage() -> UIImage {
        switch self {
        case .sunny:
            return UIImage(named: "sunny")!.withTintColor(.red)
        case .cloudy:
            return UIImage(named: "cloudy")!.withTintColor(.gray)
        case .rainy:
            return UIImage(named: "rainy")!.withTintColor(.blue)
        }
    }
}
