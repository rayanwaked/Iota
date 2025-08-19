//
//  RouterView.swift
//  Iota
//
//  Created by Rayan Waked on 7/31/25.
//

import SwiftUI
internal import Combine

// MARK: - VIEW
struct RouterView: View {
    @Environment(ManagerCoordinator.self) var mC
    @Environment(RouterCoordinator.self) var rC
    
    var body: some View {
        ZStack {
            switch rC.currentView {
            case .home:
                HomeView()
            case .settings:
                VStack {
                    Text("Settings")
                    Button("Go home") {
                        rC.currentView = .home
                    }
                }
            case .camera:
                CameraView()
            }
        }
    }
}

// MARK: - EXTENSION
extension RouterView {
    var some: some View {
        Text("Hello world")
    }
}

// MARK: - PREVIEW
#Preview {
    @Previewable @State var mC = ManagerCoordinator()
    @Previewable @State var rC = RouterCoordinator()
    
    RouterView()
        .environment(mC)
        .environment(rC)
}
