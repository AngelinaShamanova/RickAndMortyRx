//
//  Extension + UIViewController.swift
//  RickAndMortyRx
//
//  Created by Angelina on 18.11.2021.
//

import UIKit

enum NavigationButtonDirection {
    case leading
    case trailing
}

extension UIViewController {
    
    func show(_ error: Error, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        showAlert(error.localizedDescription, cancelHandler: cancelHandler)
    }
    
    func showAlert(_ title: String,
                   action: String? = "",
                   cancel: String? = "",
                   actionHandler: ((UIAlertAction) -> Void)? = nil,
                   cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: nil,
                                        preferredStyle: .alert)
        let someAction = UIAlertAction(title: action,
                                     style: .default,
                                     handler: actionHandler)
        let cancelAction = UIAlertAction(title: cancel,
                                     style: .cancel,
                                     handler: cancelHandler)
        alertVC.addAction(someAction)
        alertVC.addAction(cancelAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alertVC, animated: true)
        }
    }
    
    func addNavigationBarButton(imageName: String, title: String? = "", action: Selector? = nil, direction: NavigationButtonDirection? = .trailing) {
        
        let button = UIBarButtonItem(image: UIImage(systemName: imageName),
                                     style: .plain,
                                     target: self,
                                     action: action)
        button.tintColor = .magenta.withAlphaComponent(0.5)
        button.title = title
        
        (direction == .leading) ?
        (navigationItem.leftBarButtonItem = button) :
        (navigationItem.rightBarButtonItem = button)
    }
}

