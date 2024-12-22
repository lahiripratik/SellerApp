//
//  HeaderViewController.swift
//  SellerAppiOS
//
//  Created by Pratik Lahiri on 29/12/24.
//

import UIKit

protocol HeaderViewDelegate{
    func didUpdateSearchText(_ text : String)
}

class HeaderViewController : UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: HeaderViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        // Set initial search text from the ViewModel
        searchBar.text = ProductViewModel.shared.searchText
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // Ensure table view taps are still recognized
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the search bar text from the stored search text every time the view appears
        searchBar.text = ProductViewModel.shared.searchText
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        ProductViewModel.shared.searchText = searchText  // Update the ViewModel's searchText
        delegate?.didUpdateSearchText(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Dismiss the keyboard explicitly
        ProductViewModel.shared.searchText = searchBar.text ?? "" // Store the final search text in the ViewModel
        delegate?.didUpdateSearchText(searchBar.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = "" // Clear the search text
        searchBar.resignFirstResponder() // Dismiss the keyboard explicitly
        ProductViewModel.shared.searchText = "" // Clear the search text in the ViewModel
        delegate?.didUpdateSearchText("")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // Dismiss the keyboard
    }
}
