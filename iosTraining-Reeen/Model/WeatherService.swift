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

    weak var delegate: WeatherServiceDelegate?

    func getWeatherInformation() {
        DispatchQueue.global(qos: .background).async {
            do {
                let encodedRequest = try WeatherEncoder.encodeRequestParameters(.init(area: "tokyo", date: Date()))
                let weatherInfo = try YumemiWeather.syncFetchWeather(encodedRequest)
                let weatherData = try WeatherDecoder.decodeWeatherInfo(weatherInfo)
                self.delegate?.weatherService(self, didUpdateCondition: weatherData)
            } catch {
                self.handleWeatherServiceError(error)
            }
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
