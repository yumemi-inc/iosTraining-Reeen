//
//  ReloadButton.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/07/11.
//

import UIKit

class ReloadButton: UIButton {
    weak var delegate: ReloadButtonDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(.systemBlue, for: .normal)
        self.setTitle("Reload", for: .normal)
        self.addTarget(self, action: #selector(updateWeatherInfo), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func updateWeatherInfo() {
        delegate?.reloadButtonDidTapped()
    }
}
