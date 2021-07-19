//
//  RoomViewController.swift
//  Directory
//
//  Created by Sandeep on 18/07/2021.
//

import Foundation
import UIKit

class RoomsViewController: UIViewController {
    @IBOutlet var roomTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    lazy var viewModel = {
        RoomsViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }

    func initView() {
        self.view.backgroundColor = Utility.hexStringToUIColor(hex: "#C40202")
        activityIndicator.center = self.view.center;
        activityIndicator.startAnimating();

        roomTableView.delegate = self
        roomTableView.dataSource = self
        roomTableView.separatorColor = .white
        roomTableView.separatorStyle = .singleLine
        roomTableView.tableFooterView = UIView()
        roomTableView.allowsSelection = false

        roomTableView.register(RoomCell.nib, forCellReuseIdentifier: RoomCell.identifier)
    }

    func initViewModel() {
        // Get peoples data
        viewModel.getRooms()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.roomTableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension RoomsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: - UITableViewDataSource

extension RoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.roomCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomCell.identifier, for: indexPath) as? RoomCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}
