//
//  ViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/06.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private let maxTemperatureLabel: UILabel = {
        let label = UILabel()
        //textは仮の設定
        label.text = "最高気温"
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    private let minTemperatureLabel: UILabel = {
        let label = UILabel()
        //textは仮の設定
        label.text = "最低気温"
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Close", for: .normal)
        return button
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Reload", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

private extension ViewController {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(maxTemperatureLabel)
        view.addSubview(minTemperatureLabel)
        view.addSubview(closeButton)
        view.addSubview(reloadButton)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(view.snp.width).multipliedBy(0.5)
        }
        
        maxTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.left.equalTo(imageView.snp.left)
            make.width.equalTo(imageView.snp.width).multipliedBy(0.5)
        }
        
        minTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.right.equalTo(imageView.snp.right)
            make.width.equalTo(imageView.snp.width).multipliedBy(0.5)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerX.equalTo(maxTemperatureLabel)
            make.top.equalTo(maxTemperatureLabel.snp.centerY).offset(80)
            make.width.equalTo(maxTemperatureLabel.snp.width)
            make.height.equalTo(50)
        }
        
        reloadButton.snp.makeConstraints { make in
            make.centerX.equalTo(minTemperatureLabel)
            make.top.equalTo(minTemperatureLabel.snp.centerY).offset(80)
            make.width.equalTo(minTemperatureLabel.snp.width)
            make.height.equalTo(50)
        }
    }
}
