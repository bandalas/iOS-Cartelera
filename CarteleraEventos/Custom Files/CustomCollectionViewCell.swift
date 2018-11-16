//
//  CustomCollectionViewCell.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 11/3/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit
import QuartzCore

/**
 
 @Class: CustomCollectionViewCell
 @Description:
    Class that extends from UICollectionViewCell to customize a collection view cell.
    Used for displaying the filter tag's name
 
 */

class CustomCollectionViewCell: UICollectionViewCell {
    /// tag's name label
    // Of type PaddingLabel so a customized padding could be added
    @IBOutlet weak var lblTitle: PaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //This is where the color of the padding is set
        lblTitle.layer.backgroundColor = UIColor.init(red: 30/255, green: 136/255, blue: 229/255, alpha: 1.0).cgColor
        lblTitle.textColor = UIColor.white
        lblTitle.layer.cornerRadius = 8
        lblTitle.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
}
