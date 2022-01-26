//
//  FactListViewController.swift
//  CatFacts
//
//  Created by Kerem Gunduz on 30/03/2021.
//

import UIKit

final class FactsListViewController: BaseMVPController<FactsListPresenter, FactListViewable> {
    
    private lazy var factsTableView: UITableView = {
        let tableView: UITableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(FactItemTableViewCell.self,
                           forCellReuseIdentifier: FactItemTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func createPresenter() -> FactsListPresenter? {
        return FactsListPresenter(service: FactsApi())
    }
    
    private func configureTable() {
        view.addSubview(factsTableView)
        factsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        factsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        factsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        factsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()

        presenter?.attachView(self)
        presenter?.fetchCatFacts()
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
    
    func stopLoading() {
        
    }
    
    func didSucceed() {
        factsTableView.reloadData()
    }
}
