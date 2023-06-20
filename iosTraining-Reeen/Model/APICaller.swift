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
    func weatherService(_ weatherService: WeatherServiceProtocol, didUpdateCondition weatherInfo: WeatherData)
    func weatherService(_ weatherService: WeatherService, didFailWithError error: LocalizedError)
}

final class WeatherService: WeatherServiceProtocol {
    
    private let decoder = JSONDecoder()
    weak var delegate: WeatherServiceDelegate?
    
    func getWeatherInformation() {
        do {
            let jsonString = #"{"area": "tokyo", "date": "2020-04-01T12:00:00+09:00"}"#
            let weatherInfo = try YumemiWeather.fetchWeather(jsonString)
            guard let data = weatherInfo.data(using: .utf8) else {
                throw WeatherError.weatherDataNotExist
            }
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            delegate?.weatherService(self, didUpdateCondition: weatherData)
        } catch {
            handleWeatherServiceError(error)
        }
    }
}

extension WeatherService {
    func handleWeatherServiceError(_ error: Error) {
        if let yumemiWeatherError = error as? YumemiWeatherError {
            switch yumemiWeatherError {
            case .invalidParameterError:
                delegate?.weatherService(self, didFailWithError: WeatherError.invalidParameterError)
            case .unknownError:
                delegate?.weatherService(self, didFailWithError: WeatherError.unknownError)
            }
        } else {
            delegate?.weatherService(self, didFailWithError: WeatherError.weatherDataNotExist)
        }
    }
}
