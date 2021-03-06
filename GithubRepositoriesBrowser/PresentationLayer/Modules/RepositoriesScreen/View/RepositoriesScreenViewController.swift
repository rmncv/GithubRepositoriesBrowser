//
//  RepositoriesScreenRepositoriesScreenViewController.swift
//  GithubRepositoriesBrowser
//
//  Created by Denis Rumiantsev on 20/12/2017.
//  Copyright © 2017 Denys Rumiantsev. All rights reserved.
//

import UIKit

class RepositoriesScreenViewController: UIViewController, RepositoriesScreenViewInput {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var output: RepositoriesScreenViewOutput!
    var repositories = [GithubRepositoryPlain]()
    var itemsPerPage: Int!
    var currentPage: Int!
    private var editingEnabled = false
    
    private var couldLoadMore: Bool {
        
        let isAllowedNextPageLoading = (repositories.count % (currentPage * itemsPerPage)) == 0
        
        if !isAllowedNextPageLoading {
            tableView.tableFooterView = nil
        } else if tableView.tableFooterView == nil {
            tableView.tableFooterView = tableViewFooterActivityIndicator
        }
        return isAllowedNextPageLoading
    }
    private var tableViewFooterActivityIndicator: UIActivityIndicatorView?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: RepositoriesScreenViewInput
    func setupInitialState(forState state: RepositoriesScreenConfigurator.State) {
        
        switch state {
        case .search(let q):
            navigationItem.title = q
            
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(RepositoriesScreenViewController.didPressedCancelSearchButton))
            navigationItem.rightBarButtonItem = cancelButton
            
        case .recent:
            setupRightBarButtonItemOnRecent()
            editingEnabled = true
            navigationItem.title = "Recent"
        }
        
        activityIndicator.stopAnimating()
        createFooterView()
        
        tableView.registerNibWithSameNameAsClass(type: GithubRepositoryCell.self)
    }
    
    func add(_ repositories: [GithubRepositoryPlain]) {
        self.repositories.append(contentsOf: repositories)
    }
    
    func replace(_ repository: GithubRepositoryPlain, with newRepositry: GithubRepositoryPlain) {
        guard let index = repositories.index(of: repository) else {
            return
        }
        repositories[index] = newRepositry
        tableView.reloadRow(at: IndexPath(item: index, section: 0))
    }
    
    func delete(_ repository: GithubRepositoryPlain) {
        guard let index = repositories.index(of: repository) else {
            return
        }
        repositories.remove(at: index)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func makeRightBarButtonItem(enabled: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = enabled
    }
    
    func makeActivityIndicator(hidden: Bool) {
        hidden ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
    }
    
    // MARK: - Tech
    private func createFooterView() {
        let pagingSpinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        pagingSpinner.startAnimating()
        pagingSpinner.color = .black
        pagingSpinner.hidesWhenStopped = true
        tableViewFooterActivityIndicator = pagingSpinner
    }
    
    private func setupRightBarButtonItemOnRecent() {
        let item: UIBarButtonSystemItem = tableView.isEditing ? .cancel : .edit
        let editButton = UIBarButtonItem(barButtonSystemItem: item, target: self, action: #selector(RepositoriesScreenViewController.didPressedEditButton))
        navigationItem.rightBarButtonItem = editButton
    }
    
    // MARK: - Actions
    @objc private func didPressedCancelSearchButton() {
        output.didPressedCancelSearch()
    }

    @objc private func didPressedEditButton() {
        tableView.isEditing.toggle()
        setupRightBarButtonItemOnRecent()
    }
}

// MARK: - UITableViewDataSource
extension RepositoriesScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: GithubRepositoryCell.self)
        let repository = repositories[indexPath.item]
        cell.configure(with: repository)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RepositoriesScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let repository = repositories[indexPath.item]
        output.didSelected(repository)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == repositories.count - 1 && couldLoadMore {
            output.didRequestNextRepositoriesPage()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard editingEnabled else {
            return nil
        }
        let repository = repositories[indexPath.item]
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [unowned self] _, indexPath in
            tableView.performOnUpdates({
                self.output.didPressedDelete(repository)
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
        }
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = repositories[sourceIndexPath.item]
        repositories.remove(at: sourceIndexPath.row)
        repositories.insert(movedObject, at: destinationIndexPath.row)
    }
}
