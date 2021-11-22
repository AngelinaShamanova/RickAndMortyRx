//
//  Assembly.swift
//  RickAndMortyRx
//
//  Created by Angelina on 19.11.2021.
//

import Swinject

extension Assembler {
    
    static let sharedAssembler: Assembler = {
        
        let container = Container()
        
        let assembler = Assembler([
            DIAssembly(),
            AppAssembly(),
            MainAssembly()
            ], container: container)
        return assembler
    }()
}

public struct AppAssembly: Assembly {
    
    public func assemble(container: Container) {
        registerCoordinators(container: container)
    }
    
    private func registerCoordinators(container: Container) {
        let navigation = container.resolve(NavigationProtocol.self)!
        
        container.register(MainCoordinator.self) { _ in
            return MainCoordinator(container: container, navigation: navigation)
        }
    }
}

