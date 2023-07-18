//
//  WeatherViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import UIKit
import SnapKit

protocol WeatherViewDelegate: AnyObject {
    func reloadButtonDidTapped()
    func closeButtonDidTapped()
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
            object: nil)
    }
    
    @objc func willEnterForeground() {
        if self.presentedViewController != errorAlert {
            weatherService.getWeatherInformation()
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
        weatherService.getWeatherInformation()
    }

    func closeButtonDidTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension WeatherViewController: WeatherServiceDelegate {
    func weatherService(_ weatherService: WeatherServiceProtocol, didUpdateCondition weatherData: WeatherData) {
        let image = getImage(for: weatherData.weatherCondition)
        weatherView.displayWeatherConditions(data: weatherData, image: image)
    }
    
    func weatherService(_ weatherService: WeatherServiceProtocol, didFailWithError error: Error) {
        errorAlert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(alertAction)
        present(errorAlert, animated: true, completion: nil)
    }
}
