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
        VStack {
            header
            ScrollView {
                ForEach(entries, id: \.self) { entry in
                    Button {
                        rC.currentView = .entry
                        mC.eM.selectedEntry = entry.id
                    } label: { card(for: entry) }
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
}

// MARK: - EXTENSIONS
extension HomeView {
    // MARK: - HOME HEADER
    var header: some View {
        HStack {
            Text("Iota")
                .font(.system(size: 34))
                .monospaced()
                .bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Padding.standard)
    }


    // MARK: - ENTRY CARD
    func card(for entry: Entry) -> some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                image(for: entry)
                
                date(for: entry)
                .padding(.horizontal, Padding.standard)
            }
            
            title(for: entry)
            description(for: entry)
        }
    }


    // MARK: - ENTRY TITLE
    func title(for entry: Entry) -> some View {
        Text(entry.title ?? "unknown entry")
    }


    // MARK: - ENTRY DATE
    func date(for entry: Entry) -> some View {
        Text(entry.date?
            .formatted(
                date: .abbreviated,
                time: .omitted
            ) ?? "date unknown"
        )
        .padding(.horizontal, Padding.standard)
    }


    // MARK: - ENTRY DESCRIPTION
    func description(for entry: Entry) -> some View {
        Text(entry.desc ?? "no description")
    }


    // MARK: - ENTRY IMAGE
    func image(for entry: Entry) -> some View {
        VStack {
            if let imgData = entry.img,
               let uiImage = UIImage(data: imgData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: Screen.width, maxHeight: Screen.height / 4)
            }
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
