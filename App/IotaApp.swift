//
//  IotaApp.swift
//  Iota
//
//  Created by Rayan Waked on 6/14/25.
//

import SwiftUI
import SwiftData

// MARK: - MAIN APP
@main
struct IotaApp: App {
    @State private var mC = ManagerCoordinator()
    @State private var rC = RouterCoordinator()
    
    var body: some Scene {
        WindowGroup {
            RouterView()
                .environment(mC)
                .environment(rC)
        }
        .modelContainer(for: Entry.self)
    }
}

// MARK: - ROUTER COORDINATOR
@Observable
final class RouterCoordinator {
    enum views {
        case home, settings, camera
    }
    
    var currentView = views.home
}

// MARK: - MANAGER COORDINATOR
@Observable
final class ManagerCoordinator {}
