//
//  EventsByDate.swift
//  CarteleraEventos
//
//  Created by Karla Robledo Bandala on 11/13/18.
//  Copyright © 2018 ESCAMA. All rights reserved.
//

import UIKit

class EventsByDate: NSObject {
    private var allEvents = [Evento]()
    
    init(events: [Evento]) {
        self.allEvents = events
    }
    
    public func getTodaysEvents() -> [Evento]
    {
        var todayEvents = [Evento]()
        let today = Date()
        for event in allEvents
        {
            if event.startDate == today
            {
                todayEvents.append(event)
            }
        }
        return todayEvents
    }
    
    public func getMonthsEvents() -> [Evento]
    {
        var monthsEvents = [Evento]()
        let today = Date()
        
        for event in allEvents
        {
            let startMonth = getStartOfMonth(date: event.startDate)
            let endMonth = getEndOfMonth(date: startMonth)
            if(today >= startMonth && today <= endMonth)
            {
                monthsEvents.append(event)
            }
        }
        return monthsEvents
    }
    
    
    public func getWeeksEvents() -> [Evento]
    {
        var weeksEvents = [Evento]()
        let today = Date()
        let endWeek = getEndOfWeek(date: today)
        for event in allEvents
        {
            if(event.startDate <= endWeek)
            {
                weeksEvents.append(event)
            }
        }
        return weeksEvents
    }
    
    private func getStartOfMonth(date: Date) -> Date
    {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for:date)))!
    }
    
    private func getEndOfMonth(date: Date) -> Date
    {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: date)!
    }
    
    private func getEndOfWeek(date: Date) -> Date
    {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
        return gregorian.date(byAdding: .day, value: 7, to: sunday!)!
    }
}
