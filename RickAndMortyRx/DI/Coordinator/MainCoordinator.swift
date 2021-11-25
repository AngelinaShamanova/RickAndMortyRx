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
    weak var delegate: MainCoordinatorDelegate?
    weak var detailDelegate: DetailViewControllerDelegate?
    let container: Container
    private let navigation: NavigationProtocol
   
    init(container: Container,
                navigation: NavigationProtocol,
                delegate: MainCoordinatorDelegate? = nil,
                detailDelegate: DetailViewControllerDelegate? = nil) {
        self.container = container
        self.navigation = navigation
        self.delegate = delegate
        self.detailDelegate = detailDelegate
    }
    
    public func start() {
        window.rootViewController = navigation.navigationController
        let mainVC = container.resolve(MainViewController.self)!
        mainVC.coordinator = self
        navigation.setViewControllers([mainVC], animated: true)
    }
}

public protocol AppCoordinator {
    var navigationController: UINavigationController { get }
}

extension MainCoordinator: MainViewControllerDelegate {
    
    func controller(_ controller: MainViewController,
                    askShowDetailInfo item: CharacterModel,
                    index: Int) {
        
        let viewModel = container.resolve(DetailViewModel.self)!
        let vc = DetailViewController(viewModel: viewModel, character: item, index: index)
        vc.coordinator = self
        navigation.push(vc, animated: true)
    }
}

extension MainCoordinator: DetailViewControllerDelegate {
    
    func controller(_ controller: DetailViewController, askRemoveCharacterBy index: Int) {
        let vc = container.resolve(MainViewController.self)!
        vc.removeCharacter(index: index)
        navigation.pop(animated: true)
    }
}
