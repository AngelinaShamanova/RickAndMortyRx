//
//  MainViewController + Extension.swift
//  RickAndMortyRx
//
//  Created by Angelina on 24.11.2021.
//

import UIKit
import ReactorKit

extension MainViewController: DetailViewControllerDelegate {
    
    func controller(_ controller: DetailViewController, askRemoveCharacterBy index: Int) {
        removeCharacter(index: index)
    }
}
