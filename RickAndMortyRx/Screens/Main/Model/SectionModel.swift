//
//  SectionModel.swift
//  RickAndMortyRx
//
//  Created by Angelina on 18.11.2021.
//

import RxDataSources

struct SectionModel {
    var header: String
    var items: [Item] = []
    
    init(header: String, items: [Item]) {
        self.header = header
        self.items = items
    }
}

extension SectionModel: SectionModelType {
  typealias Item = CharacterModel

   init(original: SectionModel, items: [Item]) {
    self = original
    self.items = items
  }
}
