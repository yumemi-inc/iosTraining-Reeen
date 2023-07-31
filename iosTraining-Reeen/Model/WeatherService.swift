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
    func weatherServiceWillStartFetching(_ weatherService: WeatherServiceProtocol)
    func weatherServiceDidEndFetching(_ weatherService: WeatherServiceProtocol)
    func weatherService(_ weatherService: WeatherServiceProtocol, didUpdateCondition weatherInfo: WeatherData)
    func weatherService(_ weatherService: WeatherServiceProtocol, didFailWithError error: Error)
}

final class WeatherService: WeatherServiceProtocol {

    weak var delegate: WeatherServiceDelegate?

    func getWeatherInformation() {
        delegate?.weatherServiceWillStartFetching(self)
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            do {
                let encodedRequest = try WeatherEncoder.encodeRequestParameters(.init(area: "tokyo", date: Date()))
                let weatherInfo = try YumemiWeather.syncFetchWeather(encodedRequest)
                let weatherData = try WeatherDecoder.decodeWeatherInfo(weatherInfo)
                self.delegate?.weatherService(self, didUpdateCondition: weatherData)
                delegate?.weatherServiceDidEndFetching(self)
            } catch {
                self.handleWeatherServiceError(error)
                delegate?.weatherServiceDidEndFetching(self)
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
