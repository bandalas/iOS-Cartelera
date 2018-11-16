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
 Description: Clase que se encuentra de administrar todo lo que tiene que ver con el API
 */
import UIKit
import Alamofire

class APIManager
{
    
    static let sharedInstance = APIManager()
    var eventCategories = [String]()
    
    // MARK: - API Query
    
    func getEventos(completion: @escaping ([Evento]) -> Void)
    {
        var arrEventos = [Evento]()
        
        Alamofire.request(getEventsURLRequest()).responseJSON
        {
            (response) in if let arrEveJson = response.value as? [[String : Any]]
            {
                for eve in arrEveJson
                {
                    print(eve)
                    print("\n\n\n")
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
                                            registrationMessage: eve["registrationMessage"] as? String,
                                            latitude: eve["latitude"] as? Double,
                                            longitude: eve["longitude"] as? Double)
                    
                    arrEventos.append(eventoTemp)
                    let tagName = eve["category"] as? String
                    self.addCategoryToString(tagName: tagName)
                    
                }
                completion(arrEventos)
            }
        }
    }
    
    /*
        Function that gets all the categories that are registered and stores them in a dictionary for
        further use
     */
    
    func getCategories(completion: @escaping ([String]) -> Void)
    {
        
        var allCategories = [String]()
        Alamofire.request(getCategoriesURLRequest()).responseJSON
        {
            (response) in if let arrCategoriesJson = response.value as? [[String : Any]]
            {
                for category in arrCategoriesJson
                {
                    let currentCategory = category["name"] as! String
                    allCategories.append(currentCategory)
                }
                completion(allCategories)
            }
        }
    }
    
    func getEventosByFilter(filterData: [String: [String]], completion: @escaping ([Evento]) -> Void)
    {
        var filteredEvents = [Evento]()
        Alamofire.request(getBuildSearchQueryURLRequest(data: filterData)).responseJSON
            {
                (response) in if let arrEventsJSON = response.value as? [[String : Any]]
                {
                    for eve in arrEventsJSON
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
                                                registrationMessage: eve["registrationMessage"] as? String,
                                                latitude: eve["latitude"] as? Double,
                                                longitude: eve["longitude"] as? Double)
                        
                        filteredEvents.append(eventoTemp)
                    }
                    completion(filteredEvents)
                }
        }
    }
    
    func addCategoryToString(tagName: String?)
    {
        let categoryName = tagName ?? "Otro"
        if !eventCategories.contains(categoryName){
            self.eventCategories.append(categoryName)
        }
    }
    
    func getRegisteredEventsCategories () ->  [String]
    {
        return self.eventCategories
    }
    
    // MARK: - API Set-Up
    
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
    
    private func getBuildSearchQueryURLRequest(data: [String: [String]]) -> URLRequest
    {
        var queryURL = API.EVENTS_QUERY_URL
        for (key,value) in data {
            print(value)
            for filterName in value {
                queryURL = queryURL+key+"="+filterName+"&"
            }
        }
        let urlString:String = (queryURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed))!
        
        print("@@@@@\(urlString)")
        let completeQueryURL = URLRequest(url: URL(string: urlString)!)
        return addKeyValuesToURLRequest(request: completeQueryURL)
    }
    
    private func addKeyValuesToURLRequest(request : URLRequest)->URLRequest
    {
        var req = request
        req.setValue(API.ACCEPT_KEY_VALUE, forHTTPHeaderField: API.ACCEPT_KEY)
        req.setValue(API.AUTHORIZATION_KEY_VALUE, forHTTPHeaderField: API.AUTHORIZATION_KEY)
        return req
    }
}
