//
//  CameraView.swift
//  Iota
//
//  Created by Rayan Waked on 8/19/25.
//

import SwiftUI
import UIKit
import MijickCamera
import SwiftData

func saveImageInGallery(_ image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
}

// MARK: - VIEW
struct CameraView: View {
    @Environment(RouterCoordinator.self) var rC
    @Environment(\.modelContext) private var entry
    
    var body: some View {
        ZStack {
            Button {
                rC.currentView = .home
            } label: {
                Text("cancel capture")
            }
            
            MCamera()
                .onImageCaptured { image, controller in
                    if let data = image.jpegData(compressionQuality: 1) {
                        entry.insert(Entry(
                            title: "New Capture",
                            date: Date(),
                            desc: "",
                            img: data
                        ))
                        
                        rC.currentView = .home
                    }
                }
                .startSession()
        }
    }
}
