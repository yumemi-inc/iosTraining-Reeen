//
//  WeatherViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
<<<<<<< HEAD
    let weatherConditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        // TODO: textは仮の設定
        label.text = "最高気温"
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    let minTemperatureLabel: UILabel = {
        let label = UILabel()
        // TODO: textは仮の設定
        label.text = "最低気温"
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

    private var errorAlert = UIAlertController()
    private let weatherService: WeatherServiceProtocol
=======
    let weatherView = WeatherView()
>>>>>>> 67e9cb8 (feat: CollectionViewの画面遷移の実装)

    override func loadView() {
        super.loadView()
        view = weatherView
    }

    func configureNavigationBarTitle(_ areaName: String) {
        self.title = areaName
    }
}

private extension WeatherViewController {
<<<<<<< HEAD
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(weatherConditionStackView)
        view.addSubview(closeButton)
        view.addSubview(reloadButton)


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

    func closeWeatherViewController() {
        dismiss(animated: true, completion: nil)
    }

=======
>>>>>>> 67e9cb8 (feat: CollectionViewの画面遷移の実装)
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
