//
//  CustomTableViewCell.swift
//  CarteleraEventos
//
//  Created by Esteban Arocha Ortuño on 3/13/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var foto: UIImageView!
    
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var startTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
