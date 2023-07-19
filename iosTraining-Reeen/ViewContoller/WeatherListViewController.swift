//
//  WeatherListViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/19.
//

import UIKit

enum Section: CaseIterable {
    case main
}

final class WeatherListViewController: UIViewController {
    let weatherListView = WeatherListView()
    let weatherService = WeatherService()

    var dataSource: UICollectionViewDiffableDataSource<Section, WeatherData>!

    override func loadView() {
        view = weatherListView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureDataSource()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadWetherData()
    }
}

private extension WeatherListViewController {
    func reloadWetherData() {
        Task {
            let data = try await self.weatherService.getWeatherInformation()
            setupDataSnapshot(models: data)
        }
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, WeatherData>(collectionView: weatherListView.weatherListColelctionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, weatherData: WeatherData) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherListViewCell else { return UICollectionViewCell()}
            let image = self.getImage(for: weatherData.weatherCondition)
            cell.configure(weatherData, image: image)
            return cell
        }
    }

    func getImage(for condition: String) -> UIImage? {
        guard let condition = WeatherCondition(rawValue: condition) else { return UIImage() }

        switch condition {
        case .sunny:
            return UIImage(named: "sunny")?.withTintColor(.red)
        case .cloudy:
            return UIImage(named: "cloudy")?.withTintColor(.gray)
        case .rainy:
            return UIImage(named: "rainy")?.withTintColor(.blue)
        }
    }

    func setupDataSnapshot(models: [WeatherData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(models)

        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
