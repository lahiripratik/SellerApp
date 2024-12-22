//
//  TabBarContoller.swift
//  SellerAppiOS
//
//  Created by Pratik Lahiri on 29/12/24.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Access each child view controller
        if let tableVC = viewControllers?[0] as? ProductTableViewController,
           let headerVC = tableVC.children.first(where: { $0 is HeaderViewController }) as? HeaderViewController {
            headerVC.delegate = tableVC
        }

        if let collectionVC = viewControllers?[1] as? ProductCubesViewController,
           let headerVC = collectionVC.children.first(where: { $0 is HeaderViewController }) as? HeaderViewController {
            headerVC.delegate = collectionVC
        }
    }
}
