//
//  MainAssembly.swift
//  RickAndMortyRx
//
//  Created by Angelina on 19.11.2021.
//

import Swinject
import Moya

public struct MainAssembly: BaseAssemblyProtocol {
    
    public init() { }
    
    public func registerApi(container: Container) {
        
        container.register(MainApiProtocol.self) { resolver in
//            let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
            let plugin = NetworkLoggerPlugin()
            let provider = MoyaProvider<RickAndMortyTarget>(plugins: [plugin])
            return MainApi(provider: provider)
        }
    }
    
    public func registerRepositories(container: Container) {
        
        container.register(MainApiRepositoryProtocol.self) { resolver in
            let api = resolver.resolve(MainApiProtocol.self)!
            return MainApiRepository(api: api)
        }
    }
    
    public func registerInteractors(container: Container) {
        
        container.register(MainInteractor.self) { (resolver) in
            let repository = resolver.resolve(MainApiRepositoryProtocol.self)!
            return MainInteractor(repository: repository)
        }
    }
    
    public func registerViewModels(container: Container) {
        
        container.register(MainViewModel.self) { resolver in
            let interactor = resolver.resolve(MainInteractor.self)!
            return MainViewModel(interactor: interactor)
        }
    }
    
    public func registerViewControllers(container: Container) {
        
        container.register(MainViewController.self) { resolver in
            let viewModel = resolver.resolve(MainViewModel.self)!
            return MainViewController(viewModel: viewModel)
        }
    }
}
