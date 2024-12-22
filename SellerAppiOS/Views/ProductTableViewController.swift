//
//  ProductTableViewController.swift
//  SellerAppiOS
//
//  Created by Pratik Lahiri on 22/12/24.
//
import UIKit

class ProductTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ProductViewModel.shared
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 65
        
        // Register the default UITableViewCell class with the correct reuse identifier
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        
        // Fetch the products and reload the table when data is fetched
        viewModel.fetchProducts {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let headerVC = segue.destination as? HeaderViewController {
            headerVC.delegate = self
        }
    }
    
    func updateSearchResults(query: String) {
        viewModel.searchProducts(query: query)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        // Configure the cell with data
        let product = viewModel.filteredProducts[indexPath.row]
        cell.itemLabel.text = product.name
        cell.itemPrice.text = "MRP: ₹\(product.price)"
        cell.itemShipping.text = "\(product.extra)"
        return cell
    }

}

extension ProductTableViewController: HeaderViewDelegate {
    func didUpdateSearchText(_ searchText: String) {
        updateSearchResults(query: searchText)
    }
}

