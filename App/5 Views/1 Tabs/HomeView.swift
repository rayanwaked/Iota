//
//  HomeView.swift
//  Iota
//
//  Created by Rayan Waked on 6/14/25.
//

import SwiftUI

// MARK: - VIEW
struct HomeView: View {
    @Environment(RouterCoordinator.self) var rC
    
    var body: some View {
        List {
            Text("Entry 1")
            Text("Entry 2")
            Text("Entry 3")
            Text("Entry 4")
            Button {
                rC.currentView = .camera
            } label: {
                Text("capture new entry")
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    @Previewable @State var rC = RouterCoordinator()
    
    HomeView()
        .environment(rC)
}
