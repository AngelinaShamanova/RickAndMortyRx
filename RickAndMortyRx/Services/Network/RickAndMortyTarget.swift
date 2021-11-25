//
//  NetworkService.swift
//  RickAndMortyRx
//
//  Created by Angelina on 17.11.2021.
//

import Moya
import Foundation

enum RickAndMortyTarget {
    case getAllCharacters(page: Int? = nil)
}

extension RickAndMortyTarget: TargetType {
    var baseURL: URL {
        URL(string: "https://rickandmortyapi.com/api/")!
    }
    
    var path: String {
        switch self {
        case .getAllCharacters:
            return "character/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .getAllCharacters(let page):
            guard let page = page else { return .requestPlain }
            return .requestParameters(parameters: ["page" : page], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let headers = ["Content-type": "application/json",
                       "Accept": "application/json"]
        return headers
    }
}
