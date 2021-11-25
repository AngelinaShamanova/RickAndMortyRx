//
//  MainViewController.swift
//  RickAndMortyRx
//
//  Created by Angelina on 17.11.2021.
//

import RxSwift
import RxCocoa
import RxDataSources
import ReactorKit
import UIKit
import RxMoya
import Moya
import SnapKit

protocol MainViewControllerDelegate: AnyObject {
    
    func controller(_ controller: MainViewController,
                    askShowDetailInfo item: CharacterModel,
                    index: Int)
}

class MainViewController: UIViewController, View {
    
    typealias DataSource = RxTableViewSectionedReloadDataSource<SectionModel>
    
    weak var coordinator: MainViewControllerDelegate?
    
    var disposeBag = DisposeBag()
    
    var tableView = MainTableView()
    
    public init(viewModel: MainViewModel) {
        super.init(nibName: nil, bundle: nil)
        reactor = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        super.loadView()
        self.view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: "\(SkeletonCell.self)")
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "\(MainTableViewCell.self)")
        bindDataSource()
        reactor?.action.onNext(.getAllCharacters)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        title = "Rick & Morty"
        
        addNavigationBarButton(imageName: "arrowtriangle.up", action: #selector(scrollToFirstRow))
        addNavigationBarButton(imageName: "", title: "Revert Chars", action: #selector(revertRemovedCharacters), direction: .leading)
    }
    
    @objc private func revertRemovedCharacters() {
        reactor?.action.onNext(.revertRemovedCharacters)
    }
    
    @objc private func scrollToFirstRow() {
        UIView.animate(withDuration: 0.1) {
            self.tableView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    private func showDetailInfo(item: CharacterModel, index: Int) {
        coordinator?.controller(self, askShowDetailInfo: item, index: index)
    }
    
    func removeCharacter(index: Int) {
        reactor?.action.onNext(.makeRemove(index))
    }
    
    private func bindDataSource() {
        
        let dataSource = DataSource(configureCell: { section, tableView, indexPath, item in
            
            switch item {
            case .skeleton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(SkeletonCell.self)", for: indexPath) as! SkeletonCell
                cell.content.showAnimatedGradientSkeleton()
                return cell
            case .character(let character):
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(MainTableViewCell.self)", for: indexPath) as! MainTableViewCell
                cell.configure(with: character)
                return cell
            default: return UITableViewCell()
            }
        })
        
        setupTable(dataSource: dataSource)
    }
    
    private func setupTable(dataSource: DataSource) {
        
        dataSource.canEditRowAtIndexPath = { _, _  in return true }
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        reactor?.state
            .map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func bind(reactor: MainViewModel) {
        reactor.state
            .map { $0.isRefreshing }
            .distinctUntilChanged()
            .bind(to: tableView.refreshIndicator.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        tableView.refreshIndicator.rx.controlEvent(.valueChanged)
            .map { .refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.error }
            .compactMap { $0 }
            .subscribe(onNext: { [unowned self] error in
                self.show(error) { _ in
                    reactor.action.onNext(.errorAccepted)
                }
            }).disposed(by: disposeBag)
        
        Observable.zip(tableView.rx.itemSelected,
                       tableView.rx.modelSelected(MainTableItem.self))
            .subscribe(onNext: { [unowned self] (indexPath, item) in
                
                self.tableView.deselectRow(at: indexPath, animated: true)
                
                switch item {
                case .character(let character):
                    self.showDetailInfo(item: character, index: indexPath.row)
                default: break
                }
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .subscribe(onNext: { [unowned self] (indexPath) in
                self.removeCharacter(index: indexPath.row)
            })
            .disposed(by: disposeBag)
    
        tableView.rx.willDisplayCell
            .map { _, indexPath -> Bool in
                let numberOfItems = self.tableView.numberOfRows(inSection: indexPath.section)
                let isLastItem = indexPath.row == numberOfItems - 1
                return isLastItem
            }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in Reactor.Action.addCharacters }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
