//
//  ContentView.swift
//  testApp
//
//  Created by Artem on 14/12/2022.
//

import SwiftUI
import PhotosUI
import UIKit
import SystemConfiguration


public extension UIDevice {
  static let modelName: String = {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8, value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    func mapToDevice(identifier: String) -> String {
      #if os(iOS)
      switch identifier {
 
      case "iPhone10,3", "iPhone10,6":                return "iPhone X"
      case "iPhone11,2":                              return "iPhone XS"
      case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
      case "iPhone11,8":                              return "iPhone XR"
      case "iPhone12,1":                              return "iPhone 11"
      case "iPhone12,3":                              return "iPhone 11 Pro"
      case "iPhone12,5":                              return "iPhone 11 Pro max"
      case "iPhone12,8":                              return "iPhone SE (2nd generation)"
      case "iPhone13,1":                              return "iPhone 12 mini"
      case "iPhone13,2":                              return "iPhone 12"
      case "iPhone13,3":                              return "iPhone 12 Pro"
      case "iPhone13,4":                              return "iPhone 12 Pro Max"
      case "iPhone14,4":                              return "iPhone 13 mini"
      case "iPhone14,5":                              return "iPhone 13"
      case "iPhone14,2":                              return "iPhone 13 Pro"
      case "iPhone14,3":                              return "iPhone 13 Pro Max"
      case "iPhone14,6":                              return "iPhone SE (3rd generation)"
      case "iPhone14,7":                              return "iPhone 14"
      case "iPhone14,8":                              return "iPhone 14 Plus"
      case "iPhone15,2":                              return "iPhone 14 Pro"
      case "iPhone15,3":                              return "iPhone 14 Pro Max"
          
      
      case "AudioAccessory1,1":                       return "HomePod"
      case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
      default:                                        return identifier
      }
      #endif
    }
    
    return mapToDevice(identifier: identifier)
  }()
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
extension View {
    func asImage(size: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: self)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        let image = controller.view.asImage()
        return image
    }
}



struct ContentView: View {
    let device =  UIDevice.modelName
    
    var cgWidth: CGFloat
    var cgHeight: CGFloat

    
    init() {
            switch device {
            case "iPhone X":
                cgWidth = 375
                cgHeight = 812
            case "iPhone XS":
                cgWidth = 375
                cgHeight = 812
            case "iPhone XS Max":
                cgWidth = 414
                cgHeight = 896
            case "iPhone XR":
                cgWidth = 414
                cgHeight = 896
            case "iPhone 11":
                cgWidth = 414
                cgHeight = 896
            case "iPhone 11 Pro":
                cgWidth = 375
                cgHeight = 812
            case "iPhone 11 Pro Max":
                cgWidth = 414
                cgHeight = 896
            case "iPhone SE (2nd generation)":
                cgWidth = 375
                cgHeight = 667
            case "iPhone 12 mini":
                cgWidth = 360
                cgHeight = 780
            case "iPhone 12":
                cgWidth = 390
                cgHeight = 844
            case "iPhone 12 Pro":
                cgWidth = 390
                cgHeight = 844
            case "iPhone 12 Pro Max":
                cgWidth = 428
                cgHeight = 926
            case "iPhone 13 mini":
                cgWidth = 375
                cgHeight = 812
            case "iPhone 13":
                cgWidth = 390
                cgHeight = 844
            case "iPhone 13 Pro":
                cgWidth = 390
                cgHeight = 844
            case "iPhone 13 Pro Max":
                cgWidth = 428
                cgHeight = 926
            case "iPhone SE (3rd generation)":
                cgWidth = 320
                cgHeight = 568
            case "iPhone 14":
                cgWidth = 390
                cgHeight = 844
            case "iPhone 14 Plus":
                cgWidth = 428
                cgHeight = 926
            case "iPhone 14 Pro":
                cgWidth = 393
                cgHeight = 852
            case "iPhone 14 Pro Max":
                cgWidth = 430
                cgHeight = 932
            default:
                cgWidth = 300
                cgHeight = 500
            }
        }

    
    
    
   
    
    @State var isShowingEdits = false
    
    @State var radiusCorner: CGFloat = 40
    @State var paddingEdits: CGFloat = 10
    
    
    @State var cgcolorRed: CGFloat = 0.0
    @State var cgcolorGreen: CGFloat  = 0.0
    @State var cgcolorBlue: CGFloat = 0.0
    
    @State var pickedColor: Color = .red
    
    var body: some View {
        GeometryReader { geometry in
            let screenSize = calculateScreenSize(geometry: geometry)
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            ZStack{
                
               myView
                    .ignoresSafeArea()
                    .drawingGroup()
                   
        
  
                         VStack{
                             Button("edit image"){
                                 isShowingEdits = true
                             }
                             .frame(width: 100, height: 100)
                             
                             Button("save image"){
                                 
                                 let highresImage = myView.asImage(size: CGSize(width: cgWidth, height: cgHeight))
                                 
                                 print("width is \(screenWidth)")
                                 print("height is \(screenHeight)")
                                 print("width set is \(cgWidth)")
                                 print("height set is \(cgHeight)")
                                 print(device)
                                
                                 UIImageWriteToSavedPhotosAlbum(highresImage, nil, nil, nil)
                             }
                             .frame(width: 100, height: 100)
                                     
                             }
                             
                             .sheet(isPresented: $isShowingEdits) {
                                 ZStack{
                                     VStack{
                                         Text("Slide to edit width")
                                             .padding()
                                         Slider(value: $paddingEdits, in: 1...20)
                                             .padding()
                                         Text("Slide to edit radius")
                                             .padding()
                                         Slider(value: $radiusCorner, in: 30...50)
                                             .padding()
                                         Text("Choose your color")
                                         HStack{
                                             Circle()
                                                 .fill(.red)
                                                 .frame(width: 50, height: 50)
                                                 .onTapGesture {
                                                     pickedColor = .red
                                                 }
                                             Circle()
                                                 .fill(.blue)
                                                 .frame(width: 50, height: 50)
                                                 .onTapGesture {
                                                     pickedColor = .blue
                                                 }
                                             Circle()
                                                 .fill(.yellow)
                                                 .frame(width: 50, height: 50)
                                                 .onTapGesture {
                                                     pickedColor = .yellow
                                                 }
                                             Circle()
                                                 .fill(.green)
                                                 .frame(width: 50, height: 50)
                                                 .onTapGesture {
                                                     pickedColor = .green
                                                 }
                                     }
                                 }
                             }
                                 .presentationDetents([.medium, .fraction(0.5)])
                         }
     
            }.ignoresSafeArea()
    
        }
        
    
    }
    
    var myView: some View {
        ZStack {
            pickedColor
                .ignoresSafeArea()
            Rectangle()
                .cornerRadius(radiusCorner)
                .padding(paddingEdits)
                .ignoresSafeArea()
        }
       
    }

    func calculateScreenSize(geometry: GeometryProxy) -> (width: CGFloat, height: CGFloat) {
        let screenSize = geometry.size
        let width = screenSize.width
        let height = screenSize.height
        return (width, height)
    }
}
    





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
