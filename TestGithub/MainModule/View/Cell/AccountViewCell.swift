//
//  AccountViewCell.swift
//  TestGithub
//
//  Created by Алексей Чанов on 08.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import UIKit

public protocol AccountViewCellViewModel {
    
    var image: UIImage? { get }
    var login: String? { get }
    var type: String? { get }
}

class AccountViewCell: UITableViewCell {
    
    public typealias ViewModel = AccountViewCellViewModel
    
    public struct DataModel: AccountViewCellViewModel {
        
        public let image: UIImage?
        public let login: String?
        public let type: String?
    }
    
    public enum Constatns {
        
        static let heightImage: CGFloat = 80
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        cornerRadius()
    }
    
    private func cornerRadius() {
        avatarImageView.layer.cornerRadius = Constatns.heightImage / 2
    }
    // MARK: - Public
    
    public func config (for viewModel: ViewModel) {
        avatarImageView.image = viewModel.image
        loginLabel.text = viewModel.login
        typeLabel.text = viewModel.type
    }
}
