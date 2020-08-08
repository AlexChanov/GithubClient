//
//  DetailViewController.swift
//  TestGithub
//
//  Created by Алексей Чанов on 06.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var expandedIndexSet : IndexSet = []
    
    public var presenter: DetailViewPresenter?
    
    public enum Constatns {
        static let cellDefaultHeight: CGFloat = 85
        static let cellHeight: CGFloat = 130
        
        static let heightImage: CGFloat = 80
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Private
    
    private func setupViews() {
        setupDelegates()
        cornerRadius()
        
    }
    
    private func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RepositoryViewCell", bundle: nil), forCellReuseIdentifier: RepositoryViewCell.Constatns.id)
    }
    
    private func cornerRadius() {
        avatarImageView.layer.cornerRadius = Constatns.heightImage / 2
    }
}

// MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    
    public func succes(url: URL?) {
        DispatchQueue.main.async {
            self.avatarImageView.sd_setImage(with: url, completed: nil)
            self.nameLabel.text = self.presenter?.account?.name
            self.loginLabel.text = self.presenter?.account?.login
            self.dateCreatedLabel.text = self.presenter?.getDate()
            self.locationLabel.text = self.presenter?.account?.location
        }
        
    }
    
    public func succes() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    public func failure(title: String, message: String) {
        DispatchQueue.main.async {
            self.showAlert(title: title, message: message)
        }
    }
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryViewCell.Constatns.id, for: indexPath) as? RepositoryViewCell
            else { return UITableViewCell() }
        
        let model = presenter?.model?[indexPath.row]
        cell.config(for: RepositoryViewCell.DataModel(name: model?.name,
                                                      language: model?.language,
                                                      starCount: model?.stargazers_count,
                                                      dateUpdate: model?.updated_at))
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(expandedIndexSet.contains(indexPath.row)){
            expandedIndexSet.remove(indexPath.row)
        } else {
            expandedIndexSet.insert(indexPath.row)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if expandedIndexSet.contains(indexPath.row) {
            return Constatns.cellHeight
        } else {
            return Constatns.cellDefaultHeight
        }
    }
}
