//
//  MainApiRepositoryProtocol.swift
//  RickAndMortyRx
//
//  Created by Angelina on 18.11.2021.
//

import RxSwift
import Moya

protocol MainApiRepositoryProtocol: AnyObject {
    
    func getAllCharacters(page: Int?) -> Single<ResultModel>
    
}
