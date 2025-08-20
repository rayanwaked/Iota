//
//  EntryModel.swift
//  Iota
//
//  Created by Rayan Waked on 8/19/25.
//

import SwiftUI
import SwiftData

// MARK: - ENTRY
@Model
final class Entry {
    var id = UUID()
    var title: String?
    var date: Date?
    var desc: String?
    var img: Data?

    init(title: String, date: Date, desc: String, img: Data) {
        self.title = title
        self.date = date
        self.desc = desc
        self.img = img
    }
}
