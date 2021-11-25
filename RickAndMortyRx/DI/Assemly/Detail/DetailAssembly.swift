//
//  DetailAssembly.swift
//  RickAndMortyRx
//
//  Created by Angelina on 23.11.2021.
//

import Swinject
import Moya

public struct DetailAssembly: BaseAssemblyProtocol {
    
    public init() { }
    
    public func registerApi(container: Container) {
        
        container.register(DetailApiProtocol.self) { resolver in
            let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
            let plugin = NetworkLoggerPlugin(configuration: loggerConfig)
            let provider = MoyaProvider<RickAndMortyTarget>(plugins: [plugin])
            return DetailApi(provider: provider)
        }
    }
    
    public func registerRepositories(container: Container) {
        
        container.register(DetailApiRepositoryProtocol.self) { resolver in
            let api = resolver.resolve(DetailApiProtocol.self)!
            return DetailApiRepository(api: api)
        }
    }
    
    public func registerInteractors(container: Container) {
        
        container.register(DetailInteractor.self) { (resolver) in
            let repository = resolver.resolve(DetailApiRepositoryProtocol.self)!
            return DetailInteractor(repository: repository)
        }
    }
    
    public func registerViewModels(container: Container) {
        
        container.register(DetailViewModel.self) { resolver in
            let interactor = resolver.resolve(DetailInteractor.self)!
            return DetailViewModel(interactor: interactor)
        }
    }
    
    public func registerViewControllers(container: Container) {
        
    }
}
