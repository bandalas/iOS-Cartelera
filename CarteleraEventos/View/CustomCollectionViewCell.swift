//
//  CustomCollectionViewCell.swift
//  CarteleraEventos
//
//  Created by bandala on 11/3/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit
import QuartzCore

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: PaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.layer.backgroundColor = UIColor.red.cgColor
        lblTitle.textColor = UIColor.white
        lblTitle.layer.cornerRadius = 20
        lblTitle.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
}
