//
//  YumemiWeatherMock.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/23.
//

import Foundation

class YumemiWeatherStub: WeatherServiceProtocol {
    var delegate: WeatherServiceDelegate?

    var yumemiWeatherStub: WeatherData

    init(yumemiWeatherStub: WeatherData) {
        self.yumemiWeatherStub = yumemiWeatherStub
    }

    func getWeatherInformation() {
        delegate?.weatherService(self, didUpdateCondition: yumemiWeatherStub)
    }
}
