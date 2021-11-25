//
//  MainTableItem.swift
//  RickAndMortyRx
//
//  Created by Angelina on 24.11.2021.
//

import Foundation
import RxSwift
import RxDataSources

enum MainTableItem: Equatable {
    case character(CharacterModel)
    case skeleton
    case allCharacters([CharacterModel])
}
