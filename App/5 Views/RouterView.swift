//
//  RouterView.swift
//  Iota
//
//  Created by Rayan Waked on 7/31/25.
//

import SwiftUI
import SwiftData
internal import Combine

// MARK: - VIEW
struct RouterView: View {
    @Environment(ManagerCoordinator.self) private var mC
    @Environment(RouterCoordinator.self) private var rC
    
    var body: some View {
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
        case .entry:
            EntryView(entryUUID: mC.eM.selectedEntry ?? UUID())
        }
    }
}

// MARK: - EXTENSION
extension RouterView {
}

// MARK: - PREVIEW
#Preview {
    @Previewable @State var mC = ManagerCoordinator()
    @Previewable @State var rC = RouterCoordinator()
    
    RouterView()
        .environment(mC)
        .environment(rC)
        .modelContainer(for: Entry.self, inMemory: true)
}
