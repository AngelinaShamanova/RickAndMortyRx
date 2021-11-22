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
//    KingfisherManager.
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
    
    static func setImage(from url: String? = nil, subject: BehaviorSubject<UIImage?>) {
        if let url = url {
            let urlString = URL(string: url)!
            
            KingfisherManager.shared.retrieveImage(with: urlString) { result in
                switch result {
                case .success(let value):
                    subject.onNext(value.image)
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
        }
        
    }
}
