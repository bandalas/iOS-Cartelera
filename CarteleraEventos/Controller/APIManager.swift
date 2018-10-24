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
    let jsonUrlString = "https://cartelera-api.herokuapp.com/events/"
    var tagsMap = [String: [Evento]]()
    
    func getEventos(completion: @escaping ([Evento]) -> Void) {
        var arrEventos = [Evento]()
        
        
        Alamofire.request(jsonUrlString).validate().responseJSON
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
    
    func getTags() -> [Tags]
    {
        print(self.tagsMap)
        var allRegisteredTags = [Tags]()
        let isMapEmpty = tagsMap.count == 0 ? true : false
        if !isMapEmpty {
            for (tagName, eventsWithTag) in tagsMap {
                let auxiliarTag = Tags(nombre: tagName, todosEventos: eventsWithTag)
                allRegisteredTags.append(auxiliarTag)
            }
        }
        return allRegisteredTags
    }
    
    func addTagToMap(tagName: String, event: Evento) {
        if var mapping = self.tagsMap[tagName]
        {
            mapping.append(event)
            self.tagsMap.updateValue(mapping, forKey: tagName)
        }
        else
        {
            var tempArray = [Evento]()
            tempArray.append(event)
            self.tagsMap[tagName] = tempArray
        }
    }
}
