//
//  SceneDelegate + Extension.swift
//  RickAndMortyRx
//
//  Created by Angelina on 17.11.2021.
//

import UIKit
import Moya

extension SceneDelegate {
    //MARK: - Стартовая загрузка приложения
    func start(scene: UIScene) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
//            let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
//            let plugin = NetworkLoggerPlugin(configuration: loggerConfig)
//            let provider = MoyaProvider<RickAndMortyTarget>()
            let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
            let plugin = NetworkLoggerPlugin(configuration: loggerConfig)
            let provider = MoyaProvider<RickAndMortyTarget>(plugins: [plugin])
            let api = MainApi(provider: provider)
            let repository = MainApiRepository(api: api)
            let interactor = MainInteractor(repository: repository)
            let viewModel = MainViewModel(interactor: interactor)
            
            var rootVC = UIViewController()
//            rootVC = MainViewController(viewModel: viewModel)
            
            let navController = UINavigationController(rootViewController: rootVC)
            window.rootViewController = navController
            window.makeKeyAndVisible()
//            self.window = window
        }
    }
    
    
}
