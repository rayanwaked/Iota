//
//  EntryView.swift
//  Iota
//
//  Created by Rayan Waked on 8/19/25.
//

import SwiftUI
import SwiftData
import UIKit

// MARK: - VIEW
struct EntryView: View {
    enum ViewState {
        case view, edit
    }
    
    @Environment(RouterCoordinator.self) private var rC
    @Environment(\.modelContext) private var mC
    @Query private var entries: [Entry]
    @State var viewState: ViewState = .view
    var entryUUID: UUID
    var sE: Entry? {
        entries.first(where: {$0.id == entryUUID})
    }
    
    @State private var editTitle: String = ""
    @State private var editDesc: String = ""
    
    var body: some View {
        VStack {
            switch viewState {
            case .view: viewContent
            case .edit: editContent
            }
            
            Button {
                rC.currentView = .home
            } label: {
                Text("go back home")
            }
        }
    }
}

// MARK: - IMAGE
extension EntryView {
    var image: some View {
        VStack {
            if let imgData = sE?.img,
                let uiImage = UIImage(data: imgData) {
                    Image(uiImage: uiImage)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: Screen.width, maxHeight: Screen.height / 4)
                }
        }
    }
}

// MARK: - DATE
extension EntryView {
    var date: some View {
        Text(sE?.date?.formatted(date: .abbreviated,
                                  time: .omitted) ??
             "Unknown date")
    }
}

// MARK: - VIEW CONTENT
extension EntryView {
    var viewContent: some View {
        List {
            Text(sE?.title ?? "")
            image
            date
            Text(sE?.desc ?? "")
            
            Button {
                editTitle = sE?.title ?? ""
                editDesc = sE?.desc ?? ""
                viewState = .edit
            } label: {
                Text("edit content")
            }
        }
    }
}

// MARK: - EDIT CONTENT
extension EntryView {
    var editContent: some View {
        List {
            TextField("edit title", text: $editTitle)
            TextField("edit desc", text: $editDesc)
            
            Button {
                if let sE { mC.delete(sE) }
            } label: {
                Text("delete entry")
                    .foregroundStyle(.red)
            }
            
            Button {
                sE?.title = editTitle
                sE?.desc = editDesc
                viewState = .view
            } label: {
                Text("save changes")
            }
            
            Button {
                viewState = .view
            } label: {
                Text("view content")
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    @Previewable @State var rC = RouterCoordinator()
    
    EntryView(entryUUID: UUID())
        .environment(rC)
}

