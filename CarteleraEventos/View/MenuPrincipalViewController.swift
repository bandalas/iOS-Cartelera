//
//  MenuPrincipalViewController.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 10/13/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

class MenuPrincipalViewController: UITabBarController {
    
    /*
        Asignar el segundo elemento del menu principal -Eventos- para que sea
        la primera opción por cargar
    */

    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        self.selectedIndex = 1
    }
    
}
