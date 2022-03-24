//
//  RepositoriesViewController.swift
//  GitHubFollowers
//
//  Created by joaovitor on 22/03/22.
//

import UIKit

class RepositoriesViewController: BaseViewController<RepositoriesView> {
    var viewModel: RepositoriesViewModelProtocol?
    var repositoriesViewModels: [RepositoryCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinds()
        configure()
    }
    
    func setupBinds() {
        viewModel?.repositories.bind(closure: { [weak self] repositories in
            DispatchQueue.main.async {
                self?.repositoriesViewModels = repositories.map { RepositoryCellViewModel(repository: $0) }
                self?.customView.tableView.reloadData()
            }
        })
        
        viewModel?.isLoading.bind(closure: { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.customView.showLoadingView(when: isLoading)
            }
        })
        
        viewModel?.isError.bind(closure: { [weak self] isError in
            DispatchQueue.main.async {
                self?.customView.showErrorView(when: isError)
            }
        })
    }
    
    func configure() {
        title = strings.repositoriesTitle()
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.identifier)
    }
}

extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
}

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositoriesViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as! RepositoryCell
        cell.setup(viewModel: repositoriesViewModels[indexPath.row])
        return cell
    }
}
