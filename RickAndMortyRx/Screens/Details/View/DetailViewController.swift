//
//  DetailViewController.swift
//  RickAndMortyRx
//
//  Created by Angelina on 19.11.2021.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var character: CharacterModel
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let characterInfo: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    init(character: CharacterModel) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureCharacterInfo()
    }
    
    private func configureCharacterInfo() {
        let muttableString = NSMutableAttributedString()
        
        let mainColor: UIColor = .white
        let statusColor: UIColor = (character.status == "Alive" ? (.green) : (.red))
        let font: UIFont = .systemFont(ofSize: 25)
        
        let name = NSAttributedString(string: "Name: \(character.name)\n" , attributes: [NSAttributedString.Key.foregroundColor : mainColor, NSAttributedString.Key.font : font])
        let status = NSAttributedString(string: "Status: \(character.status)\n" , attributes: [NSAttributedString.Key.foregroundColor : statusColor, NSAttributedString.Key.font : font])
        let species = NSAttributedString(string: "Species: \(character.species)\n" , attributes: [NSAttributedString.Key.foregroundColor : mainColor, NSAttributedString.Key.font : font])
        
        muttableString.append(name)
        muttableString.append(status)
        muttableString.append(species)
        characterInfo.attributedText = muttableString
        
        ImageService.setImage(with: character.image ?? "", imageView: imageView)
    }
    
    private func setupUI() {
        view.backgroundColor = .lightGray
        
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(characterInfo)
    }
    
    private func addConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(70)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        characterInfo.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalTo(imageView)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
