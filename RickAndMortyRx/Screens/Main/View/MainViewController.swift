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
    func showDetailInfo(item: CharacterModel)
}

class MainViewController: UIViewController, View {
    
    typealias Reactor = MainViewModel
    private var tableView = MainTableView()
    private var viewModel: MainViewModel
    var disposeBag = DisposeBag()
    weak var delegate: MainViewControllerDelegate?
    
    private let provider = MoyaProvider<RickAndMortyTarget>(plugins: [NetworkLoggerPlugin()])
    
    public init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        
        reactor = viewModel
        tableView.register(CustomCell.self, forCellReuseIdentifier: "\(CustomCell.self)")
        bindDataSource()
        reactor?.action.onNext(.getAllCharacters)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        title = "Rick & Morty"
        
        addNavigationBarButton()
    }
    
    private func addNavigationBarButton() {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrowtriangle.up"), style: .plain, target: self, action: #selector(scrollToFirstRow))
        button.tintColor = .magenta.withAlphaComponent(0.5)
        
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func scrollToFirstRow() {
        UIView.animate(withDuration: 0.1) {
            self.tableView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    private func bindDataSource() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel>(
            configureCell: { section, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CustomCell.self)", for: indexPath) as? CustomCell else { return UITableViewCell() }
                cell.configure(with: item)
                return cell
            })
        
        setupHeader(dataSource: dataSource)
    }
    
    private func setupHeader(dataSource: RxTableViewSectionedReloadDataSource<SectionModel>) {
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        viewModel.state
            .map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func bind(reactor: MainViewModel) {
        reactor.state
            .map { $0.error }
            .compactMap { $0 }
            .subscribe(onNext: { [unowned self] error in
                self.showAlert(error) { [weak self] _ in
                    self?.viewModel.action.onNext(.errorAccepted)
                }
            }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CharacterModel.self)
            .subscribe(onNext: { [unowned self] (item) in
                self.showDetailInfo(item: item)
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
            .map { _ in Reactor.Action.getAllCharacters }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

extension MainViewController {
    
    func showDetailInfo(item: CharacterModel) {
        delegate?.showDetailInfo(item: item)
    }
}
