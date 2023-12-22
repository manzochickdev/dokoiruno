//
//  EventModifyScreen.swift
//  Dokoiruno
//
//  Created by ECO0836_ANHPT on 22/12/2023.
//

import SwiftUI

struct EventModifyScreen: View {
    @Environment(\.router) private var router: Router
    @State var currentDate: Date = Date()
    @State var title: String = ""
    @State var content: String = ""
    @StateObject private var viewModel = EventModifyScreen.ViewModel()
    
    var eventEntity: EventEntity?
    
    init(eventEntity: EventEntity? = nil) {
        guard let eventEntity = eventEntity else { return }
        
        self.eventEntity = eventEntity
        self._currentDate = State(wrappedValue:  eventEntity.date.toDate())
        self._title = State(wrappedValue: eventEntity.title)
        self._content = State(wrappedValue:  eventEntity.content)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Date")
                .font(.title)
            DatePicker("",
                       selection: $currentDate,
                       displayedComponents: [.date]
            )
            
            Text("Title")
            .font(.title)
            TextField("", text: $title)
            
            Text("Content")
                .font(.title)
            TextField("", text: $content)
            
            Spacer()
                
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .navigationTitle("")
        .toolbar {
            HStack {
                if let eventEntity = eventEntity {
                    Button {
                        viewModel.delete(eventEntity)
                        router.popToRoot()
                    } label: {
                        Text("Delete")
                    }
                }
                
                Button {
                    onFinishModifyEvent()
                    router.pop()
                } label: {
                    Text("Done")
                }
            }
        }
    }
    
    func onFinishModifyEvent() {
        if var eventEntity = eventEntity {
            eventEntity.date = currentDate.timeInMillis()
            eventEntity.title = title
            eventEntity.content = content
            viewModel.update(eventEntity)
        }
        else {
            let eventEntity = EventEntity(date: currentDate.timeInMillis(), title: title, content: content)
            viewModel.add(eventEntity)
        }
    }
}

extension EventModifyScreen {
    class ViewModel: ObservableObject {
        private var eventRepository = EventRepository.shared
        
        func add(_ event: EventEntity) {
            eventRepository.add(event)
        }
        
        func update(_ event: EventEntity) {
            eventRepository.update(event)
        }
        
        func delete(_ event: EventEntity) {
            eventRepository.delete(event)
        }
    }
}

