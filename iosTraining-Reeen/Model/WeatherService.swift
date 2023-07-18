//
//  WeatherService.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import Foundation
import YumemiWeather

protocol WeatherServiceProtocol: AnyObject {
    func getWeatherInformation() async throws -> [WeatherResponse]
}

final class WeatherService: WeatherServiceProtocol {
    private let dateFormatter = DateFormatter()
    private let areas = ["Sapporo", "Sendai", "Niigata", "Kanazawa", "Tokyo", "Nagoya", "Osaka", "Hiroshima", "Kochi", "Fukuoka", "Kagoshima", "Naha"]

    func getWeatherInformation() async throws -> [WeatherResponse] {
        do {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
            let formattedDate = dateFormatter.string(from: Date())
            let encodedRequest = try WeatherEncoder.encodeRequestParameters(WeatherInformationRequest(areas: areas, date: formattedDate))
            let weatherInfo = try YumemiWeather.syncFetchWeatherList(encodedRequest)
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
