//
//  FirstViewCell.swift
//  TestGithub
//
//  Created by Алексей Чанов on 06.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import UIKit

public protocol FirstViewCellViewModel {
    
    var name: String? { get }
    var language: String? { get }
    var starCount: Int? { get }
    var dateUpdate: String? { get }
}

final class RepositoryViewCell: UITableViewCell {
    
    public typealias ViewModel = FirstViewCellViewModel

    // MARK: - Outlets
    
    @IBOutlet weak var lanuageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var dateUpdateLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
    
    public struct DataModel: FirstViewCellViewModel {
        public let name: String?
        public let language: String?
        public let starCount: Int?
        public let dateUpdate: String?
    }
    
    public enum Constatns {
        static let id: String = "repoViewCell"
        
        static let heightImage: CGFloat = 80
    }
    
    // MARK: - Public
    
    public func config (for viewModel: ViewModel) {
        lanuageLabel.text = "Язык программирования - \(viewModel.language ?? "")"
        nameLabel.text = "Название - \(viewModel.name ?? "")"
        starCountLabel.text = "Кол-во звезд - \(viewModel.starCount?.description ?? "")"
        dateUpdateLabel.text = "Дата обновления - \(viewModel.dateUpdate ?? "")"
    }
}
