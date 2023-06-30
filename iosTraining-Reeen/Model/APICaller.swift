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
        DispatchQueue.global().async {
            do {
                // input
                let date = Date(timeIntervalSinceNow: 3 * 3600)
                let formattedDate = ISO8601DateFormatter().string(from: date)
                let request = RequestParameters(area: "tokyo", date: formattedDate)
                let encodedRequest = try JSONEncoder().encode(request)
                guard let jsonString = String(data: encodedRequest, encoding: .utf8) else { return }

                // output
                let weatherInfo = try YumemiWeather.syncFetchWeather(jsonString)
                guard let data = weatherInfo.data(using: .utf8) else {
                    throw WeatherError.weatherDataNotExist
                }
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weatherData = try self.decoder.decode(WeatherData.self, from: data)
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
            delegate?.weatherService(self, didFailWithError: WeatherError.weatherDataNotExist)
        }
    }
}
