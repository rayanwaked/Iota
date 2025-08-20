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
    @Query private var entries: [Entry]
    var entryUUID: UUID
    
    var sE: Entry? {
        entries.first(where: {$0.id == entryUUID})
    }
    
    var body: some View {
        VStack {
            Text(sE?.title ?? "")
            Text("\(sE?.date ?? Date())")
            Text(sE?.desc ?? "")
            if let imgData = sE?.img, let uiImage = UIImage(data: imgData) {
                Image(uiImage: uiImage)
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    EntryView(entryUUID: UUID())
}
