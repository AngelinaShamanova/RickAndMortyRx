//
//  MainApiProtocol.swift
//  RickAndMortyRx
//
//  Created by Angelina on 18.11.2021.
//

import RxSwift
import Moya

protocol MainApiProtocol: AnyObject {
    
    func getAllCharacters(page: Int?) -> Single<Response>
}
