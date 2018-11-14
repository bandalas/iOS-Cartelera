//
//  CategoriesCollectionViewController.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 11/3/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

private let reuseIdentifier = "category_cell"

struct GlobalFiltersList
{
    static var campusList = [String]()
    static var categoryList:Set<String> = []
}

class FilterSearchCollectionViewController: UICollectionViewController {
    
    var arrCategories = [String]()
    var arrCampus = [String]()
    let arrDates = Filter.DATE_FILTER_ARRAY
    
    var arrDictionary: NSArray!
    
    var filterTypes = [Filter.FILTER_TYPE_ONE,Filter.FILTER_TYPE_TWO, Filter.FILTER_TYPE_THREE]
    
    fileprivate let itemsPerRow: CGFloat = 2
    let headerIdentifier : String = "sectionHeader"
    
    var completeEventCategories:Set<String> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        self.arrCategories = GlobalVar.arrCategoriesGlobal
        fillCategoriesEventMap()
        GlobalFiltersList.categoryList = self.completeEventCategories
        
        if let path = Bundle.main.path(forResource: "CampusList", ofType: "plist")
        {
            arrDictionary = NSArray(contentsOfFile: path)
            fillCampusArray()
            GlobalFiltersList.campusList = self.arrCampus
        }
        else{
            print("Missing CampusList file")
        }
        
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (view.frame.width - max(0, itemsPerRow - 1)*horizontalSpacing)/itemsPerRow
            flowLayout.itemSize = CGSize(width: cellWidth, height: 50)
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
                if key as! String == "nombre"
                {
                    let campusName = object.value(forKey: key as! String)
                    self.arrCampus.append(campusName as! String)
                }
            }
        }
    }
    
    // MARK: - Navigation

    @IBAction func unwindFilters(for segue: UIStoryboardSegue, sender: Any?){
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "category")
        {
            let searchView = segue.destination as! SingleFilterViewController
            let indexPath = sender as! NSIndexPath
            if indexPath.section == 0
            {
                let categoryFilter = Array(completeEventCategories)[indexPath.row]
                searchView.categoryFilters = categoryFilter
            }
            else if indexPath.section == 1
            {
                let campusFilter = arrCampus[indexPath.row]
                searchView.campusFilters = campusFilter
            }
            else if indexPath.section == 2
            {
                let dateFilter = arrDates[indexPath.row]
                searchView.dateFilter = dateFilter
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
        if section == 2 {
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
        else if indexPath.section == 2
        {
            let dateFilter = arrDates[indexPath.row]
            cell.lblTitle.text = dateFilter
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "category", sender: indexPath)
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
        else if indexPath.section == 2
        {
            sectionHeader.sectionLbl.text = "FECHA"
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
