//
//  CameraView.swift
//  Iota
//
//  Created by Rayan Waked on 8/19/25.
//

import SwiftUI
import UIKit
import MijickCamera

func saveImageInGallery(_ image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
}

// MARK: - VIEW
struct CameraView: View {
    @Environment(RouterCoordinator.self) var rC
    
    var body: some View {
        ZStack {
            Button {
                rC.currentView = .home
            } label: {
                Text("cancel capture")
            }
            
            MCamera()
                .onImageCaptured { image, controller in
                    saveImageInGallery(image)
                }
                .startSession()
        }
    }
}
