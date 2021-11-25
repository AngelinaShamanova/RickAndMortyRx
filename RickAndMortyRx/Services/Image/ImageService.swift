//
//  ImageService.swift
//  RickAndMortyRx
//
//  Created by Angelina on 18.11.2021.
//

import UIKit
import Kingfisher
import RxSwift

class ImageService {
    
    static func setImage(with url: String, imageView: UIImageView) {
        
        let url = URL(string: url)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ],
            progressBlock: nil) { (result) in
                switch result {
                case .success(_): break
                case .failure(_): break
                }
            }
    }
}

