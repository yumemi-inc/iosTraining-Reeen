//
//  WeatherService.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import Foundation
import YumemiWeather

protocol WeatherServiceProtocol: AnyObject {
    func getWeatherInformation() async throws -> WeatherData
}

final class WeatherService: WeatherServiceProtocol {
    func getWeatherInformation() async throws -> WeatherData {
        do {
            let encodedRequest = try WeatherEncoder.encodeRequestParameters(WeatherInformationRequest(area: "tokyo", date: Date()))
            let weatherInfo = try YumemiWeather.syncFetchWeather(encodedRequest)
            let weatherData = try WeatherDecoder.decodeWeatherInfo(weatherInfo)
            return weatherData
        } catch {
            try handleWeatherServiceError(error)
        }
        throw WeatherError.dataNotExistsError
    }
}

extension WeatherService {
    func handleWeatherServiceError(_ error: Error) throws {
        if let yumemiWeatherError = error as? YumemiWeatherError {
            switch yumemiWeatherError {
            case .invalidParameterError:
                throw WeatherError.invalidParameterError
            case .unknownError:
                throw WeatherError.unknownError
            }
        }
    }
}
