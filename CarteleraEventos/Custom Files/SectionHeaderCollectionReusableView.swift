//
//  SectionHeaderCollectionReusableView.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 11/4/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

/**
 
 @Class: SectionHeaderCollectionReusableView
 @Description:
    Class that extends from UICollectionReusableView to customize a collection view header.
    Used for displaying the header title for each filter type
 
 */
class SectionHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var sectionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sectionLbl.layer.backgroundColor = UIColor.white.cgColor
        sectionLbl.textColor = UIColor.init(red: 254/255, green: 91/255, blue: 30/255, alpha: 1.0)
        sectionLbl.layer.cornerRadius = 5
        sectionLbl.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    
}
