//
//  ColorExtension.swift
//  testApp
//
//  Created by Artem on 23/12/2022.
//

import SwiftUI
import UIKit
import SystemConfiguration

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
