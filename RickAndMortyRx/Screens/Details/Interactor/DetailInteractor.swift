//
//  DetailInteractor.swift
//  RickAndMortyRx
//
//  Created by Angelina on 23.11.2021.
//

import RxSwift
import Moya

final public class DetailInteractor {
    
    private let repository: DetailApiRepositoryProtocol
    
    init(repository: DetailApiRepositoryProtocol) {
        self.repository = repository
    }
    
}
