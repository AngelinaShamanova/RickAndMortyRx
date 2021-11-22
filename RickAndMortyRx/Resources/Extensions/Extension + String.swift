//
//  Extension + String.swift
//  RickAndMortyRx
//
//  Created by Angelina on 18.11.2021.
//

import Foundation

extension String {
    mutating func getNumber() -> Int {
        self.removeFirst(48)
        return Int(self) ?? 0
    }
}
