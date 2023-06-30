//
//  APICaller.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import Foundation
import YumemiWeather

protocol WeatherServiceProtocol: AnyObject {
    func getWeatherInformation(completion: @escaping (Result<WeatherData, WeatherError>) -> Void)
}

final class WeatherService: WeatherServiceProtocol {
    private let decoder = JSONDecoder()

    func getWeatherInformation(completion: @escaping (Result<WeatherData, WeatherError>) -> Void) {
        DispatchQueue.global().async {
            do {
                // input
                let date = Date(timeIntervalSinceNow: 3 * 3600)
                let formattedDate = ISO8601DateFormatter().string(from: date)
                let request = RequestParameters(area: "tokyo", date: formattedDate)
                let encodedRequest = try JSONEncoder().encode(request)
                guard let jsonString = String(data: encodedRequest, encoding: .utf8) else { return }
                
                // output
                let weatherInfoJsonString = try YumemiWeather.syncFetchWeather(jsonString)
                guard let data = weatherInfoJsonString.data(using: .utf8) else {
                    throw WeatherError.weatherDataNotExist
                }
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weatherData = try self.decoder.decode(WeatherData.self, from: data)
                completion(.success(weatherData))
            } catch let error as WeatherError {
                completion(.failure(error))
            } catch {
                completion(.failure(WeatherError.weatherDataNotExist))
            }
        }
    }
}


