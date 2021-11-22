//
//  Extension + UIViewController.swift
//  RickAndMortyRx
//
//  Created by Angelina on 18.11.2021.
//

import UIKit

extension UIViewController {
    func showAlert(_ error: Error, okHandler: ((UIAlertAction) -> Void)? = nil) {
        showErrorAlert(error.localizedDescription, okHandler: okHandler)
    }
    func showErrorAlert(_ error: String, okHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertVC = UIAlertController(title: error, message: nil,
                                        preferredStyle: .alert)
        let okAction = UIAlertAction(title: error, style: .default, handler: okHandler)
        alertVC.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}

