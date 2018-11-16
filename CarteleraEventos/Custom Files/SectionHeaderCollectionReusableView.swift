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
        sectionLbl.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    
}
