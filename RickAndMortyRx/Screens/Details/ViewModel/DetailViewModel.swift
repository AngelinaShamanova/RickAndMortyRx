//
//  DetailViewModel.swift
//  RickAndMortyRx
//
//  Created by Angelina on 23.11.2021.
//

import Moya
import RxSwift
import RxCocoa
import ReactorKit
import UIKit

class DetailViewModel: Reactor {
    
    enum Action {
        case backToMainScreen
    }
    
    enum Mutation {
        case removeCharacter(Bool)
    }
    
    struct State {
        fileprivate(set) var characterWasRemoved: Bool
    }
    
    let interactor: DetailInteractor
    let initialState: State
        
    init(interactor: DetailInteractor) {
        self.initialState = State(characterWasRemoved: false)
        self.interactor = interactor
    }
}
