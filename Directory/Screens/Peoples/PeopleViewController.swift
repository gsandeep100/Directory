//
//  PeopleViewController.swift
//  Directory
//
//  Created by Sandeep on 18/07/2021.
//

import Foundation
import UIKit


class PeoplesViewController: UIViewController {
    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!


    lazy var viewModel = {
        PeoplesViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }

    
    func initView() {
        //As per the question
        self.view.backgroundColor = Utility.hexStringToUIColor(hex: "#C40202")

        activityIndicator.center = self.view.center;
        activityIndicator.startAnimating();
        
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
        peopleTableView.separatorColor = .white
        peopleTableView.separatorStyle = .singleLine
        peopleTableView.tableFooterView = UIView()
        peopleTableView.allowsSelection = false

        peopleTableView.register(PeopleCell.nib, forCellReuseIdentifier: PeopleCell.identifier)
    }

    func initViewModel() {
        // Get peoples data
        viewModel.getPeoples()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.peopleTableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension PeoplesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}

// MARK: - UITableViewDataSource

extension PeoplesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.peopleCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PeopleCell.identifier, for: indexPath) as? PeopleCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                // do here...
            }
        }
    }
}
