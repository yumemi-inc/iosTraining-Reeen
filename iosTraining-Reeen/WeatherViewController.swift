//
//  WeatherViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    private let weatherConditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        // TODO: textは仮の設定
        label.text = "最高気温"
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    private let minTemperatureLabel: UILabel = {
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
    
    private let reloadButton: UIButton = {
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
    
    private let weatherService: WeatherServiceProtocol
    
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
    }
}

private extension WeatherViewController {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(weatherConditionStackView)
        view.addSubview(closeButton)
        view.addSubview(reloadButton)
        
        weatherService.delegate = self
        
        let reloadAction = UIAction { [weak self] _ in
            self?.weatherService.getWeatherInformation()
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
    func weatherService(_ weatherService: WeatherService, didFailWithError error: Error) {
        let errorAlert = UIAlertController(title:"alert", message: "yes or no", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        errorAlert.addAction(alertAction)
        present(errorAlert, animated: true, completion: nil)
    }
    
    func weatherService(_ weatherService: WeatherServiceProtocol, didUpdateCondition weatherInfo: String) {
        let image = getImage(for: weatherInfo)
        weatherConditionImageView.image = image
    }
}
