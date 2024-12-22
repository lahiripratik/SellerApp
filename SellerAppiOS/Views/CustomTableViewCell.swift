//
//  CustomTableViewCell.swift
//  SellerAppiOS
//
//  Created by Pratik Lahiri on 25/12/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var itemLabel: UILabel!
        
    
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemShipping: UILabel!
    
    @IBOutlet weak var itemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
