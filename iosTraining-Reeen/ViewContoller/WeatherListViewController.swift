//
//  WeatherListViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/19.
//

import UIKit

protocol WeatherListViewDelegate: AnyObject {
    func reloadButtonTapped()
}

enum Section: CaseIterable {
    case main
}

final class WeatherListViewController: UIViewController {
    private let weatherService: WeatherServiceProtocol
    private var errorAlert = UIAlertController()
    let weatherListView = WeatherListView()
    let refreshControl = UIRefreshControl()

    var dataSource: UICollectionViewDiffableDataSource<Section, WeatherResponse>?

    override func loadView() {
        view = weatherListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadWeatherData()
        setupView()
        addNotificationCenter()
        setupNavigationController()
        configureDataSource()
    }

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherListViewController {
    func setupView() {
        weatherListView.weatherListColelctionView.delegate = self
        weatherListView.weatherListColelctionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadWeatherData), for: .valueChanged)
    }

    @objc func reloadWeatherData() {
        Task {
            do {
                let data = try await weatherService.getWeatherInformation()
                weatherListView.emptyStateLabel.isHidden = !data.isEmpty
                applyData(models: data)
            } catch let error as WeatherError {
                showErrorAlert(message: error.errorDescription ?? "Unkown error occurred")
            } catch {
                showErrorAlert(message: "Unkown error occurred")
            }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.weatherListView.activityIndicator.stopAnimating()
            }
        }
    }

    func applyData(models: [WeatherResponse]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherResponse>()
        snapshot.appendSections([.main])
        snapshot.appendItems(models, toSection: .main)
        dataSource?.apply(snapshot)
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, WeatherResponse>(collectionView: weatherListView.weatherListColelctionView) { [weak self] collectionView, indexPath, weatherResponse in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as? WeatherListViewCell else { return nil }
            let image = self?.getImage(for: weatherResponse.info.weatherCondition)
            cell.configure(weatherResponse, image: image)
            return cell
        }
    }

    func showErrorAlert(message: String) {
        errorAlert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        errorAlert.addAction(alertAction)
        present(errorAlert, animated: true, completion: nil)
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

    func setupNavigationController() {
        title = "WeatherSearchAPP"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .systemGray4
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
    }

    func addNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }

    @objc func willEnterForeground() {
        if presentedViewController == nil {
            weatherListView.activityIndicator.startAnimating()
            reloadWeatherData()
        }
    }
}

extension WeatherListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = WeatherViewController()
        let snapShot = dataSource?.snapshot()
        guard let item = snapShot?.itemIdentifiers(inSection: .main)[indexPath.row] else { return }
        let image = getImage(for: item.info.weatherCondition)
        detailView.weatherView.displayWeatherConditions(data: item, image: image)
        detailView.configureNavigationBarTitle(item.area)
        navigationController?.pushViewController(detailView, animated: true)
    }
}

