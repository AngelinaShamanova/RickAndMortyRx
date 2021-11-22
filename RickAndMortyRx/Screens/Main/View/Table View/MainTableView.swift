//
//  MainTableView.swift
//  RickAndMortyRx
//
//  Created by Angelina on 17.11.2021.
//

import UIKit

class MainTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTableView()
    }
    
    private func configureTableView() {
        backgroundColor = .magenta.withAlphaComponent(0.15)
        delegate = self
        showsVerticalScrollIndicator = false
        separatorColor = .lightGray
        estimatedRowHeight = 70
    }
}

extension MainTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
