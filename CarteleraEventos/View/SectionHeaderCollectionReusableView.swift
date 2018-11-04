//
//  SectionHeaderCollectionReusableView.swift
//  CarteleraEventos
//
//  Created by bandala on 11/4/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

class SectionHeaderCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak private var sectionLbl: UILabel!
    var sectionName : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sectionLbl.text = sectionName
    }
    
    
}
