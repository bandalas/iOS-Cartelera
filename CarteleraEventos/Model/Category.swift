//
//  Categories.swift
//  CarteleraEventos
//
//  Created by bandala on 10/26/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

class Category {
    var nombre : String!
    var todosEventos = [Evento]()
    
    init(nombre: String!, todosEventos: [Evento]!) {
        self.nombre = nombre
        self.todosEventos = todosEventos
    }
}
