//
//  MainApiRepository.swift
//  RickAndMortyRx
//
//  Created by Angelina on 18.11.2021.
//

import Moya
import RxSwift

final public class MainApiRepository: MainApiRepositoryProtocol {
    
    private let api: MainApiProtocol
    
    init(api: MainApiProtocol) {
        self.api = api
    }
    
    func getAllCharacters(page: Int? = nil) -> Single<ResultModel> {
        return api.getAllCharacters(page: page).map(ResultModel.self)
    }
}
