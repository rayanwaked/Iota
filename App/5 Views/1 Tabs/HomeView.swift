//
//  HomeView.swift
//  Iota
//
//  Created by Rayan Waked on 6/14/25.
//

import SwiftUI
import SwiftData

// MARK: - VIEW
struct HomeView: View {
    @Environment(RouterCoordinator.self) var rC
    @Query private var entries: [Entry]
    
    var body: some View {
        List {
            ForEach(entries, id: \.self) { entry in
                Text(entry.title)
            }
            
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
