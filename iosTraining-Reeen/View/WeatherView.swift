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
        label.text = "最高気温"
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()

    let minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "最低気温"
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()

    let closeButton: UIButton = {
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

    weak var weatherViewDelegate: WeatherViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherView {
    func setupViews() {
        self.backgroundColor = .white
        addSubview(weatherConditionStackView)
        addSubview(closeButton)
        addSubview(reloadButton)

        reloadButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        weatherConditionStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        weatherConditionImageView.snp.makeConstraints { make in
            make.size.equalTo(self.snp.width).multipliedBy(0.5)
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

    @objc private func buttonPressed() {
        weatherViewDelegate?.reloadButtonDidTapped()
    }
}
