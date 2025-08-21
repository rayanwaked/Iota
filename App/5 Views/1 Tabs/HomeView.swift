//
//  HomeView.swift
//  Iota
//
//  Created by Rayan Waked on 6/14/25.
//

import SwiftUI
import UIKit
import SwiftData

// MARK: - VIEW
struct HomeView: View {
    @Environment(RouterCoordinator.self) private var rC
    @Environment(ManagerCoordinator.self) private var mC
    @Environment(\.modelContext) private var entry
    @Query private var entries: [Entry]
    
    var body: some View {
        List {
            ForEach(entries, id: \.self) { entry in
                Button {
                    rC.currentView = .entry
                    mC.eM.selectedEntry = entry.id
                } label: { label(for: entry) }
            }
            
            Button {
                rC.currentView = .camera
            } label: {
                Text("capture new entry")
            }
        }
        .refreshable { }
    }
}

extension HomeView {
    func label(for entry: Entry) -> some View {
        VStack {
            if let imgData = entry.img,
               let uiImage = UIImage(data: imgData) {
                Image(uiImage: uiImage)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: Screen.width, maxHeight: Screen.height / 4)
            }
            
            Text(entry.title ?? "")
        }
    }
}

// MARK: - PREVIEW
#Preview {
    @Previewable @State var rC = RouterCoordinator()
    @Previewable @State var mC = ManagerCoordinator()
    
    HomeView()
        .environment(rC)
        .environment(mC)
        .modelContainer(for: Entry.self, inMemory: true)
}
