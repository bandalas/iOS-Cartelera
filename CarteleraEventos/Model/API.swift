//
//  API.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 10/26/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

class API {
    
    public static let EVENTS_URL : String = "https://cartelerai-api.herokuapp.com/events"
    public static let UPCOMING_EVENTS_URL : String = "https://cartelerai-api.herokuapp.com/upcoming_events"
    public static let CATEGORIES_URL : String = "https://cartelerai-api.herokuapp.com/categories"
    
    public static let ACCEPT_KEY : String = "Accept"
    public static let ACCEPT_KEY_VALUE : String = "application/vnd.cartelera-api.v1"
    
    public static let AUTHORIZATION_KEY : String = "Authorization"
    public static let AUTHORIZATION_KEY_VALUE : String = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.sgAjfo5zm77syDfPFxnMzt6ASC2JcAhGdKb8jCJCBBs"
    
}
