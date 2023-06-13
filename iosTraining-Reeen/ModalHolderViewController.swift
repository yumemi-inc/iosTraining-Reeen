//
//  EmptyViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/09.
//

import UIKit

final class ModalHolderViewController: UIViewController {
    
    var customPresentingViewController: UIViewController?
    
    override func viewDidAppear(_ animated: Bool) {
        guard let nextViewController = customPresentingViewController else { return }
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
    }
}
