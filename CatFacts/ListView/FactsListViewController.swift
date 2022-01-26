//
//  FactListViewController.swift
//  CatFacts
//
//  Created by Kerem Gunduz on 30/03/2021.
//

import UIKit

final class FactsListViewController: BaseMVPController<FactsListPresenter, FactListViewable> {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar: UISearchBar = UISearchBar(frame: view.bounds)
        searchBar.barStyle = .default
        searchBar.searchTextField.addDoneButtonOnKeyboard()
        searchBar.placeholder = "search ^.^"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var factsTableView: UITableView = {
        let tableView: UITableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(FactItemTableViewCell.self,
                           forCellReuseIdentifier: FactItemTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addPulltoRefreshControl(
            controller: self,
            doing: #selector(pullToRefresh),
            with: .init(string: "loading our awesome facts..."), tintColor: nil)
        return tableView
    }()
    
    override func createPresenter() -> FactsListPresenter? {
        return FactsListPresenter(service: FactsApi())
    }
    
    private func configureSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    
    private func configureTable() {
        view.addSubview(factsTableView)
        factsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        factsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        factsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        factsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fun Facts about...CATS!"
        configureSearchBar()
        configureTable()
        presenter?.attachView(self)
        presenter?.fetchCatFacts()
    }
    
    @objc func pullToRefresh() {
        presenter?.fetchCatFacts()
    }
}

extension FactsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.search(for: searchBar.text ?? "")
    }
}

extension FactsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCatFacts().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FactItemTableViewCell.identifier, for: indexPath) as? FactItemTableViewCell else {return UITableViewCell()}
        cell.configure(presenter?.getCatFacts()[indexPath.row])
        return cell
    }
}

extension FactsListViewController: FactListViewable {
    func reloadData() {
        factsTableView.reloadData()
    }
    
    func stopLoading() {
        factsTableView.endRefreshing()
    }
    
    func didSucceed() {
        factsTableView.reloadData()
    }
}
