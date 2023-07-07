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

    func getWeatherInformation() {
        weatherService.getWeatherInformation { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    let image = WeatherCondition(rawValue: weatherData.weatherCondition)?.getImage()
                    self?.weatherView.weatherConditionImageView.image = image
                    self?.weatherView.maxTemperatureLabel.text = "\(weatherData.maxTemperature)"
                    self?.weatherView.minTemperatureLabel.text = "\(weatherData.minTemperature)"

                case .failure(let error):
                    guard let self else { return }
                    self.errorAlert = UIAlertController(title: "Alert", message: error.errorDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    self.errorAlert.addAction(alertAction)
                    self.present(self.errorAlert, animated: true, completion: nil)
                }
                self?.weatherView.activityIndicator.stopAnimating()
            }
        }
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
            getWeatherInformation()
        }
    }
}

extension WeatherViewController: WeatherViewDelegate {
    func didRequestUpdate(_ reloadButton: UIButton) {
        weatherView.activityIndicator.startAnimating()
        getWeatherInformation()
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
