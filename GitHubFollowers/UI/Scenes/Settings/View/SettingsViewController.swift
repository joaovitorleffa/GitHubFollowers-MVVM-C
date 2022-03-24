//
//  SettingsViewController.swift
//  GitHubFollowers
//
//  Created by joaovitor on 23/03/22.
//

import UIKit

class SettingsViewController: BaseViewController<SettingsView> {
    var viewModel: SettingsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configure() {
        title = strings.settingsViewTitle()
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        customView.tableView.register(SelectionTableViewCell.self, forCellReuseIdentifier: SelectionTableViewCell.identifier)
    }

}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch viewModel.sections[indexPath.section].options[indexPath.row] {
        case .selectionCell(let model):
            model.handler()
        case .switchCell:
             break
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsType = viewModel.sections[indexPath.section].options[indexPath.row]
        
        switch settingsType {
        case .switchCell(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as! SwitchTableViewCell
            cell.setup(with: model)
            return cell
        case .selectionCell(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTableViewCell.identifier, for: indexPath) as! SelectionTableViewCell
            cell.setup(with: model)
            return cell
        }
    }
}
