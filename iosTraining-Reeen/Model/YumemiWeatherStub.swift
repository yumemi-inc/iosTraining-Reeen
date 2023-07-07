//
//  YumemiWeatherMock.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/23.
//

import Foundation

class YumemiWeatherStub: WeatherServiceProtocol {
    var delegate: WeatherServiceDelegate?

    //var weatherDataStub = WeatherData(maxTemperature: 20, minTemperature: 10, weatherCondition: "sunny")

    var weatherDataStub: WeatherData?
    
    func getWeatherInformation() {
        guard let weatherDataStub else { return }
        delegate?.weatherService(self, didUpdateCondition: weatherDataStub)
    }

}
