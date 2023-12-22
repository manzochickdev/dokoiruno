//
//  EventDetailScreen.swift
//  Dokoiruno
//
//  Created by ECO0836_ANHPT on 22/12/2023.
//

import SwiftUI

struct EventDetailScreen: View {
    @Environment(\.router) private var router: Router
    @StateObject var viewModel: EventDetailScreen.ViewModel
    
    init(eventEntity: EventEntity) {
        _viewModel = StateObject(wrappedValue: EventDetailScreen.ViewModel(eventEntity: eventEntity))
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(viewModel.eventEntity.getDisplayDate())
            Text(viewModel.eventEntity.content)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .navigationTitle(viewModel.eventEntity.title)
        .toolbar {
            Button {
                router.push(.eventCreate(eventEntity: viewModel.eventEntity))
            } label: {
                Text("Detail")
            }
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

extension EventDetailScreen {
    class ViewModel: ObservableObject {
        private var eventRepository = EventRepository.shared
        @Published var eventEntity: EventEntity
        
        init(eventEntity: EventEntity) {
            self.eventEntity = eventEntity
        }
        
        func onAppear() {
            let id = eventEntity.id
            eventEntity = eventRepository.data.first(where: {$0.id == id}) ?? EventEntity.emptyInstance()
        }
    }
}

