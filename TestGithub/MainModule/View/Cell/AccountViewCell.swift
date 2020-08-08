//
//  AccountViewCell.swift
//  TestGithub
//
//  Created by Алексей Чанов on 08.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import UIKit
import SDWebImage

public protocol AccountViewCellViewModel {
    
    var imageUrl: String? { get }
    var login: String? { get }
    var type: String? { get }
}

class AccountViewCell: UITableViewCell {
    
    public typealias ViewModel = AccountViewCellViewModel
    
    public struct DataModel: AccountViewCellViewModel {
        public let imageUrl: String?
        public let login: String?
        public let type: String?
    }
    
    public enum Constatns {
        static let id: String = "accountCell"

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
        loginLabel.text = viewModel.login
        typeLabel.text = viewModel.type
        
        guard let urlString = viewModel.imageUrl,
            let url = URL(string:urlString ) else { return }
        
        avatarImageView.sd_setImage(with: url, completed: nil)
    }
        
    public func highlight() {
        UIView.animate(withDuration: 1.0, delay: 0.5,options: .autoreverse, animations: {
            self.contentView.backgroundColor = .systemGreen
        }, completion: { (finish) in
            self.contentView.backgroundColor = .white
        } )
    }
}
