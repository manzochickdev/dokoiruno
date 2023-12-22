//
//  EventEntity.swift
//  Dokoiruno
//
//  Created by ECO0836_ANHPT on 22/12/2023.
//

import SwiftUI

struct EventEntity: Hashable, Identifiable, Codable {
    var id: String = UUID().uuidString
    var date: Int64
    var title: String
    var content: String
    
    func getDisplayDate() -> String {
        return self.date.toDate().format(.ddMMyyyy)
    }
    
    static func emptyInstance() -> EventEntity{
        return EventEntity(date: 0, title: "", content: "")
    }
}

typealias GroupedEventEntity = (date: String, listEventEntity:[EventEntity])

extension Collection where Element == EventEntity {
    func groupByDate() -> [GroupedEventEntity] {
        let reversedList = self.reversed()
        return Dictionary(grouping: reversedList, by: {$0.getDisplayDate()})
            .map {date, listEventEntity in
                return GroupedEventEntity(date, listEventEntity)
            }
            .sorted{$0.date < $1.date}
    }
}
