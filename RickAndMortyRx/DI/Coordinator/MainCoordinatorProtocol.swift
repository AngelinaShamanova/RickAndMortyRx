//
//  MainCoordinatorProtocol.swift
//  RickAndMortyRx
//
//  Created by Angelina on 19.11.2021.
//

import Foundation

public protocol MainCoordinatorDelegate: AnyObject {
    
    func showDetailInfo(for character: CharacterModel?)
}
