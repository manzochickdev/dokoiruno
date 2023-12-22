//
//  EventRepository.swift
//  Dokoiruno
//
//  Created by ECO0836_ANHPT on 22/12/2023.
//

import Foundation

class EventRepository {
    static var shared: EventRepository = EventRepository()
    private init() {}
    
    @Storage(key: UserDataKey.Event, defaultValue: [])
    var data:[EventEntity]
    
    func add(_ event: EventEntity) {
        data.append(event)
    }
    
    func add(date: Date = Date(), title: String, content: String) {
        let event: EventEntity = EventEntity(date: date.timeInMillis(), title: title, content: content)
        self.add(event)
    }
    
    func update(_ event: EventEntity) {
        guard let eventIndex = data.firstIndex(where: {$0.id == event.id}) else {
            return
        }
        data[eventIndex] = event
    }
    
    func delete(_ event: EventEntity) {
        data.removeAll(where: {$0.id == event.id})
    }
}
