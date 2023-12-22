//
//  HomeScreen.swift
//  Dokoiruno
//
//  Created by ECO0836_ANHPT on 22/12/2023.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(\.router) private var router: Router
    @StateObject var viewModel: HomeScreen.ViewModel = HomeScreen.ViewModel()
    
    var body: some View {
        List(viewModel.listEventEntity, id: \.date) { item in
            Section {
                ForEach(item.listEventEntity, id: \.id) { eventEntity in
                    Text(eventEntity.title)
                        .onTapGesture {
                            router.push(.eventDetail(eventEntity: eventEntity))
                        }
                }
            } header: {
                Text(item.date)
            }
        }
        .navigationTitle("Home")
        .toolbar{
            Button(action: {
                router.push(.eventCreate(eventEntity: nil))
            }, label: {
                Image(systemName: "plus")
            })
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

extension HomeScreen {
    class ViewModel: ObservableObject {
        private var eventRepository = EventRepository.shared
        @Published var listEventEntity: [GroupedEventEntity] = []
        
        func onAppear() {
            listEventEntity = eventRepository.data.groupByDate()
        }
    }
}
