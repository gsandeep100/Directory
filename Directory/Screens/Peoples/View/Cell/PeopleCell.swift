//
//  PeopleCell.swift
//  Directory
//
//  Created by Sandeep on 18/07/2021.
//

import UIKit

class PeopleCell: UITableViewCell {
    
    @IBOutlet weak var id: UILabel?
    @IBOutlet weak var avatar: UIImageView?
    @IBOutlet weak var phone: UILabel?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var email: UILabel?
    @IBOutlet weak var createdAt: UILabel?
    @IBOutlet weak var jobTitle: UILabel?
    @IBOutlet weak var address: UILabel?


    class var identifier: String { return String(describing: self) }
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel : PeopleCellViewModel? {
        didSet {
            guard let cellViewModel = cellViewModel else {
                return
            }
            
            self.backgroundColor = Utility.hexStringToUIColor(hex: cellViewModel.favouriteColor)

            self.id?.text = cellViewModel.id
            id?.textColor = contrastColor(color: self.backgroundColor!)

            self.avatar?.downloaded(from: cellViewModel.avatar)
            
            self.phone?.text = cellViewModel.phone
            phone?.textColor = contrastColor(color: self.backgroundColor!)

            self.name?.text = cellViewModel.name
            name?.textColor = contrastColor(color: self.backgroundColor!)

            self.email?.text = cellViewModel.email
            email?.textColor = contrastColor(color: self.backgroundColor!)

            self.createdAt?.text = cellViewModel.createdAt
            createdAt?.textColor = contrastColor(color: self.backgroundColor!)

            self.jobTitle?.text = cellViewModel.jobTitle
            jobTitle?.textColor = contrastColor(color: self.backgroundColor!)
            
            address?.textColor = contrastColor(color: self.backgroundColor!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.id?.text = nil
        self.avatar?.image = nil
        self.phone?.text = nil
        self.name?.text = nil
        self.email?.text = nil
        self.createdAt?.text = nil
        self.jobTitle?.text = nil
        backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView() {
        
        //setting up UIGesture to get address on click of UILabel
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.getAddress(sender:)))
        address?.addGestureRecognizer(gestureRecognizer)
        address?.adjustsFontSizeToFitWidth = true

        // Cell view customization
        backgroundColor = .clear

        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    @objc
    func getAddress(sender:UITapGestureRecognizer){
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            let address: String = Utility.getLocation(pdblLatitude: cellViewModel!.latitude, withLongitude: cellViewModel!.longitude);

            DispatchQueue.main.async {
                if(address != ""){
                    self.address?.text = address
                    self.address?.textColor = contrastColor(color: self.backgroundColor!)
                    self.address?.adjustsFontSizeToFitWidth = true
                }
            }
        }
    }
    
    func contrastColor(color: UIColor) -> UIColor {
        var d = CGFloat(0)

        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)

        color.getRed(&r, green: &g, blue: &b, alpha: &a)

        // Counting the perceptive luminance - human eye favors green color...
        let luminance = 1 - ((0.299 * r) + (0.587 * g) + (0.114 * b))

        if luminance < 0.5 {
            d = CGFloat(0) // bright colors - black font
        } else {
            d = CGFloat(1) // dark colors - white font
        }

        return UIColor( red: d, green: d, blue: d, alpha: a)
    }
}
