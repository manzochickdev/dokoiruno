//
//  Router.swift
//  Dokoiruno
//
//  Created by ECO0836_ANHPT on 22/12/2023.
//

import SwiftUI

class Router: ObservableObject {
    enum Route: Hashable {
        case home
        case eventCreate(eventEntity: EventEntity?)
        case eventDetail(eventEntity: EventEntity)
    }
    
    @Published var path: NavigationPath = NavigationPath()
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .home:
            HomeScreen()
        case .eventCreate(let eventEntity):
            EventModifyScreen(eventEntity: eventEntity)
        case .eventDetail(let eventEntity):
            EventDetailScreen(eventEntity: eventEntity)
        }
    }
    
    func push(_ appRoute: Route) {
        path.append(appRoute)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

