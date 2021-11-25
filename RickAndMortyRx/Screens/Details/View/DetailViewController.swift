//
//  DetailViewController.swift
//  RickAndMortyRx
//
//  Created by Angelina on 19.11.2021.
//

import UIKit
import SnapKit
import ReactorKit
import RxSwift

protocol DetailViewControllerDelegate: AnyObject {
    func controller(_ controller: DetailViewController, askRemoveCharacterBy index: Int)
}

class DetailViewController: UIViewController, View {
    
    typealias Reactor = DetailViewModel
    
    weak var coordinator: DetailViewControllerDelegate?
    
    var disposeBag = DisposeBag()
    var character: CharacterModel
    var characterIndex: Int
    
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
    
    init(viewModel: DetailViewModel, character: CharacterModel, index: Int) {
        self.character = character
        self.characterIndex = index
        super.init(nibName: nil, bundle: nil)
        reactor = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureCharacterInfo()
    }
    
    func bind(reactor: DetailViewModel) {
        
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
        addNavigationBarButton(imageName: "trash", action: #selector(removeCharacter))
        
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
    
    @objc private func removeCharacter() {
        
        //TODO: - Пересмотреть логику
        
//        showAlert("Are you sure you want to delete the character?", action: "Yes", cancel: "Cancel", actionHandler:  { [unowned self] _ in
//
//            self.coordinator?.controller(self, askRemoveCharacterBy: self.characterIndex)
//        })
    }
}
