//
//  EmptyViewController.swift
//  iosTraining-Reeen
//
//  Created by 高橋 蓮 on 2023/06/09.
//

import UIKit

final class ModalHolderViewController: UIViewController {
    
    var heldViewController: UIViewController?
    
    override func viewDidAppear(_ animated: Bool) {
        guard let nextViewController = heldViewController else { return }
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true, completion: nil)
    }
}
