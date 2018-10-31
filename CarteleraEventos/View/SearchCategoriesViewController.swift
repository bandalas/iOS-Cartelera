//
//  SearchCategoriesViewController.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 10/30/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

class SearchCategoriesViewController: UIViewController,UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrCategories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n\n\n\n")
        print("\n\n\n\n")
        for cat in arrCategories {
            print(cat.nombre)
        }
        print("\n\n\n\n")
        print("\n\n\n\n")

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension SearchCategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cv_cell", for: indexPath)
        if let label = cell.viewWithTag(20) as? UILabel{
            label.text = String(arrCategories[indexPath.row].nombre)
        }
        return cell
        
    }
    
    
    
}
