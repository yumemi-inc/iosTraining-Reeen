//
//  WeatherViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    let weatherConditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()

    let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()

    let minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Close", for: .normal)
        return button
    }()
    
    let reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Reload", for: .normal)
        return button
    }()

    private lazy var weatherConditionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weatherConditionImageView, temperatureStackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()

    private lazy var temperatureStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [maxTemperatureLabel, minTemperatureLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private var errorAlert = UIAlertController()
    private let weatherService: WeatherServiceProtocol
    private let notificationCenter = NotificationCenter()

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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addNotificationCenter()
    }
}

private extension WeatherViewController {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(weatherConditionStackView)
        view.addSubview(closeButton)
        view.addSubview(reloadButton)
        view.addSubview(activityIndicator)

        let reloadAction = UIAction { [weak self] _ in
            self?.reloadButton.isEnabled = false
            self?.reloadButton.setTitleColor(.gray, for: .normal)
            self?.activityIndicator.startAnimating()
            self?.getWeatherInfo()
        }
        reloadButton.addAction(reloadAction, for: .touchUpInside)

        let closeAction = UIAction { [weak self] _ in
            self?.closeWeatherViewController()
        }
        closeButton.addAction(closeAction, for: .touchUpInside)

        weatherConditionStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        weatherConditionImageView.snp.makeConstraints { make in
            make.size.equalTo(view.snp.width).multipliedBy(0.5)
        }

        closeButton.snp.makeConstraints { make in
            make.centerX.equalTo(maxTemperatureLabel)
            make.top.equalTo(maxTemperatureLabel.snp.centerY).offset(80)
            make.width.equalTo(maxTemperatureLabel.snp.width)
        }

        reloadButton.snp.makeConstraints { make in
            make.centerX.equalTo(minTemperatureLabel)
            make.top.equalTo(minTemperatureLabel.snp.centerY).offset(80)
            make.width.equalTo(minTemperatureLabel.snp.width)
        }

        activityIndicator.snp.makeConstraints { make in
            make.centerY.equalTo(maxTemperatureLabel.snp.centerY).offset(50)
            make.centerX.equalToSuperview()
        }
    }

    func getWeatherInfo() {
        weatherService.getWeatherInformation { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    let image = self?.getImage(for: weatherData.weatherCondition)
                    self?.weatherConditionImageView.image = image
                    self?.maxTemperatureLabel.text = "\(weatherData.maxTemperature)"
                    self?.minTemperatureLabel.text = "\(weatherData.minTemperature)"

                case .failure(let error):
                    let errorAlert = UIAlertController(title: "Alert", message: error.errorDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    errorAlert.addAction(alertAction)
                    self?.present(errorAlert, animated: true, completion: nil)
                }
                self?.activityIndicator.stopAnimating()
                self?.reloadButton.isEnabled = true
                self?.reloadButton.setTitleColor(.systemBlue, for: .normal)
            }
        }
    }

    func addNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.willEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
    }

    @objc func willEnterForeground() {
        errorAlert.dismiss(animated: true)
        getWeatherInfo()
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

