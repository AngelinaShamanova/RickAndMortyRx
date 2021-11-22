//
//  DIAssembly.swift
//  RickAndMortyRx
//
//  Created by Angelina on 19.11.2021.
//

import Swinject
import UIKit

public struct DIAssembly: Assembly {
    
    public init() { }
    
    public func assemble(container: Container) {
        registerNavigationController(container: container)
    }
    
    private func registerNavigationController(container: Container) {
        container.register(NavigationProtocol.self) { _ in
            let navigationController = UINavigationController()
            return Navigation(navigationController: navigationController)
        }
    }
}

