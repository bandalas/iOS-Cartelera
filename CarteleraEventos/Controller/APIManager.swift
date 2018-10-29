//
//  APIManager.swift
//  CarteleraEventos
//
//  Created by Esteban Arocha Ortuño on 3/15/18.
//  Created by Karla Robledo Bandala on 10/14/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

/*
 Class: APIManager
 Description: Clase que se encarga de crear un arreglo de tipo eventos dado el url de un API en forma
              de JSON
 */
import UIKit
import Alamofire

class APIManager
{
    
    static let sharedInstance = APIManager()
    
    var categoriesMap = [String: [Evento]]()
    
    func getEventos(completion: @escaping ([Evento]) -> Void)
    {
        var arrEventos = [Evento]()
        
        Alamofire.request(getEventsURLRequest()).responseJSON
        {
            (response) in if let arrEveJson = response.value as? [[String : Any]]
            {
                print(arrEveJson)
                for eve in arrEveJson
                {
                    let eventoTemp = Evento(ide: String(eve["id"] as! Int),
                                            fotoURL: eve["photo"] as? String,
                                            name: eve["name"] as? String,
                                            startDate: eve["startDatetime"] as? String,
                                            location: eve["location"] as? String,
                                            contactEmail: eve["contactEmail"] as? String,
                                            description: eve["description"] as? String,
                                            requirements: eve["requirementsToRegister"] as? String,
                                            schedule: eve["schedule"] as? String,
                                            petFriendly: eve["petFriendly"] as? Int,
                                            contactPhone: eve["contactPhone"] as? String,
                                            category: eve["category"] as? String,
                                            contactName: eve["contactName"] as? String,
                                            cost: eve["cost"] as? String,
                                            hasRegistration: eve["hasRegistration"] as? String,
                                            cancelled: eve["cancelled"] as? String,
                                            hasDeadline: eve["hasDeadline"] as? String,
                                            prefix: eve["prefix"] as? String,
                                            registrationDeadline: eve["registrationDeadline"] as? String,
                                            registrationUrl: eve["registrationUrl"] as? String,
                                            cancelMessage: eve["cancelMessage"] as? String,
                                            campus: eve["campus"] as? String,
                                            registrationMessage: eve["registrationMessage"] as? String)
                    
                    arrEventos.append(eventoTemp)
                    if let tagName = eve["category"] as? String
                    {
                        self.addTagToMap(tagName: tagName, event: eventoTemp)
                    }
                }
                completion(arrEventos)
            }
        }
    }
    
    /*
        Function that gets all the categories that are registered and stores them in a dictionary for
        further use
     */
    func getCategories(completion: @escaping ([Category]) -> Void)
    {
        
        var allCategories = [Category]()
        Alamofire.request(getCategoriesURLRequest()).responseJSON
        {
            (response) in if let arrCategoriesJson = response.value as? [[String : Any]]
            {
                for category in arrCategoriesJson
                {
                    let currentCategory = Category(nombre: (category["name"] as! String), todosEventos: [Evento]())
                    self.categoriesMap[currentCategory.nombre] = currentCategory.todosEventos
                    allCategories.append(currentCategory)
                }
                completion(allCategories)
            }
        }
    }
    
    func addTagToMap(tagName: String, event: Evento)
    {
       
    }
    
    private func getEventsURLRequest()->URLRequest
    {
        let eventsURL = URLRequest(url: URL(string: API.EVENTS_URL)!)
        return addKeyValuesToURLRequest(request: eventsURL)
    }
    
    private func getCategoriesURLRequest()->URLRequest
    {
        let categoriesURL = URLRequest(url: URL(string: API.CATEGORIES_URL)!)
        return addKeyValuesToURLRequest(request: categoriesURL)
    }
    
    private func addKeyValuesToURLRequest(request : URLRequest)->URLRequest
    {
        var req = request
        req.setValue(API.ACCEPT_KEY_VALUE, forHTTPHeaderField: API.ACCEPT_KEY)
        req.setValue(API.AUTHORIZATION_KEY_VALUE, forHTTPHeaderField: API.AUTHORIZATION_KEY)
        return req
    }
}
