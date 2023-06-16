//
//  APICaller.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import Foundation
import YumemiWeather

protocol WeatherServiceProtocol: AnyObject {
    var delegate: WeatherServiceDelegate? { get set }
    
    func getWeatherInformation()
}

protocol WeatherServiceDelegate: AnyObject {
    func weatherService(_ weatherService: WeatherServiceProtocol, didUpdateCondition weatherInfo: String)
    func weatherService(_ weatherService: WeatherService, didFailWithError error: WeatherError)
}

final class WeatherService: WeatherServiceProtocol {
    
    weak var delegate: WeatherServiceDelegate?
    
    func getWeatherInformation() {
        do {
            let weatherInfo = try YumemiWeather.fetchWeatherCondition(at: "tokyo")
            delegate?.weatherService(self, didUpdateCondition: weatherInfo)
        } catch YumemiWeatherError.invalidParameterError {
            delegate?.weatherService(self, didFailWithError: .invalidParameterError)
        } catch YumemiWeatherError.unknownError {
            delegate?.weatherService(self, didFailWithError: .unknownError)
        } catch {
            assertionFailure("error occurred in getWeatherInformation().")
        }
    }
}
