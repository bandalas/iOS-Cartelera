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
    var appliedDateFilter: String?
    
    private var filterTypes = [Filter.FILTER_TYPE_ONE,Filter.FILTER_TYPE_TWO, Filter.FILTER_TYPE_THREE]
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
    
    private var arrCampus = [String]()
    private var completeEventCategories:Set<String> = []
    private var arrDates = Filter.DATE_FILTER_ARRAY
    
    private let headerIdentifier : String = "sectionHeader"
    
    
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
                searchView.dateFilter = self.appliedDateFilter
            }
            else if indexPath.section == 1
            {
                searchView.newCampusFilter = arrCampus[indexPath.row]
                searchView.campusFilters = self.appliedCampusFilters
                searchView.categoryFilters = self.appliedCategoriesFilters
                searchView.dateFilter = self.appliedDateFilter
            }
            else if indexPath.section == 2
            {
                searchView.campusFilters = self.appliedCampusFilters
                searchView.categoryFilters = self.appliedCategoriesFilters
                searchView.dateFilter = arrDates[indexPath.row]
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
        if appliedDateFilter == nil && section == 2
        {
            return arrDates.count
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
        else if indexPath.section == 2 && appliedDateFilter == nil
        {
            let dateFilter = arrDates[indexPath.row]
            cell.lblTitle.text = dateFilter
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
        if indexPath.section == 0 {
            sectionHeader.sectionLbl.text = "CATEGORIAS"
        }
        else if indexPath.section == 1 {
            sectionHeader.sectionLbl.text = "CAMPUS"
        }
        else if indexPath.section == 2 && appliedDateFilter == nil {
            sectionHeader.sectionLbl.text = "FECHA"
        }
        else if indexPath.section == 2 && appliedDateFilter != nil {
            sectionHeader.sectionLbl.text = ""
        }
        return sectionHeader;
    }
    
}
