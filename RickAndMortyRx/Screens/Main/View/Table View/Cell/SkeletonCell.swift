//
//  SkeletonCell.swift
//  RickAndMortyRx
//
//  Created by Angelina on 24.11.2021.
//

import SkeletonView
import SnapKit
import UIKit
import RxSwift
import RxCocoa

final class SkeletonCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "RICK AND MORTY"
        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.isSkeletonable = true
        return label
    }()
    
    private let characterAvatar: UIView = {
        let imageView = UIView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
      let content: UIView = {
        let view = UIView()
         view.backgroundColor = .magenta.withAlphaComponent(0.15)
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        view.isSkeletonable = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        addSubviews()
        addConstraints()
    }
    
    private func addConstraints() {
        content.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.top.equalTo(contentView.snp.top).offset(15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
        }
        
        characterAvatar.snp.makeConstraints { make in
            make.height.width.equalTo(70)
            make.trailing.equalTo(content.snp.trailing).offset(-20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(content.snp.leading).offset(20)
            make.centerY.equalTo(characterAvatar.snp.centerY)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(content)
        content.addSubview(characterAvatar)
        content.addSubview(titleLabel)
    }
}
