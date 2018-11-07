//
//  Evento.swift
//  CarteleraEventos
//
//  Created by Esteban Arocha Ortuño on 3/13/18.
//  Refactorization by Karla Robledo Bandala on 13/10/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

/*
 Class: Evento
 Description: Modelo Evento que servirá para obtener los campos de información necesarios de
              un objeto tipo evento
 */
import UIKit

class Evento
{
    
    var id : Int
    var foto : UIImage?
    var name : String?
    var startDate : Date
    var startTime : String
    var location : String?
    var favorites : Bool
    var contactEmail : String?
    var description: String?
    var requirements: String?
    var schedule: String?
    var petFriendly: Int?
    var contactPhone: String?
    var category: String?
    var contactName: String?
    var cost: String?
    var hasRegistration: String?
    var cancelled: String?
    var hasDeadline: String?
    var prefix: String?
    var registrationDeadline: String?
    var registrationUrl: String?
    var cancelMessage: String?
    var campus: String?
    var registrationMessage: String?
    
    init( ide: String, fotoURL: String? = "", name: String? = "", startDate: String? = "",
          location: String? = "", contactEmail: String? = "", description: String? = "",
          requirements: String? = "", schedule: String? = "", petFriendly: Int? = 0,
          contactPhone: String? = "", category: String? = "", contactName: String? = "",
          cost: String? = "", hasRegistration: String? = "", cancelled: String? = "",
          hasDeadline: String? = "", prefix: String? = "", registrationDeadline: String? = "",
          registrationUrl: String? = "", cancelMessage: String? = "",campus: String? = "",
          registrationMessage: String? = "")
    {
        self.id = Int(ide)!
        self.name = name!
        self.favorites = false
        // In case of spaces, replace the URL with %
        // DO NOT REMOVE. Can throw an exception
        let urlString:String = (fotoURL?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed))!
        let url = URL(string: urlString)
        let imgData = try? Data(contentsOf: url!)
        if imgData != nil
        {
            self.foto = UIImage(data: imgData!)!
        }
        
        // startDate is given by the server in the given format: 2018-12-25T22:16:28.000-06:00
        // arrDateTime[0] = 2018-12-25
        // arrDateTime[1] = 22:16:28.000-06:00
        let arrDateTime = startDate?.components(separatedBy: "T")
        let arrDate = arrDateTime![0].components(separatedBy: "-")
        let arrHour = arrDateTime![1].components(separatedBy: ":")
        self.startTime = arrHour[0] + ":" + arrHour[1]
        
        let year = Int(arrDate[0])
        let month = Int(arrDate[1])
        let day = Int(arrDate[2])
        let hr = Int(arrHour[0])
        let min = Int(arrHour[1])
        let sec = 0
        self.startDate = makeDate(year: year!, month: month!, day: day!, hr: hr!, min: min!,
                                  sec: sec)
        
        //  Unwraps an optional if it contains a value if not then it sets it to null
        self.location = location ?? nil
        self.description = description ?? nil
        self.contactEmail = contactEmail ?? nil
        self.requirements = requirements ?? nil
        self.schedule = schedule ?? nil
        self.petFriendly = petFriendly ?? nil
        self.contactPhone = contactPhone ?? nil
        self.category = category ?? nil
        self.contactName = contactName ?? nil
        self.cost = cost ?? nil
        self.hasRegistration = hasRegistration ?? nil
        self.cancelled = cancelled ?? nil
        self.cancelled = cancelled ?? nil
        self.hasDeadline = hasDeadline ?? nil
        self.prefix = prefix ?? nil
        self.registrationDeadline = registrationDeadline ?? nil
        self.registrationUrl = registrationUrl ?? nil
        self.cancelMessage = cancelMessage ?? nil
        self.campus = campus ?? nil
        self.registrationMessage = registrationMessage ?? nil
        
    }
    
}

// Function that returns the gregorian version of the given date
func makeDate(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> Date
{
    let calendar = Calendar(identifier: .gregorian)
    let components = DateComponents(year: year, month: month, day: day, hour: hr, minute: min, second: sec)
    return calendar.date(from: components)!
}

