//
//  Navigation.swift
//  RickAndMortyRx
//
//  Created by Angelina on 19.11.2021.
//

import UIKit
import Foundation

public protocol NavigationProtocol: AppCoordinator {
    
    //Открываем новые контроллеры
    func push(_ viewController: UIViewController, animated: Bool)
    
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)

    //Возвращаемся назад
    func popToRoot(animated: Bool)
    
    func popTo(_ viewController: UIViewController, animated: Bool)
    
    func pop(animated: Bool)
    
    func dismiss(animated: Bool, completion: (() -> Void)?)
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
    
}

public class Navigation: NSObject, UINavigationControllerDelegate, NavigationProtocol {
    
    public let navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        
        self.navigationController.delegate = self
    }
    
    public func push(_ viewController: UIViewController, animated: Bool = false) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    public func present(_ viewController: UIViewController, animated: Bool = false, completion: (() -> Void)?) {
        if let presentedController = navigationController.presentedViewController {
            presentedController.present(viewController, animated: animated, completion: completion)
            return
        }
        navigationController.present(viewController, animated: animated, completion: completion)
    }

    public func popToRoot(animated: Bool = false) {
        navigationController.popToRootViewController(animated: animated)
    }

    public func popTo(_ viewController: UIViewController, animated: Bool = false) {
        navigationController.popToViewController(viewController, animated: animated)
    }

    public func pop(animated: Bool = false) {
        navigationController.popViewController(animated: animated)
    }

    public func dismiss(animated: Bool = false, completion: (() -> Void)?) {

        if let presentedController = navigationController.presentedViewController {
            presentedController.dismiss(animated: animated, completion: completion)
            return
        }
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    public func setViewControllers(_ viewControllers: [UIViewController], animated: Bool = false) {
        navigationController.setViewControllers(viewControllers, animated: animated)
    }
}
