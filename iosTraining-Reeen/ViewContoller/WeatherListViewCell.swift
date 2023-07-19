//
//  WeatherListViewCell.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/19.
//

import UIKit

final class WeatherListViewCell: UICollectionViewCell {
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ weatherData: WeatherData, image: UIImage?) {
        weatherConditionImageView.image = image
        maxTemperatureLabel.text = weatherData.maxTemperature.description
        minTemperatureLabel.text = weatherData.minTemperature.description
    }
}

private extension WeatherListViewCell {
    func setupView() {
        addSubview(weatherConditionImageView)
        addSubview(maxTemperatureLabel)
        addSubview(minTemperatureLabel)

        weatherConditionImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }

        maxTemperatureLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-40)
            make.centerY.equalToSuperview().offset(-20)
            make.height.equalTo(20)
        }

        minTemperatureLabel.snp.makeConstraints { make in
            make.right.equalTo(maxTemperatureLabel.snp.right)
            make.centerY.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
    }
}
