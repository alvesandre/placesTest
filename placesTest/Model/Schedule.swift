//
//  Schedule.swift
//  placesTest
//
//  Created by André Alves on 22/07/20.
//  Copyright © 2020 André Alves. All rights reserved.
//

import UIKit

class Schedule: Decodable {
    var monday: Day
    var tuesday: Day
    var wednesday: Day
    var thursday: Day
    var friday: Day
    var saturday: Day
    var sunday: Day
    
    func getGroups() -> [String] {
        var groupDays = [(id: "monday", schedule: monday), (id: "tuesday", schedule: tuesday), (id: "wednesday", schedule: wednesday), (id: "thursday", schedule: thursday), (id: "friday", schedule: friday), (id: "saturday", schedule: saturday),(id: "sunday", schedule: sunday)]
        var groupStrings: [(initial:String, final: String, schedule: Day, numberOfDays: Int)] = []
        while !groupDays.isEmpty {
            let day = groupDays[0]
            let filterGroupDays = groupDays.filter({$0.schedule.open == day.schedule.open && $0.schedule.close == day.schedule.close})
            if let first = filterGroupDays.first, let last = filterGroupDays.last {
                groupStrings.append((initial: first.id, final: last.id, schedule: first.schedule, numberOfDays: filterGroupDays.count))
            }
            groupDays.removeAll { (day) -> Bool in
                filterGroupDays.contains(where: {$0.id == day.id})
            }
        }
        return getLimitString(with: groupStrings)
    }
    
    private func getLimitString(with groupStrings: [(initial:String, final: String, schedule: Day, numberOfDays: Int)]) -> [String] {
        var strings: [String] = []
        for groupString in groupStrings {
            if groupString.numberOfDays == 1 {
                strings.append("\(getMonthNameAbrev(with: groupString.initial)): \(groupString.schedule.open) às \(groupString.schedule.close)")
            } else if groupString.numberOfDays == 2 {
                strings.append("\(getMonthNameAbrev(with: groupString.initial)) e \(getMonthNameAbrev(with: groupString.final)): \(groupString.schedule.open) às \(groupString.schedule.close)")
            } else {
                strings.append("\(getMonthNameAbrev(with: groupString.initial)) a \(getMonthNameAbrev(with: groupString.final)): \(groupString.schedule.open) às \(groupString.schedule.close)")
            }
        }
        return strings
    }
    
    private func getMonthNameAbrev(with name: String) -> String {
        switch name {
        case "monday":
            return "seg"
        case "tuesday":
            return "ter"
        case "wednesday":
            return "qua"
        case "thursday":
            return "qui"
        case "friday":
            return "sex"
        case "saturday":
            return "sáb"
        case "sunday":
            return "dom"
        default:
            return ""
        }
    }
        
}
