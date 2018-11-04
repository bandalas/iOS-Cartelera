//
//  CategoriesCollectionViewController.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 11/3/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

private let reuseIdentifier = "category_cell"

class CategoriesCollectionViewController: UICollectionViewController {
    
    var filterType: String!
    var filterData: String!
    
    var arrCategories = [String]()
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
    var completeEventCategories:Set<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fillCategoriesEventMap();
    }
    
    func fillCategoriesEventMap()
    {
        let apiCategories:Set<String> = Set(arrCategories)
        let API = APIManager.sharedInstance
        let registeredCategories:Set<String> = Set(API.getRegisteredEventsCategories())
        self.completeEventCategories = apiCategories.union(registeredCategories)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "category")
        {
            let searchView = segue.destination as! FilterViewController
            let indexPath = collectionView?.indexPathsForSelectedItems![0]
            searchView.filterType = "category"
            searchView.filterData = Array(completeEventCategories)[(indexPath?.row)!]
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return completeEventCategories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        let categoryName = Array(completeEventCategories)[indexPath.row]
        cell.lblTitle.text = categoryName
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.filterType = "category"
        self.filterData = Array (completeEventCategories)[indexPath.row]
        self.performSegue(withIdentifier: "category", sender: filterType)
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
