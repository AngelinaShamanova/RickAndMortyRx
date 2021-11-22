//
//  MainApi.swift
//  RickAndMortyRx
//
//  Created by Angelina on 18.11.2021.
//

import RxSwift
import RxCocoa
import Moya
import RxMoya

class MainApi: MainApiProtocol {
    
    private let provider: MoyaProvider<RickAndMortyTarget>
    
    public init(provider: MoyaProvider<RickAndMortyTarget>) {
        self.provider = provider
    }
    
    func getAllCharacters(page: Int? = nil) -> Single<Response> {
        return provider.rx.request(.getAllCharacters(page: page))
    }
    
}
