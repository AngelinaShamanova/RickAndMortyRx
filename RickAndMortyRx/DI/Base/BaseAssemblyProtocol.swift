//
//  BaseAssemblyProtocol.swift
//  RickAndMortyRx
//
//  Created by Angelina on 19.11.2021.
//

import Swinject

public protocol BaseAssemblyProtocol: Assembly {
    
    init()
    
    func registerApi(container: Container)
    
    func registerRepositories(container: Container)
    
    func registerInteractors(container: Container)
    
    func registerViewModels(container: Container)
    
    func registerViewControllers(container: Container)
}

public extension BaseAssemblyProtocol {
    
    func assemble(container: Container) {
        registerApi(container: container)
        registerRepositories(container: container)
        registerInteractors(container: container)
        registerViewModels(container: container)
        registerViewControllers(container: container)
    }
}

