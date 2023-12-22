//
//  EnvironmentKey+Ext.swift
//  Dokoiruno
//
//  Created by ECO0836_ANHPT on 22/12/2023.
//

import SwiftUI

struct RouterKey: EnvironmentKey {
    static var defaultValue: Router = Router()
}

extension EnvironmentValues {
    var router: Router {
        get {self[RouterKey.self]}
        set {self[RouterKey.self] = newValue}
    }
}
