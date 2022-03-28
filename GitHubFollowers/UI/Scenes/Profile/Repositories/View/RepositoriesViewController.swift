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
    var showLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinds()
        configure()
        startObserving(&UserInterfaceStyleManager.shared)
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
                guard let self = self else { return }
                self.customView.showLoadingView(when: isLoading && self.repositoriesViewModels.isEmpty)
                self.customView.tableView.tableFooterView = isLoading && !self.repositoriesViewModels.isEmpty
                    ? GFLoadingView()
                    : nil
            }
        })
        
        viewModel?.isError.bind(closure: { [weak self] isError in
            DispatchQueue.main.async {
                self?.customView.showErrorView(when: isError)
                
            }
        })
        
        viewModel?.loadedAll.bind(closure: { [weak self] loadedAll in
            self?.showLoading = !loadedAll
        })
    }
    
    func configure() {
        title = Strings.repositoriesTitle()
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.identifier)
    }
}

extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       Constants.row
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

extension RepositoriesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        let shouldRefreshPosition = customView.tableView.contentSize.height - Constants.offsetYEndOfList - scrollView.frame.size.height

        if currentOffsetY > shouldRefreshPosition && viewModel?.isLoading.value == false {
            viewModel?.fetchRepositories()
        }
    }
}

extension RepositoriesViewController {
    struct Constants {
        static let offsetYEndOfList: CGFloat = 100
        static let row: CGFloat = 160
    }
}
