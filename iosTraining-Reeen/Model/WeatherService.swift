//
//  WeatherService.swift
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


    func getWeatherInformation(completion: @escaping (Result<WeatherData, WeatherError>) -> Void) {
        let encoder = WeatherEncoder()
        let decoder = WeatherDecoder()
        DispatchQueue.global(qos: .background).async {
            do {
                let encodedRequest = try encoder.encodeRequestParameters(WeatherInformationRequest(area: "tokyo", date: Date()))
                let weatherInfo = try YumemiWeather.syncFetchWeather(encodedRequest)
                let weatherData = try decoder.decodeWeatherInfo(weatherInfo)
                completion(.success(weatherData))
            } catch let error as WeatherError {
                completion(.failure(error))
            } catch {
                completion(.failure(WeatherError.unknownError))
            }
        }
    }
}
