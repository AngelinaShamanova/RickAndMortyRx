//
//  CustomCell.swift
//  RickAndMortyRx
//
//  Created by Angelina on 19.11.2021.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    
    let characterAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    private func addConstraints() {
        characterAvatar.snp.makeConstraints { make in
            make.height.width.equalTo(70)
            make.trailing.equalTo(snp.trailing).offset(-20)
            make.centerY.equalTo(snp.centerY)
        }
    }
    
    private func addSubviews() {
        addSubview(characterAvatar)
    }
    
    func configure(with item: CharacterModel) {
        textLabel?.numberOfLines = 0
        textLabel?.textColor = .white
        textLabel?.text = item.name
        
        ImageService.setImage(with: item.image ?? "", imageView: characterAvatar)
    }
}
