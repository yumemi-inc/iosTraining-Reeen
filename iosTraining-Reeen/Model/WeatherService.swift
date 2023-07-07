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

protocol WeatherServiceDelegate: AnyObject {
    func weatherServiceDidStartFetching(_ weatherService: WeatherServiceProtocol)
    func weatherServiceDidEndFetching(_ weatherService: WeatherServiceProtocol)
}

final class WeatherService: WeatherServiceProtocol {
    weak var delegate: WeatherServiceDelegate?
    func getWeatherInformation(completion: @escaping (Result<WeatherData, WeatherError>) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self else { return }
            self.delegate?.weatherServiceDidStartFetching(self)
            defer {
                self.delegate?.weatherServiceDidEndFetching(self)
            }
            do {
                let encodedRequest = try WeatherEncoder.encodeRequestParameters(WeatherInformationRequest(area: "tokyo", date: Date()))
                let weatherInfo = try YumemiWeather.syncFetchWeather(encodedRequest)
                let weatherData = try WeatherDecoder.decodeWeatherInfo(weatherInfo)
                completion(.success(weatherData))
            } catch let error as WeatherError {
                completion(.failure(error))
            } catch {
                completion(.failure(WeatherError.unknownError))
            }
        }
    }
}
