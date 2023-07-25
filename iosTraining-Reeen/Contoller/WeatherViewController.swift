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
        view = weatherView
    }

    func configureNavigationBarTitle(_ areaName: String) {
        self.title = areaName
    }
}
