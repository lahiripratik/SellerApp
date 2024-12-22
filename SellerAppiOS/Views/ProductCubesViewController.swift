//
//  ProductCubeViewController.swift
//  SellerAppiOS
//
//  Created by Pratik Lahiri on 22/12/24.
//
import UIKit

class ProductCubesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    private let viewModel = ProductViewModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set delegate and data source
        collectionView.delegate = self
        collectionView.dataSource = self
        // Configure layout programmatically using delegate methods
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let headerVC = segue.destination as? HeaderViewController {
            headerVC.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let product = viewModel.filteredProducts[indexPath.row]
        cell.itemLabel.text = product.name
        cell.itemPrice.text = "₹\(product.price)"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate item size dynamically based on collection view width
        let totalSpacing = 5 * 3 // Spacing between 4 items
        let width = (collectionView.frame.width - CGFloat(totalSpacing) - 10) / 3 // Account for insets
        let height = width * 1.5// Square cells
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5 // Horizontal spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5 // Vertical spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return insets
    }
    
    func updateSearchResults(query: String) {
        viewModel.searchProducts(query: query)
        collectionView.reloadData()
    }
}

extension ProductCubesViewController: HeaderViewDelegate {
    func didUpdateSearchText(_ searchText: String) {
        updateSearchResults(query: searchText)
    }
}
