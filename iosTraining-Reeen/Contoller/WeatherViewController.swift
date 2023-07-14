//
//  WeatherViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import UIKit
import SnapKit

protocol WeatherViewDelegate: AnyObject {
    func reloadButtonDidTapped() async
}

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
        super.loadView()
        view = weatherView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addNotificationCenter()
    }

    func getWeatherInformation() async {
        do {
            let weatherData = try await weatherService.getWeatherInformation()
            let image = getImage(for: weatherData.weatherCondition)
            await MainActor.run {
                self.weatherView.weatherConditionImageView.image = image
                self.weatherView.maxTemperatureLabel.text = "\(weatherData.maxTemperature)"
                self.weatherView.minTemperatureLabel.text = "\(weatherData.minTemperature)"
                self.weatherView.activityIndicator.stopAnimating()
            }
        } catch let error as WeatherError {
            await MainActor.run {
                self.errorAlert = UIAlertController(title: "Alert", message: error.errorDescription, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                self.errorAlert.addAction(alertAction)
                self.present(self.errorAlert, animated: true, completion: nil)
                self.weatherView.activityIndicator.stopAnimating()
            }
        } catch {
            await MainActor.run {
                self.errorAlert = UIAlertController(title: "Alert", message: "Unknown error occurred.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                self.errorAlert.addAction(alertAction)
                self.present(self.errorAlert, animated: true, completion: nil)
                self.weatherView.activityIndicator.stopAnimating()
            }
        }
    }
}

private extension WeatherViewController {
    func setupViews() {
        weatherView.weatherViewDelegate = self

        let closeAction = UIAction { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
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
        if self.presentedViewController != errorAlert {
            self.weatherView.activityIndicator.startAnimating()
            Task {
                await getWeatherInformation()
            }
        }
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

extension WeatherViewController: WeatherViewDelegate {
    func reloadButtonDidTapped() {
        self.weatherView.activityIndicator.startAnimating()
        Task {
            await getWeatherInformation()
        }
    }
}
