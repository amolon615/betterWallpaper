//
//  ViewModel.swift
//  betterWallpapers
//
//  Created by Artem on 04/01/2023.
//

import SwiftUI
import PhotosUI
import UIKit
import SystemConfiguration
import StoreKit



final class WallpapersViewModel: ObservableObject {
    @Published  var feedback = UINotificationFeedbackGenerator()
    @Published  var showingAlert = false
    
    
    @Published var cgWidth: CGFloat = UIScreen.main.bounds.width
    @Published var cgHeight: CGFloat = UIScreen.main.bounds.height
    
    //menu controls
    @Published var isShowingEdits = false
    @Published var isShowingSettings = false
    
    @Published var strokeOrFillSelected = "Fill"
    
    @Published var solidOrGradientSelected = "Gradient fill"
    @Published var gradientSelected = "Linear"
    @Published var strokeSelected = "Linear"
    
    
    @Published var radiusCorner: CGFloat = 10
    @Published var paddingEdits: CGFloat = 6.43
    
    @Published var editButtonAnimated = false
    @Published var saveButtonAnimated = false
    @Published var settingsButtonAnimated = false
    @Published var infoButtonAnimated = false
    
    @Published var color1SelectedAnimation = false
    @Published var color2SelectedAnimation = false

    
    
    @Published var pickedColor: Color = .blue
    @Published var pickedColor2: Color = .yellow
    @Published var pickedColor3: Color = .purple
    @Published var showPalette: Bool = false
    
    
    @Published var pickedColorIndex = 1
    
    
    @Published var showPreview: Bool = false
    @Published var showOverlay: Bool = false
    
    
    @Published var startRadius: CGFloat = 215.01
    @Published var endRadius: CGFloat = 200
    
    @Published var closed: Bool = true
    @Published var selectedTemplate = 1
    
    
    @Published var isPressedBlue: Bool = false
    @Published var isPressedRed: Bool = false
    @Published var isPressedGreen: Bool = false
    
    @Published var saveButtonPressed = false
    @Published var cardTitle = "Gorgeous Gradient Fill"
   
    
   
    
    func Save(view: any View){
        self.feedback.notificationOccurred(.success)
        let highresImage = view.asImage(size: CGSize(width: cgWidth, height: cgHeight))
        UIImageWriteToSavedPhotosAlbum(highresImage, nil, nil, nil)
        
        self.showingAlert.toggle()
        self.saveButtonAnimated = true
    }
    
    
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        let renderer = UIGraphicsImageRenderer(size: targetSize)
    
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
        
    }
    
    func asImage(size: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: self)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        let image = controller.view.asImage()
        return image
    }
}

extension UIView {
    func asImage() -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 3
        return UIGraphicsImageRenderer(size: self.layer.frame.size, format: format).image { context in
            self.drawHierarchy(in: self.layer.bounds, afterScreenUpdates: true)
        }
    }
}
