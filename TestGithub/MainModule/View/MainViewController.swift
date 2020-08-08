//
//  FirstViewController.swift
//  TestGithub
//
//  Created by Алексей Чанов on 06.08.2020.
//  Copyright © 2020 Алексей Чанов. All rights reserved.
//

import UIKit

final class MainViewController: BaseViewController {
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    public var presenter: MainViewPresenter?
    
    public enum Constans {
        static let cellHeight: CGFloat = 100
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Private
    
    private func setupViews() {
        setupDelegates()
        setupNavigationBar()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        presenter?.searchAccounts(name: accountTextField.text ?? "")
    }
    
    private func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AccountViewCell", bundle: nil), forCellReuseIdentifier: AccountViewCell.Constatns.id)
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Сортировать" , style: .plain, target: self, action: #selector(sortedModel))
    }
    
    @objc
    private func sortedModel() {
        presenter?.sortedModel()
    }
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    
    public func swapElement(first: IndexPath, second: IndexPath) {
        tableView.moveRow(at: first, to: second)
        guard let cell = tableView.cellForRow(at: second) as? AccountViewCell else { return }
        cell.highlight()
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

extension MainViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountViewCell.Constatns.id, for: indexPath) as? AccountViewCell
            else { return UITableViewCell() }
        
        let model = presenter?.model?[indexPath.row]
        cell.config(for: AccountViewCell.DataModel(imageUrl: model?.avatar_url, login: model?.login, type: model?.type))
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constans.cellHeight
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constans.cellHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.tapOnTheAccount(indexRow: indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.uploadAccountList(indexPath.row)
    }
    
}
