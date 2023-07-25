//
//  WeatherListView.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/19.
//

import UIKit
import SnapKit

final class WeatherListView: UIView {
    lazy var weatherListColelctionView: UICollectionView = {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.backgroundColor = .systemGray4
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView.register(WeatherListViewCell.self, forCellWithReuseIdentifier: "WeatherCell")
        return collectionView
    }()

    let emptyStateLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        addSubview(weatherListColelctionView)
        addSubview(emptyStateLabel)
        addSubview(activityIndicator)

        weatherListColelctionView.snp.makeConstraints { make in
            make.center.edges.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        emptyStateLabel.snp.makeConstraints { make in
            make.top.equalTo(activityIndicator.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
}
