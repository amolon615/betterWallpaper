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
            case "iPhone X": cgWidth = 375 ; cgHeight = 812
            case "iPhone XS": cgWidth = 375 ; cgHeight = 812
            case "iPhone XS Max": cgWidth = 414 ; cgHeight = 896
            case "iPhone XR": cgWidth = 414 ; cgHeight = 896
            case "iPhone 11": cgWidth = 414 ; cgHeight = 896
            case "iPhone 11 Pro": cgWidth = 375 ; cgHeight = 812
            case "iPhone 11 Pro Max": cgWidth = 414 ; cgHeight = 896
            case "iPhone SE (2nd generation)": cgWidth = 375 ; cgHeight = 667
            case "iPhone 12 mini": cgWidth = 360 ; cgHeight = 780
            case "iPhone 12": cgWidth = 390 ;  cgHeight = 844
            case "iPhone 12 Pro": cgWidth = 390 ; cgHeight = 844
            case "iPhone 12 Pro Max":  cgWidth = 428 ; cgHeight = 926
            case "iPhone 13 mini": cgWidth = 375 ; cgHeight = 812
            case "iPhone 13": cgWidth = 390 ; cgHeight = 844
            case "iPhone 13 Pro": cgWidth = 390 ; cgHeight = 844
            case "iPhone 13 Pro Max": cgWidth = 428 ; cgHeight = 926
            case "iPhone SE (3rd generation)":cgWidth = 320 ; cgHeight = 568
            case "iPhone 14": cgWidth = 390 ; cgHeight = 844
            case "iPhone 14 Plus": cgWidth = 428 ; cgHeight = 926
            case "iPhone 14 Pro": cgWidth = 393 ; cgHeight = 852
            case "iPhone 14 Pro Max": cgWidth = 430 ; cgHeight = 932
            default: cgWidth = 300 ; cgHeight = 500
            }
        }

    //menu controls
    @State var isShowingEdits = false
    @State var isShowingSettings = false
    @State var isShowingInfo = false
    
    let strokeOrFill = ["Stroke", "Fill"]
    @State var strokeOrFillSelected = "Stroke"
    
    let solidOrGradient = ["Solid fill", "Gradient fill"]
    @State var solidOrGradientSelected = "Solid fill"
    
    
    @State var radiusCorner: CGFloat = 40
    @State var paddingEdits: CGFloat = 10
    
    @State var editButtonAnimated = false
    @State var saveButtonAnimated = false
    @State var settingsButtonAnimated = false
    @State var infoButtonAnimated = false
    
    @State var pickedColor: Color = .orange
    
    @State var pickedGradientColor1: Color = .orange
    @State var pickedGradientColor2: Color = .red
    
    var body: some View {
        GeometryReader { geometry in
            let screenSize = calculateScreenSize(geometry: geometry)
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            ZStack(alignment: .bottom){
                
                if strokeOrFillSelected == "Fill" {
                    withAnimation{
                        FilledView
                            .ignoresSafeArea()
                            .drawingGroup()
                    }
                } else {
                    withAnimation{
                        myView
                            .ignoresSafeArea()
                            .drawingGroup()
                    }
                }
                
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
                        
                        Button {
                            
                            if strokeOrFillSelected == "Fill" {
                                let highresImage = FilledView.asImage(size: CGSize(width: cgWidth, height: cgHeight))
                                UIImageWriteToSavedPhotosAlbum(highresImage, nil, nil, nil)
                            } else {
                                let highresImage = myView.asImage(size: CGSize(width: cgWidth, height: cgHeight))
                                UIImageWriteToSavedPhotosAlbum(highresImage, nil, nil, nil)
                                }
                            saveButtonAnimated = true
                        } label: {
                            Image(systemName: "square.and.arrow.down")
                        }
                        
                        .frame(width: 50, height: 50)
                        .background(saveButtonAnimated ? .black.opacity(0.3) : .black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                        .scaleEffect(saveButtonAnimated ? 1.1 : 1)
                        
                        .onChange(of: saveButtonAnimated, perform: { newValue in
                            withAnimation(.easeInOut(duration: 0.3)){
                                saveButtonAnimated = false
                            }
                        })
                        
                        Button{
                           
                            settingsButtonAnimated = true
                        } label: {
                            Image(systemName: "gear")
                        }
                        .frame(width: 50, height: 50)
                        .background(settingsButtonAnimated ? .black.opacity(0.3) : .black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                        .scaleEffect(settingsButtonAnimated ? 1.2 : 1)
                        
                        .onChange(of: settingsButtonAnimated, perform: { newValue in
                            withAnimation(.easeInOut(duration: 0.3)){
                                settingsButtonAnimated = false
                            }
                        })
                        
                        Button{
                            infoButtonAnimated = true
                        } label: {
                            Image(systemName: "info.circle")
                        }
                        .frame(width: 50, height: 50)
                        .background(infoButtonAnimated ? .black.opacity(0.3) : .black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                        .scaleEffect(infoButtonAnimated ? 1.2 : 1)
                        
                        .onChange(of: infoButtonAnimated, perform: { newValue in
                            withAnimation(.easeInOut(duration: 0.3)){
                                infoButtonAnimated = false
                            }
                        })
                                
                        }
                }
                .frame(width: 250, height: 70)
                .background(.thinMaterial)
                .foregroundColor(.black)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding()
                
                
                                //edit image view
                             .sheet(isPresented: $isShowingEdits) {
                                 ZStack{
                                     ScrollView{
                                         Picker("Select amount of minutes", selection: $strokeOrFillSelected) {
                                             withAnimation{
                                                 ForEach(strokeOrFill, id:\.self) {
                                                     Text("\($0)")
                                             }
                                             }
                                         }.pickerStyle(.segmented)
                                             .padding()
                                         
                                         Picker("Select amount of minutes", selection: $solidOrGradientSelected) {
                                             withAnimation{
                                                 ForEach(solidOrGradient, id:\.self) {
                                                     Text("\($0)")
                                             }
                                             }
                                         }.pickerStyle(.segmented)
                                             .padding()
                                         
                                         if strokeOrFillSelected == "Stroke" {
                                             Text("Slide to edit stroke width")
                                                 .padding()
                                             Slider(value: $paddingEdits, in: 1...10)
                                                 .padding()
                                             Text("Slide to edit corner radius")
                                                 .padding()
                                             Slider(value: $radiusCorner, in: 30...50)
                                                 .padding()
                                             Text("Choose your colors")
                                             
                                             
                                             if solidOrGradientSelected == "Solid fill" {
        
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
                                                     HStack{
                                                         Circle()
                                                             .fill(.purple)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedColor = .purple
                                                             }
                                                         Circle()
                                                             .fill(.orange)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedColor = .orange
                                                             }
                                                         Circle()
                                                             .fill(.pink)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedColor = .pink
                                                             }
                                                         Circle()
                                                             .fill(.gray)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedColor = .gray
                                                             }
                                                     }
    
                                             } else {
                                                 VStack{
                                                     Text("Select 1st color")
                                                         .padding()
                                                     HStack{
                                                         Circle()
                                                             .fill(.red)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .red
                                                                 print("red color tapped")
                                                             }
                                                         Circle()
                                                             .fill(.blue)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .blue
                                                             }
                                                         Circle()
                                                             .fill(.yellow)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .yellow
                                                             }
                                                         Circle()
                                                             .fill(.green)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .green
                                                             }
                                                         
                                                     }
                                                     HStack{
                                                         Circle()
                                                             .fill(.purple)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .purple
                                                             }
                                                         Circle()
                                                             .fill(.orange)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .orange
                                                             }
                                                         Circle()
                                                             .fill(.pink)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .pink
                                                             }
                                                         Circle()
                                                             .fill(.gray)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .gray
                                                             }
                                                     }
                                                     Text("Select 2snd color")
                                                         .padding()
                                                     HStack{
                                                         Circle()
                                                             .fill(.red)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .red
                                                             }
                                                         Circle()
                                                             .fill(.blue)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .blue
                                                             }
                                                         Circle()
                                                             .fill(.yellow)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .yellow
                                                             }
                                                         Circle()
                                                             .fill(.green)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .green
                                                             }
                                                         
                                                     }
                                                     HStack{
                                                         Circle()
                                                             .fill(.purple)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .purple
                                                             }
                                                         Circle()
                                                             .fill(.orange)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .orange
                                                             }
                                                         Circle()
                                                             .fill(.pink)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .pink
                                                             }
                                                         Circle()
                                                             .fill(.gray)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .gray
                                                             }
                                                     }
                                                 }
                                             }
                                         } else {
                                             Text("Choose your color")
                                             
                                             if solidOrGradientSelected == "Solid fill" {
                                                 VStack{
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
                                                     HStack{
                                                         Circle()
                                                             .fill(.purple)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedColor = .purple
                                                             }
                                                         Circle()
                                                             .fill(.orange)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedColor = .orange
                                                             }
                                                         Circle()
                                                             .fill(.pink)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedColor = .pink
                                                             }
                                                         Circle()
                                                             .fill(.gray)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedColor = .gray
                                                             }
                                                     }
                                                 }
                                             } else {
                                                 VStack{
                                                     Text("Select 1st color")
                                                         .padding()
                                                     HStack{
                                                         Circle()
                                                             .fill(.red)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .red
                                                                 print("red color tapped")
                                                             }
                                                         Circle()
                                                             .fill(.blue)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .blue
                                                             }
                                                         Circle()
                                                             .fill(.yellow)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .yellow
                                                             }
                                                         Circle()
                                                             .fill(.green)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .green
                                                             }
                                                         
                                                     }
                                                     HStack{
                                                         Circle()
                                                             .fill(.purple)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .purple
                                                             }
                                                         Circle()
                                                             .fill(.orange)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .orange
                                                             }
                                                         Circle()
                                                             .fill(.pink)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .pink
                                                             }
                                                         Circle()
                                                             .fill(.gray)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor1 = .gray
                                                             }
                                                     }
                                                     Text("Select 2snd color")
                                                         .padding()
                                                     HStack{
                                                         Circle()
                                                             .fill(.red)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .red
                                                             }
                                                         Circle()
                                                             .fill(.blue)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .blue
                                                             }
                                                         Circle()
                                                             .fill(.yellow)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .yellow
                                                             }
                                                         Circle()
                                                             .fill(.green)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .green
                                                             }
                                                         
                                                     }
                                                     HStack{
                                                         Circle()
                                                             .fill(.purple)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .purple
                                                             }
                                                         Circle()
                                                             .fill(.orange)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .orange
                                                             }
                                                         Circle()
                                                             .fill(.pink)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .pink
                                                             }
                                                         Circle()
                                                             .fill(.gray)
                                                             .frame(width: 50, height: 50)
                                                             .onTapGesture {
                                                                 pickedGradientColor2 = .gray
                                                             }
                                                     }
                                                 }
                                             }
                                             
                                         }
                                         

                                 }
                             }
                                 .presentationDetents([.large, .fraction(0.9)])
                         }
     
            }.ignoresSafeArea()
    
        }
    }
    
    var myView: some View {
        ZStack {
           if solidOrGradientSelected == "Solid fill"{
                pickedColor
                    .ignoresSafeArea()
                Rectangle()
                    .fill(.black)
                    .cornerRadius(radiusCorner)
                    .padding(paddingEdits)
                    .ignoresSafeArea()
           } else {
               LinearGradient(gradient: Gradient(colors: [pickedGradientColor1, pickedGradientColor2]), startPoint: .center, endPoint: .trailing)
                   .ignoresSafeArea()
               Rectangle()
                   .fill(.black)
                   .cornerRadius(radiusCorner)
                   .padding(paddingEdits)
                   .ignoresSafeArea()
           }
        }
       
    }
    
    var FilledView: some View {
        ZStack {
           if solidOrGradientSelected == "Solid fill" {
                pickedColor
                    .ignoresSafeArea()
           } else {
               LinearGradient(gradient: Gradient(colors: [pickedGradientColor1, pickedGradientColor2]), startPoint: .leading, endPoint: .trailing)
                   .ignoresSafeArea()
           }
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
