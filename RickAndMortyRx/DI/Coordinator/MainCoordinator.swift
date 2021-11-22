//
//  MainCoordinator.swift
//  RickAndMortyRx
//
//  Created by Angelina on 19.11.2021.
//

import Swinject
import UIKit

public final class MainCoordinator {
    
    public var window: UIWindow!
    public weak var delegate: MainCoordinatorDelegate?
    let container: Container
    private let navigation: NavigationProtocol
   
    public init(container: Container, navigation: NavigationProtocol, delegate: MainCoordinatorDelegate? = nil) {
        self.container = container
        self.navigation = navigation
        self.delegate = delegate
    }
    
    public func start() {
        window.rootViewController = navigation.navigationController
        let mainVC = container.resolve(MainViewController.self)!
        mainVC.delegate = self
        navigation.setViewControllers([mainVC], animated: true)
    }
}

public protocol AppCoordinator {
    var navigationController: UINavigationController { get }
}

extension MainCoordinator: MainViewControllerDelegate {
    func showDetailInfo(item: CharacterModel) {
        let vc = DetailViewController(character: item)
        navigation.push(vc, animated: true)
    }
}
