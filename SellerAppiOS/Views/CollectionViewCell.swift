//
//  CollectionViewCell.swift
//  SellerAppiOS
//
//  Created by Pratik Lahiri on 27/12/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
