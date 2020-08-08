//
//  FirstViewController.swift
//  TestGithub
//
//  Created by Алексей Чанов on 06.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    public var presenter: MainViewPresenter?
    
    public enum Constans {
        
       static let cellHeight: CGFloat = 100
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .white
    }
    
    // MARK: - Private
    // Регистрация ячеек сделать
    private func setupViews() {
        setupDelegates()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        presenter?.searchAccounts(name: accountTextField.text ?? "")
    }
    
    private func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AccountViewCell", bundle: nil), forCellReuseIdentifier: "accountCell")
    }
    
    private func searchRepo(name: String) {
        
    }
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    func succes() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failure() {
        
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath) as? AccountViewCell
            else { return UITableViewCell() }
        
        let model = presenter?.model?[indexPath.row]
        
        cell.config(for: AccountViewCell.DataModel(image: UIImage(), login: model?.login, type: model?.type))
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constans.cellHeight
    }
}
