//
//  WeatherViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import UIKit

final class WeatherViewController: UIViewController {
    private let weatherService: WeatherServiceProtocol
    private var errorAlert = UIAlertController()
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

    func reloadWeatherInformation() {
        Task {
            defer {
                weatherView.activityIndicator.stopAnimating()
            }
            do {
                let weatherData = try await weatherService.getWeatherInformation()
                let image = WeatherCondition(rawValue: weatherData.weatherCondition)?.getImage()
                weatherView.weatherConditionImageView.image = image
                weatherView.maxTemperatureLabel.text = "\(weatherData.maxTemperature)"
                weatherView.minTemperatureLabel.text = "\(weatherData.minTemperature)"
            } catch let error as WeatherError {
                showErrorAlert(message: error.errorDescription ?? "Unknown error occurred.")
            } catch {
                showErrorAlert(message: "Unknown error occurred.")
            }
        }
    }

    func showErrorAlert(message: String) {
        errorAlert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(alertAction)
        present(errorAlert, animated: true, completion: nil)
    }
}

private extension WeatherViewController {
    func setupViews() {
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
        if presentedViewController == nil {
            weatherView.activityIndicator.startAnimating()
            reloadWeatherInformation()
        }
    }
}

extension WeatherViewController: WeatherViewDelegate {
    func didRequestUpdate(_ reloadButton: UIButton) {
        weatherView.activityIndicator.startAnimating()
        reloadWeatherInformation()
    }

    func didRequestClose(_ closeButton: UIButton) {
        dismiss(animated: true, completion: nil)
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
