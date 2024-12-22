//
//  ProductViewModel.swift
//  SellerAppiOS
//
//  Created by Pratik Lahiri on 22/12/24.
//

import Foundation

class ProductViewModel {
    
    private let productService = ProductService()

    private var allProducts: [Product] = [] // All fetched products
    var filteredProducts: [Product] = []    // Filtered products for search results
    
    var searchText: String = ""
    
    static let shared = ProductViewModel()
    private init() {}
    
    func fetchProducts(completion: @escaping () -> Void) {
        productService.fetchProducts { result in
            switch result {
            case .success(let products):
                self.allProducts = products
                self.filteredProducts = products // Initially, filteredProducts is the same as allProducts
                completion()
            case .failure(let error):
                print("Error fetching products: \(error)")
            }
        }
    }
    
    func searchProducts(query: String) {
        self.searchText = query  // Update search text in the ViewModel
        if query.isEmpty {
            filteredProducts = allProducts
        } else {
            filteredProducts = allProducts.filter { product in
                product.name.lowercased().contains(query.lowercased())
            }
        }
    }
}
