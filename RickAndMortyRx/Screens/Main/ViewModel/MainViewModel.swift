//
//  MainViewModel.swift
//  RickAndMortyRx
//
//  Created by Angelina on 18.11.2021.
//

import Moya
import RxSwift
import RxCocoa
import ReactorKit
import UIKit

class MainViewModel: Reactor {
    
    typealias Section = SectionModel
    
    enum Action {
        case getAllCharacters
        case errorAccepted
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setCharacters(ResultModel?)
        case setError(Error?)
    }
    
    struct State {
        var error: Error?
        var isLoading: Bool
        var characters: [CharacterModel]?
        var next: Int? = nil
        
        var sections: [Section] {
            var items: [CharacterModel] = []
            var header: String = ""
            
            if !isLoading {
                items = characters ?? [CharacterModel]()
                header = "Characters"
            } else {
                items = [CharacterModel]()
                header = "Characters are empty"
            }
            
            return [Section(header: header, items: items)]
        }
    }
    
    let imageSubject = BehaviorSubject<UIImage?>(value: nil)
    let initialState: State
    let interactor: MainInteractor
        
    init(interactor: MainInteractor) {
        self.initialState = State(isLoading: false)
        self.interactor = interactor
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getAllCharacters:
            return Observable.concat([
                .just(Mutation.setLoading(true)),
                getAllChars(page: currentState.next),
                .just(Mutation.setLoading(false))])
        case .errorAccepted:
            return .just(.setError(nil))
        }
    }
    
    func getAllChars(page: Int?) -> Observable<Mutation> {
        return interactor.getAllCharacters(page: page)
            .asObservable()
            .flatMap { Observable.just(.setCharacters($0))}
            .catchError { error in
                return .of(.setError(error))
            }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setLoading(let mutationState):
            newState.isLoading = mutationState
        case .setCharacters(let characters):
            if currentState.characters != nil {
                newState.characters?.append(contentsOf: characters?.results ?? [CharacterModel]())
                var nextPage = characters?.info?.next
                newState.next = nextPage?.getNumber() ?? 0 + 1
            } else {
                newState.characters = characters?.results ?? [CharacterModel]()
            }
        case .setError(let error):
            newState.error = error
        }
        
        return newState
    }
    
    func setCharactersImages(url: String) {
        ImageService.setImage(from: url, subject: imageSubject)
    }
    
}
