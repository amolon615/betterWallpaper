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

    //menu controls
    @State var isShowingEdits = false
    @State var isShowingSettings = false
    @State var isShowingInfo = false
    
    @State var radiusCorner: CGFloat = 40
    @State var paddingEdits: CGFloat = 10
    
    
    @State var pickedColor: Color = .blue
    
    @State var pickedGradientColor1: Color = .yellow
    @State var pickedGradientColor2: Color = .blue
    
    var body: some View {
        GeometryReader { geometry in
            let screenSize = calculateScreenSize(geometry: geometry)
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            ZStack(alignment: .bottom){
                
               myView
                    .ignoresSafeArea()
                    .drawingGroup()
                
                ZStack{
                    HStack{
                        Button{
                            isShowingEdits = true
                        } label: {
                            Image(systemName: "slider.vertical.3")
                        }
                        .frame(width: 50, height: 50)
                        .background(.black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                        
                        Button{
                            let highresImage = myView.asImage(size: CGSize(width: cgWidth, height: cgHeight))
                            
                            print("width is \(screenWidth)")
                            print("height is \(screenHeight)")
                            print("width set is \(cgWidth)")
                            print("height set is \(cgHeight)")
                            print(device)
                           
                            UIImageWriteToSavedPhotosAlbum(highresImage, nil, nil, nil)
                        } label: {
                            Image(systemName: "square.and.arrow.down")
                        }
                        .frame(width: 50, height: 50)
                        .background(.black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                        
                        Button{
                            isShowingEdits = true
                        } label: {
                            Image(systemName: "gear")
                        }
                        .frame(width: 50, height: 50)
                        .background(.black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                        
                        Button{
                            isShowingEdits = true
                        } label: {
                            Image(systemName: "info.circle")
                        }
                        .frame(width: 50, height: 50)
                        .background(.black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                                
                        }
                }
                .frame(width: 250, height: 70)
                .background(.thinMaterial)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding()
                             
                             .sheet(isPresented: $isShowingEdits) {
                                 ZStack{
                                     VStack{
                                         Text("Slide to edit width")
                                             .padding()
                                         Slider(value: $paddingEdits, in: 1...10)
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
