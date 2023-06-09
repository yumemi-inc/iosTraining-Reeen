//
//  WeatherService.swift
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
    func weatherService(_ weatherService: WeatherServiceProtocol, didFailWithError error: Error)
}

final class WeatherService: WeatherServiceProtocol {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    weak var delegate: WeatherServiceDelegate?
    
    func getWeatherInformation() {
        do {
            // input
            let currentDate = Date()
            let request = RequestParameters(area: "tokyo", date: currentDate)
            encoder.dateEncodingStrategy = .iso8601
            let encodedRequest = try encoder.encode(request)
            guard let jsonString = String(data: encodedRequest, encoding: .utf8) else { return }
            
            // output
            let weatherInfo = try YumemiWeather.fetchWeather(jsonString)
            guard let data = weatherInfo.data(using: .utf8) else {
                throw WeatherError.encodingConversionError
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
            delegate?.weatherService(self, didFailWithError: WeatherError.dataNotExistsError)
        }
    }
}
