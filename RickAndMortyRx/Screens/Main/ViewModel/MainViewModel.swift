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
import SwiftUI

class MainViewModel: Reactor {
    
    typealias Section = SectionModel
    
    enum Action {
        case getAllCharacters
        case addCharacters
        case errorAccepted
        case makeRemove(Int)
        case refresh
        case setRefreshing(Bool)
        case revertRemovedCharacters
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setCharacters(ResultModel?)
        case removeCharacter(Int)
        case setError(Error?)
        case setRefreshing(Bool)
        case revertRemovedCharacters([CharacterModel])
    }
    
    struct State {
        fileprivate(set) var error: Error?
        fileprivate(set) var isLoading: Bool
        fileprivate(set) var characters: [MainTableItem] = []
        fileprivate(set) var allCharactersList: [CharacterModel] = []
        fileprivate(set) var removedCharactersList: [CharacterModel] = []
        fileprivate(set) var charactersSkeleton: [MainTableItem] = []
        fileprivate(set) var isRefreshing = false
        fileprivate(set) var next: Int? = nil
        
        var sections: [Section] {
            let items = isLoading ? characters :  charactersSkeleton
            let header = isLoading ? "Characters" : "Characters are empty"
            
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
    
    func getAllChars(page: Int?) -> Observable<Mutation> {
        return interactor.getAllCharacters(page: page)
            .asObservable()
            .flatMap { Observable.just(.setCharacters($0))}
            .catchError { error in
                return .of(.setError(error))
            }
    }
    
    func revertRemoved(chars: [CharacterModel]) -> Observable<Mutation> {
        return Observable.just(.revertRemovedCharacters(chars))
    }
    
    private func getSkeletonItems(for loadingMode: Bool) -> [MainTableItem] {
        switch loadingMode {
        case true:
            return [.skeleton]
        case false:
            return [MainTableItem](repeating: .skeleton, count: 5)
        }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getAllCharacters:
            return Observable.concat([
                .just(Mutation.setLoading(true)),
                getAllChars(page: currentState.next),
                .just(Mutation.setLoading(false))])
        case .makeRemove(let index):
            return .just(.removeCharacter(index))
        case .errorAccepted:
            return .just(.setError(nil))
        case .addCharacters:
            return Observable.concat([
                getAllChars(page: currentState.next)])
        case .refresh:
            return .concat([
                .just(.setRefreshing(true)),
                getAllChars(page: 1),
                .just(.setRefreshing(false)),
            ])
            
        case .setRefreshing(let refreshing):
            return .just(.setRefreshing(refreshing))
        case .revertRemovedCharacters:
            return .just(.revertRemovedCharacters(currentState.removedCharactersList))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setLoading(let mutationState):
            newState.isLoading = !mutationState
            newState.charactersSkeleton = getSkeletonItems(for: !mutationState)
            sleep(1)
        case .setCharacters(let characters):
            let result = characters?.results ?? []
            var nextPage = characters?.info?.next
            let nextNumberPage = nextPage?.getNumber() ?? 0
            
            if !currentState.characters.isEmpty && !currentState.isRefreshing {
                newState.characters.append(contentsOf: result.map { .character($0) })
                
                let allChars = result.map { $0 }
                newState.allCharactersList.append(contentsOf: allChars)
            } else {
                newState.characters = result.map { .character($0) }
                newState.allCharactersList = result.map { $0 }
            }
            
            newState.next = nextNumberPage
            
        case .removeCharacter(let index):
            let char = newState.allCharactersList[index]
            newState.characters.remove(at: index)
            newState.allCharactersList.remove(at: index)
            newState.removedCharactersList.append(char)
        case .setError(let error):
            newState.error = error
        case .setRefreshing(let refreshing):
            newState.isRefreshing = refreshing
        case .revertRemovedCharacters(let chars):
            newState.characters.insert(contentsOf: chars.map { .character($0) }, at: 0)
        }
        return newState
    }
}
