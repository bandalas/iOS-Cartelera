//
//  CategoriesCollectionViewController.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 11/3/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

private let reuseIdentifier = "category_cell"

class FilterSearchCollectionViewController: UICollectionViewController {
    
    var filterType: String!
    var filterData: String!
    
    var arrCategories = [String]()
    var arrCampus = [String]()
    
    var arrDictionary: NSArray!
    var appliedCategoriesFilters:Set<String> = []
    var appliedCampusFilters:Set<String> = []
    
    var filterTypes = [Filter.FILTER_TYPE_ONE,Filter.FILTER_TYPE_TWO]
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
    
    var completeEventCategories:Set<String> = []
    
    let headerIdentifier : String = "sectionHeader"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fillCategoriesEventMap()
        if let path = Bundle.main.path(forResource: "CampusList", ofType: "plist")
        {
            arrDictionary = NSArray(contentsOfFile: path)
            fillCampusArray()
        }
        else{
            print("Missing CampusList file")
        }
    }
    
    func fillCategoriesEventMap()
    {
        let apiCategories:Set<String> = Set(arrCategories)
        let API = APIManager.sharedInstance
        let registeredCategories:Set<String> = Set(API.getRegisteredEventsCategories())
        self.completeEventCategories = apiCategories.union(registeredCategories)
    }
    
    func fillCampusArray()
    {
        for element in arrDictionary
        {
            let object = element as! NSDictionary
            for(key,_) in object
            {
                let campusName = object.value(forKey: key as! String)
                self.arrCampus.append(campusName as! String)
            }
        }
    }

    
    // MARK: - Navigation

    @IBAction func unwindFilters(for segue: UIStoryboardSegue, sender: Any?){
        print("IM BACK")
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "category")
        {
            let searchView = segue.destination as! FilterViewController
            let indexPath = collectionView?.indexPathsForSelectedItems![0]
            if indexPath?.section == 0
            {
                let tempSet: Set<String> = [Array(completeEventCategories)[(indexPath?.row)!]]
                self.appliedCategoriesFilters = appliedCategoriesFilters.union(tempSet)
                searchView.categoryFilters = self.appliedCategoriesFilters
                searchView.campusFilters = self.appliedCampusFilters
            }
            else if indexPath?.section == 1
            {
                let tempSet: Set<String> = [arrCampus[(indexPath?.row)!]]
                self.appliedCampusFilters = appliedCampusFilters.union(tempSet)
                searchView.campusFilters = self.appliedCampusFilters
                searchView.categoryFilters = self.appliedCategoriesFilters
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return filterTypes.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return completeEventCategories.count
        }
        if section == 1 {
            return arrCampus.count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        if indexPath.section == 0
        {
            let categoryName = Array(completeEventCategories)[indexPath.row]
            cell.lblTitle.text = categoryName
        }
        else if indexPath.section == 1
        {
            let campusName = arrCampus[indexPath.row]
            cell.lblTitle.text = campusName
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.filterType = "category"
        self.filterData = Array (completeEventCategories)[indexPath.row]
        self.performSegue(withIdentifier: "category", sender: filterType)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! SectionHeaderCollectionReusableView
        sectionHeader.sectionName = filterTypes[indexPath.row]
        return sectionHeader;
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
