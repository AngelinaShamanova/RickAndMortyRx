//
//  DetailApiRepository.swift
//  RickAndMortyRx
//
//  Created by Angelina on 24.11.2021.
//

import Moya
import RxSwift

final public class DetailApiRepository: DetailApiRepositoryProtocol {
    
    private let api: DetailApiProtocol
    
    init(api: DetailApiProtocol) {
        self.api = api
    }
}

