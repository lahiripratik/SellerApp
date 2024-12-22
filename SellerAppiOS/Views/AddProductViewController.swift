//
//  AddProductViewController.swift
//  SellerAppiOS
//
//  Created by Pratik Lahiri on 22/12/24.
//

import UIKit
import DropDown

class AddProductViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var headerBar: UIView!
    
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var itemPriceField: UITextField!
    
    @IBOutlet weak var dropdown: UIView!
    @IBOutlet weak var dropdownLabel: UILabel!
    
    let dropDown = DropDown()
    
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func dropdownPressed(_ sender: Any) {
        dropDown.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide search bar
        if let searchBar = headerBar.viewWithTag(102) as? UISearchBar {
            searchBar.isHidden = true
        }

        // Update label text
        if let label = headerBar.viewWithTag(100) as? UILabel {
            label.text = "Add Item"
        }

        // Update button text
        if let button = headerBar.viewWithTag(101) as? UIButton {
            button.setTitle("Add", for: .normal)
        }
        
        dropDown.anchorView = dropdown
        let dropdownValues = ["Same Day Shipping", "None"]
        dropDown.dataSource = dropdownValues
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.dropdownLabel.text = item
        }
        itemNameField.borderStyle = .roundedRect
        itemPriceField.borderStyle = .roundedRect
        dropdown.layer.cornerRadius = dropdown.frame.height / 10
        submitButton.layer.cornerRadius = dropdown.frame.height / 10
        
        //Code to minimise keyboard on outside taps/return
        
        self.itemNameField.delegate = self
        self.itemPriceField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemNameField.text = ""
        itemPriceField.text = ""
        dropdownLabel.text = "Shipping Method"
    }
}
