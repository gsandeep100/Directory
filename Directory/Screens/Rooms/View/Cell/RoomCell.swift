//
//  RoomTableViewCell.swift
//  Directory
//
//  Created by Sandeep on 18/07/2021.
//

import Foundation
import UIKit

class RoomCell: UITableViewCell {
    
    @IBOutlet weak var id: UILabel?
    @IBOutlet weak var createdAt: UILabel?;
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var maxOccupancy: UILabel?
    @IBOutlet weak var isOccupied: UISegmentedControl?

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel : RoomCellViewModel? {
        didSet {
            
            guard let cellViewModel = cellViewModel else {
                return
            }
            id?.text = cellViewModel.id
            createdAt?.text = cellViewModel.createdAt
            name?.text = cellViewModel.name
            maxOccupancy?.text = String(cellViewModel.maxOccupancy)
            if(cellViewModel.isOccupied){
                isOccupied?.selectedSegmentIndex  = 1
            }
            else{
                isOccupied?.selectedSegmentIndex  = 0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    func initView() {
        // Cell view customization
        backgroundColor = .clear

        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.id?.text = nil
        self.name?.text = nil
        self.createdAt?.text = nil
        self.maxOccupancy?.text = nil
        self.isOccupied = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
