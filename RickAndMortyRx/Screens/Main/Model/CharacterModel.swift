//
//  CharacterModel.swift
//  RickAndMortyRx
//
//  Created by Angelina on 17.11.2021.
//

import Foundation

struct ResultModel: Decodable {
    var info: InfoModel?
    var results: [CharacterModel]?
}

struct InfoModel: Decodable {
    var pages: Int
    var next: String?
}

public struct CharacterModel: Decodable {
    let id: Int
    let name: String
    let species: String
    let image: String?
    let status: String
    let location: LocationModel?
}

struct LocationModel: Decodable {
    let name: String
}
