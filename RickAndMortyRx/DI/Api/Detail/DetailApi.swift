//
//  DetailApi.swift
//  RickAndMortyRx
//
//  Created by Angelina on 24.11.2021.
//

import RxSwift
import RxCocoa
import Moya
import RxMoya

class DetailApi: DetailApiProtocol {
    
    private let provider: MoyaProvider<RickAndMortyTarget>
    
    public init(provider: MoyaProvider<RickAndMortyTarget>) {
        self.provider = provider
    }
    
}
