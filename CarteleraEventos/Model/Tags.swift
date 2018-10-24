//
//  Tags.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 10/13/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

/*
 Modelo de Tag/Categoria que almacena el nombre de cada uno y los eventos correspondientes
 */
import UIKit

class Tags{
    var nombre : String!
    var todosEventos = [Evento]()
    
    init(nombre: String!, todosEventos: [Evento]!) {
        self.nombre = nombre
        self.todosEventos = todosEventos
    }
    
    
}
