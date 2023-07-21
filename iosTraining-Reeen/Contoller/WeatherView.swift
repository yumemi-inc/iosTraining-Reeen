//
//  WeatherView.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/04.
//

import UIKit

class WeatherView: UIView {
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

    var errorAlert = UIAlertController()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func displayWeatherConditions(data: WeatherData, image: UIImage?) {
        weatherConditionImageView.image = image
        maxTemperatureLabel.text = data.maxTemperature.description
        minTemperatureLabel.text = data.minTemperature.description
    }
}

extension WeatherView {
    func setupViews() {
        self.backgroundColor = .white
        addSubview(weatherConditionStackView)

        weatherConditionStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        weatherConditionImageView.snp.makeConstraints { make in
            make.size.equalTo(self.snp.width).multipliedBy(0.5)
        }
    }
}
