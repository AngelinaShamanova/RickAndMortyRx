//
//  SectionModel.swift
//  RickAndMortyRx
//
//  Created by Angelina on 18.11.2021.
//

import RxDataSources

struct SectionModel {
    var header: String
    var items: [MainTableItem] = []
    
    init(header: String, items: [Item]) {
        self.header = header
        self.items = items
    }
}

extension SectionModel: SectionModelType {
   init(original: SectionModel, items: [MainTableItem]) {
    self = original
    self.items = items
  }
}
