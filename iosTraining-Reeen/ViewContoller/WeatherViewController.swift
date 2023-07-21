//
//  WeatherViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import UIKit

final class WeatherViewController: UIViewController {
    let weatherView = WeatherView()

    override func loadView() {
        super.loadView()
        view = weatherView
    }

    func configureNavigationBarTitle(_ areaName: String) {
        self.title = areaName
    }
}

private extension WeatherViewController {
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

    func setupNavigationController() {
        //TODO: ここには選択したエリアの名前が入るようにする
        title = "DetailView"
    }
}
