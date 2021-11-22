//
//  MainInteractor.swift
//  RickAndMortyRx
//
//  Created by Angelina on 18.11.2021.
//

import RxSwift
import Moya

final public class MainInteractor {
    
    private let repository: MainApiRepositoryProtocol
    
    init(repository: MainApiRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllCharacters(page: Int? = nil) -> Single<ResultModel> {
        return repository.getAllCharacters(page: page)
    }
    
}
