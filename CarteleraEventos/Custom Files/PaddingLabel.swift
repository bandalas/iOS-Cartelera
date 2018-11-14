//
//  PaddingLabel.swift
//  CarteleraEventos
//
//  Created by Karla Rolbedo Bandala on 11/11/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit
/**
 
 @Class: Padding Label
 @Description:
    Class that extends from UILabel to customize labels. It will add a padding
    to the label. For aesthetic purposes
 
 */

class PaddingLabel: UILabel {
    /// Padding object
    // If wanted to reduce or increase the padding, this should be the cody to modify
    let padding = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
    
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
}
