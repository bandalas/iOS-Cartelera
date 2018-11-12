//
//  MoreFilterSearchViewController.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 11/12/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

private let reuseIdentifier = "category_cell"
class MoreFilterSearchViewController: UICollectionViewController {
    
    var appliedCategoriesFilters:Set<String> = []
    var appliedCampusFilters:Set<String> = []
    
    var filterTypes = [Filter.FILTER_TYPE_ONE,Filter.FILTER_TYPE_TWO]
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
    
    var arrCampus = [String]()
    var completeEventCategories:Set<String> = []
    
    let headerIdentifier : String = "sectionHeader"
    var currentSectionNumber = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        self.arrCampus = GlobalFiltersList.campusList
        self.completeEventCategories = GlobalFiltersList.categoryList
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (view.frame.width - max(0, itemsPerRow - 1)*horizontalSpacing)/itemsPerRow
            flowLayout.itemSize = CGSize(width: cellWidth, height: 50)
        }
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "more")
        {
            let searchView = segue.destination as! MultipleFilterViewController
            let indexPath = sender as! NSIndexPath
            if indexPath.section == 0
            {
                searchView.newCategoryFilter = Array(completeEventCategories)[indexPath.row]
                searchView.categoryFilters = self.appliedCategoriesFilters
                searchView.campusFilters = self.appliedCampusFilters
            }
            else if indexPath.section == 1
            {
                searchView.newCampusFilter = arrCampus[indexPath.row]
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
        self.performSegue(withIdentifier: "more", sender: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! SectionHeaderCollectionReusableView
        if currentSectionNumber == 0 {
            sectionHeader.sectionLbl.text = "CATEGORIAS"
            currentSectionNumber += 1
        }
        else if currentSectionNumber == 1 {
            sectionHeader.sectionLbl.text = "CAMPUS"
            currentSectionNumber += 1
        }
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
