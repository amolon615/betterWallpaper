//
//  ContentView.swift
//  betterWallpapers
//
//  Created by Artem on 14/12/2022.
//

import SwiftUI
import PhotosUI
import UIKit
import SystemConfiguration
import StoreKit



struct ContentView: View {
    
    @Environment(\.requestReview) var requestReview
    
    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var showingAlert = false
    
    //width and height for saving view as Image to User's library
    var cgWidth: CGFloat = UIScreen.main.bounds.width
    var cgHeight: CGFloat = UIScreen.main.bounds.height
    
    
    //menu controls
    @State var isShowingEdits = false
    @State var isShowingSettings = false
    
    let strokeOrFill = ["Stroke", "Fill"]
    @State var strokeOrFillSelected = "Fill"
    
    let solidOrGradient = ["Solid fill", "Gradient fill"]
    @State var solidOrGradientSelected = "Gradient fill"
    
    let gradientTypes = ["Linear", "Radial", "Angular"]
    @State var gradientType = "Linear"
    
    
    @State var radiusCorner: CGFloat = 40
    @State var paddingEdits: CGFloat = 10
    
    //Gradients components
    @State var angle: Angle = Angle(degrees: 0)
    @State var angularAngle: Angle = Angle(degrees: 0)
    
    
    @State var scale: CGFloat = 0
    @State var endRadius: CGFloat = 150
    
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    //Button animation states
    @State var editButtonAnimated = false
    @State var saveButtonAnimated = false
    @State var settingsButtonAnimated = false
    @State var infoButtonAnimated = false
    
    //Color selection button animated states
    @State var color1SelectedAnimation = false
    @State var color2SelectedAnimation = false
    
    //picked color for solid fill
    @State var pickedColor: Color = .red
    
    
    //picked colors for gradients
    @State var pickedGradientColor1: Color = .orange
    @State var pickedGradientColor2: Color = .red
    
    
    @State var color1Selected = true
    @State var color2Selected = false
    @State var color3Selected = false
    @State var color4Selected = false
    @State var color5Selected = false
    @State var color6Selected = false
    @State var color7Selected = false
    @State var color8Selected = false
    
    @State var color1Selected2 = true
    @State var color2Selected2 = false
    @State var color3Selected2 = false
    @State var color4Selected2 = false
    @State var color5Selected2 = false
    @State var color6Selected2 = false
    @State var color7Selected2 = false
    @State var color8Selected2 = false
    
    
    
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            
            if strokeOrFillSelected == "Fill" {
                withAnimation{
                    FilledView
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShowingEdits = true
                        }
                }
            } else {
                withAnimation{
                    myView
                        .ignoresSafeArea()
                        .onTapGesture {
                            isShowingEdits = true
                        }
                }
            }
            
            ZStack{
                HStack{
                    Button{
                        isShowingEdits = true
                        feedback.notificationOccurred(.success)
                        editButtonAnimated = true
                    } label: {
                        Image(systemName: "slider.vertical.3")
                    }
                    .frame(width: 70, height: 70)
                    .background(editButtonAnimated ? .black.opacity(0.3) : .black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: editButtonAnimated ? 50 : 15))
                    .foregroundColor(.white)
                    .scaleEffect(editButtonAnimated ? 0.8 : 1)
                    
                    .onChange(of: editButtonAnimated, perform: { newValue in
                        withAnimation(.easeInOut(duration: 0.3)){
                            editButtonAnimated = false
                        }
                    })
                    
                    Button {
                        feedback.notificationOccurred(.success)
                        if strokeOrFillSelected == "Fill" {
                            let highresImage = FilledView.asImage(size: CGSize(width: cgWidth, height: cgHeight))
                            UIImageWriteToSavedPhotosAlbum(highresImage, nil, nil, nil)
                        } else {
                            let highresImage = myView.asImage(size: CGSize(width: cgWidth, height: cgHeight))
                            UIImageWriteToSavedPhotosAlbum(highresImage, nil, nil, nil)
                        }
                        showingAlert.toggle()
                        saveButtonAnimated = true
                        
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                    }
                    
                    .frame(width: 70, height: 70)
                    .background(saveButtonAnimated ? .black.opacity(0.2) : .black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: saveButtonAnimated ? 50 : 15))
                    .foregroundColor(.white)
                    .scaleEffect(saveButtonAnimated ? 0.8 : 1)
                    
                    .onChange(of: saveButtonAnimated, perform: { newValue in
                        withAnimation(.easeInOut(duration: 0.3)){
                            saveButtonAnimated = false
                        }
                    })
                    
                    Button{
                        settingsButtonAnimated = true
                        isShowingSettings = true
                        feedback.notificationOccurred(.success)
                    } label: {
                        Image(systemName: "gear")
                    }
                    .frame(width: 70, height: 70)
                    .background(settingsButtonAnimated ? .black.opacity(0.2) : .black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: settingsButtonAnimated ? 50 : 15))
                    .foregroundColor(.white)
                    .scaleEffect(settingsButtonAnimated ? 0.8 : 1)
                    
                    .onChange(of: settingsButtonAnimated, perform: { newValue in
                        withAnimation(.easeInOut(duration: 0.3)){
                            settingsButtonAnimated = false
                        }
                    })
                    
                    .alert("Image saved", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    .sheet(isPresented: $isShowingSettings) {
                        Settings()
                    }
                }
                .onAppear {
                    feedback.prepare()
                }
            }
            .frame(width: 250, height: 90)
            .background(.thinMaterial)
            .foregroundColor(.black)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding()
            
            
            //edit image view
            .sheet(isPresented: $isShowingEdits) {
                ZStack{
                    ScrollView{
                        Picker("Stroke or fill", selection: $strokeOrFillSelected) {
                            withAnimation{
                                ForEach(strokeOrFill, id:\.self) {
                                    Text("\($0)")
                                }
                            }
                        }.pickerStyle(.segmented)
                            .frame(width: 250)
                            .padding()
                        
                        Picker("Solid or gradient fill", selection: $solidOrGradientSelected) {
                            withAnimation{
                                ForEach(solidOrGradient, id:\.self) {
                                    Text("\($0)")
                                }
                            }
                        }.pickerStyle(.segmented)
                            .frame(width: 250)
                            .padding()
                        
                        Picker("Solid or gradient fill", selection: $gradientType) {
                            withAnimation{
                                ForEach(gradientTypes, id:\.self) {
                                    Text("\($0)")
                                }
                            }
                        }.pickerStyle(.segmented)
                            .frame(width: 250)
                            .padding()
                        
                        if strokeOrFillSelected == "Stroke" {
                            Text("Slide to edit stroke width")
                                .padding()
                            Slider(value: $paddingEdits, in: 1...20)
                                .frame(width: 250)
                                .padding()
                            Text("Slide to edit corner radius")
                                .padding()
                            Slider(value: $radiusCorner, in: 1...50)
                                .frame(width: 250)
                                .padding()
                            Text("Choose your color")
                            
                            
                            if solidOrGradientSelected == "Solid fill" {
                                
                                HStack{
                                    Circle()
                                        .fill(.red)
                                        .frame(width: 50, height: 50)
                                        .scaleEffect(color1Selected ? 0.9 : 1)
                                        .overlay(
                                            Circle()
                                                .stroke(.blue, lineWidth: color1Selected ? 4 : 0)
                                        )
                                        .onTapGesture {
                                            withAnimation(.spring()){
                                                pickedColor = .red
                                                color1Selected = true
                                                color2Selected = false
                                                color3Selected = false
                                                color4Selected = false
                                                color5Selected = false
                                                color6Selected = false
                                                color7Selected = false
                                                color8Selected = false
                                                feedback.notificationOccurred(.success)
                                            }
                                            
                                        }
                                    Circle()
                                        .fill(.blue)
                                        .frame(width: 50, height: 50)
                                        .scaleEffect(color2Selected ? 0.9 : 1)
                                        .overlay(
                                            Circle()
                                                .stroke(.blue, lineWidth: color2Selected ? 4 : 0)
                                        )
                                        .onTapGesture {
                                            withAnimation(.spring()){
                                                pickedColor = .blue
                                                color1Selected = false
                                                color2Selected = true
                                                color3Selected = false
                                                color4Selected = false
                                                color5Selected = false
                                                color6Selected = false
                                                color7Selected = false
                                                color8Selected = false
                                                feedback.notificationOccurred(.success)
                                            }
                                            
                                        }
                                    Circle()
                                        .fill(.yellow)
                                        .frame(width: 50, height: 50)
                                        .scaleEffect(color3Selected ? 0.9 : 1)
                                        .overlay(
                                            Circle()
                                                .stroke(.blue, lineWidth: color3Selected ? 4 : 0)
                                        )
                                        .onTapGesture {
                                            withAnimation(.spring()){
                                                pickedColor = .yellow
                                                color1Selected = false
                                                color2Selected = false
                                                color3Selected = true
                                                color4Selected = false
                                                color5Selected = false
                                                color6Selected = false
                                                color7Selected = false
                                                color8Selected = false
                                                feedback.notificationOccurred(.success)
                                            }
                                        }
                                    Circle()
                                        .fill(.green)
                                        .frame(width: 50, height: 50)
                                        .scaleEffect(color4Selected ? 0.9 : 1)
                                        .overlay(
                                            Circle()
                                                .stroke(.blue, lineWidth: color4Selected ? 4 : 0)
                                        )
                                        .onTapGesture {
                                            withAnimation(.spring()){
                                                pickedColor = .green
                                                color1Selected = false
                                                color2Selected = false
                                                color3Selected = false
                                                color4Selected = true
                                                color5Selected = false
                                                color6Selected = false
                                                color7Selected = false
                                                color8Selected = false
                                                feedback.notificationOccurred(.success)
                                            }
                                            
                                        }
                                    
                                }
                                HStack{
                                    Circle()
                                        .fill(.purple)
                                        .frame(width: 50, height: 50)
                                        .scaleEffect(color5Selected ? 0.9 : 1)
                                        .overlay(
                                            Circle()
                                                .stroke(.blue, lineWidth: color5Selected ? 4 : 0)
                                        )
                                        .onTapGesture {
                                            withAnimation(.spring()){
                                                pickedColor = .purple
                                                color1Selected = false
                                                color2Selected = false
                                                color3Selected = false
                                                color4Selected = false
                                                color5Selected = true
                                                color6Selected = false
                                                color7Selected = false
                                                color8Selected = false
                                                feedback.notificationOccurred(.success)
                                            }
                                        }
                                    Circle()
                                        .fill(.orange)
                                        .frame(width: 50, height: 50)
                                        .scaleEffect(color6Selected ? 0.9 : 1)
                                        .overlay(
                                            Circle()
                                                .stroke(.blue, lineWidth: color6Selected ? 4 : 0)
                                        )
                                        .onTapGesture {
                                            withAnimation(.spring()){
                                                pickedColor = .orange
                                                color1Selected = false
                                                color2Selected = false
                                                color3Selected = false
                                                color4Selected = false
                                                color5Selected = false
                                                color6Selected = true
                                                color7Selected = false
                                                color8Selected = false
                                                feedback.notificationOccurred(.success)
                                            }
                                        }
                                    Circle()
                                        .fill(.pink)
                                        .frame(width: 50, height: 50)
                                        .scaleEffect(color7Selected ? 0.9 : 1)
                                        .overlay(
                                            Circle()
                                                .stroke(.blue, lineWidth: color7Selected ? 4 : 0)
                                        )
                                        .onTapGesture {
                                            withAnimation(.spring()){
                                                pickedColor = .pink
                                                color1Selected = false
                                                color2Selected = false
                                                color3Selected = false
                                                color4Selected = false
                                                color5Selected = false
                                                color6Selected = false
                                                color7Selected = true
                                                color8Selected = false
                                                feedback.notificationOccurred(.success)
                                            }
                                        }
                                    Circle()
                                        .fill(.gray)
                                        .frame(width: 50, height: 50)
                                        .scaleEffect(color8Selected ? 0.9 : 1)
                                        .overlay(
                                            Circle()
                                                .stroke(.blue, lineWidth: color8Selected ? 4 : 0)
                                        )
                                        .onTapGesture {
                                            withAnimation(.spring()){
                                                pickedColor = .gray
                                                color1Selected = false
                                                color2Selected = false
                                                color3Selected = false
                                                color4Selected = false
                                                color5Selected = false
                                                color6Selected = false
                                                color7Selected = false
                                                color8Selected = true
                                                feedback.notificationOccurred(.success)
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
                                            .scaleEffect(color1Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color1Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .red
                                                    color1Selected = true
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color2Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color2Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .blue
                                                    color1Selected = false
                                                    color2Selected = true
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                                
                                            }
                                        Circle()
                                            .fill(.yellow)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color3Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color3Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .yellow
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = true
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color4Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color4Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                pickedGradientColor1 = .green
                                                color1Selected = false
                                                color2Selected = false
                                                color3Selected = false
                                                color4Selected = true
                                                color5Selected = false
                                                color6Selected = false
                                                color7Selected = false
                                                color8Selected = false
                                                feedback.notificationOccurred(.success)
                                            }
                                        
                                    }
                                    HStack{
                                        Circle()
                                            .fill(.purple)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color5Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color5Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .purple
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = true
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.orange)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color6Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color6Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .orange
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = true
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.pink)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color7Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color7Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .pink
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = true
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.gray)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color8Selected ? 0.9 : 1)
                                         .overlay(
                                            Circle()
                                                .stroke(.blue, lineWidth: color8Selected ? 4 : 0)
                                        )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .gray
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = true
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                    }
                                    Text("Select 2snd color")
                                        .padding()
                                    HStack{
                                        Circle()
                                            .fill(.red)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color1Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color1Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .red
                                                    color1Selected2 = true
                                                    color2Selected2 = false
                                                    color3Selected2 = false
                                                    color4Selected2 = false
                                                    color5Selected2 = false
                                                    color6Selected2 = false
                                                    color7Selected2 = false
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color2Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color2Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .blue
                                                    color1Selected2 = false
                                                    color2Selected2 = true
                                                    color3Selected2 = false
                                                    color4Selected2 = false
                                                    color5Selected2 = false
                                                    color6Selected2 = false
                                                    color7Selected2 = false
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.yellow)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color3Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color3Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .yellow
                                                    color1Selected2 = false
                                                    color2Selected2 = false
                                                    color3Selected2 = true
                                                    color4Selected2 = false
                                                    color5Selected2 = false
                                                    color6Selected2 = false
                                                    color7Selected2 = false
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color4Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color4Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .green
                                                    color1Selected2 = false
                                                    color2Selected2 = false
                                                    color3Selected2 = false
                                                    color4Selected2 = true
                                                    color5Selected2 = false
                                                    color6Selected2 = false
                                                    color7Selected2 = false
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        
                                    }
                                    HStack{
                                        Circle()
                                            .fill(.purple)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color5Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color5Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .purple
                                                    color1Selected2 = false
                                                    color2Selected2 = false
                                                    color3Selected2 = false
                                                    color4Selected2 = false
                                                    color5Selected2 = true
                                                    color6Selected2 = false
                                                    color7Selected2 = false
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.orange)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color6Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color6Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .orange
                                                    color1Selected2 = false
                                                    color2Selected2 = false
                                                    color3Selected2 = false
                                                    color4Selected2 = false
                                                    color5Selected2 = false
                                                    color6Selected2 = true
                                                    color7Selected2 = false
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.pink)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color7Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color7Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .pink
                                                    color1Selected2 = false
                                                    color2Selected2 = false
                                                    color3Selected2 = false
                                                    color4Selected2 = false
                                                    color5Selected2 = false
                                                    color6Selected2 = false
                                                    color7Selected2 = true
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.gray)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color8Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color8Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                pickedGradientColor2 = .gray
                                                color1Selected2 = false
                                                color2Selected2 = false
                                                color3Selected2 = false
                                                color4Selected2 = false
                                                color5Selected2 = false
                                                color6Selected2 = false
                                                color7Selected2 = false
                                                color8Selected2 = true
                                                feedback.notificationOccurred(.success)
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
                                            .scaleEffect(color1Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color1Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedColor = .red
                                                    color1Selected = true
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                                
                                            }
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color2Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color2Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedColor = .blue
                                                    color1Selected = false
                                                    color2Selected = true
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                                
                                            }
                                        Circle()
                                            .fill(.yellow)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color3Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color3Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedColor = .yellow
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = true
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color4Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color4Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedColor = .green
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = true
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                                
                                            }
                                        
                                    }
                                    HStack{
                                        Circle()
                                            .fill(.purple)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color5Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color5Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedColor = .purple
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = true
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.orange)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color6Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color6Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedColor = .orange
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = true
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.pink)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color7Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color7Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedColor = .pink
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = true
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.gray)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color8Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color8Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedColor = .gray
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = true
                                                    feedback.notificationOccurred(.success)
                                                }
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
                                            .scaleEffect(color1Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color1Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .red
                                                    color1Selected = true
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color2Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color2Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .blue
                                                    color1Selected = false
                                                    color2Selected = true
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                                
                                            }
                                        Circle()
                                            .fill(.yellow)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color3Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color3Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .yellow
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = true
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color4Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color4Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                pickedGradientColor1 = .green
                                                color1Selected = false
                                                color2Selected = false
                                                color3Selected = false
                                                color4Selected = true
                                                color5Selected = false
                                                color6Selected = false
                                                color7Selected = false
                                                color8Selected = false
                                                feedback.notificationOccurred(.success)
                                            }
                                        
                                    }
                                    HStack{
                                        Circle()
                                            .fill(.purple)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color5Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color5Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .purple
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = true
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.orange)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color6Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color6Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .orange
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = true
                                                    color7Selected = false
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.pink)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color7Selected ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color7Selected ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .pink
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = true
                                                    color8Selected = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.gray)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color8Selected ? 0.9 : 1)
                                         .overlay(
                                            Circle()
                                                .stroke(.blue, lineWidth: color8Selected ? 4 : 0)
                                        )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor1 = .gray
                                                    color1Selected = false
                                                    color2Selected = false
                                                    color3Selected = false
                                                    color4Selected = false
                                                    color5Selected = false
                                                    color6Selected = false
                                                    color7Selected = false
                                                    color8Selected = true
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                    }
                                    Text("Select 2snd color")
                                        .padding()
                                    HStack{
                                        Circle()
                                            .fill(.red)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color1Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color1Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .red
                                                    color1Selected2 = true
                                                    color2Selected2 = false
                                                    color3Selected2 = false
                                                    color4Selected2 = false
                                                    color5Selected2 = false
                                                    color6Selected2 = false
                                                    color7Selected2 = false
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color2Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color2Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .blue
                                                    color1Selected2 = false
                                                    color2Selected2 = true
                                                    color3Selected2 = false
                                                    color4Selected2 = false
                                                    color5Selected2 = false
                                                    color6Selected2 = false
                                                    color7Selected2 = false
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.yellow)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color3Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color3Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .yellow
                                                    color1Selected2 = false
                                                    color2Selected2 = false
                                                    color3Selected2 = true
                                                    color4Selected2 = false
                                                    color5Selected2 = false
                                                    color6Selected2 = false
                                                    color7Selected2 = false
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color4Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color4Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .green
                                                    color1Selected2 = false
                                                    color2Selected2 = false
                                                    color3Selected2 = false
                                                    color4Selected2 = true
                                                    color5Selected2 = false
                                                    color6Selected2 = false
                                                    color7Selected2 = false
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        
                                    }
                                    HStack{
                                        Circle()
                                            .fill(.purple)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color5Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color5Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .purple
                                                    color1Selected2 = false
                                                    color2Selected2 = false
                                                    color3Selected2 = false
                                                    color4Selected2 = false
                                                    color5Selected2 = true
                                                    color6Selected2 = false
                                                    color7Selected2 = false
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.orange)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color6Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color6Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .orange
                                                    color1Selected2 = false
                                                    color2Selected2 = false
                                                    color3Selected2 = false
                                                    color4Selected2 = false
                                                    color5Selected2 = false
                                                    color6Selected2 = true
                                                    color7Selected2 = false
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.pink)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color7Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color7Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                withAnimation(.spring()){
                                                    pickedGradientColor2 = .pink
                                                    color1Selected2 = false
                                                    color2Selected2 = false
                                                    color3Selected2 = false
                                                    color4Selected2 = false
                                                    color5Selected2 = false
                                                    color6Selected2 = false
                                                    color7Selected2 = true
                                                    color8Selected2 = false
                                                    feedback.notificationOccurred(.success)
                                                }
                                            }
                                        Circle()
                                            .fill(.gray)
                                            .frame(width: 50, height: 50)
                                            .scaleEffect(color8Selected2 ? 0.9 : 1)
                                            .overlay(
                                                Circle()
                                                    .stroke(.blue, lineWidth: color8Selected2 ? 4 : 0)
                                            )
                                            .onTapGesture {
                                                pickedGradientColor2 = .gray
                                                color1Selected2 = false
                                                color2Selected2 = false
                                                color3Selected2 = false
                                                color4Selected2 = false
                                                color5Selected2 = false
                                                color6Selected2 = false
                                                color7Selected2 = false
                                                color8Selected2 = true
                                                feedback.notificationOccurred(.success)
                                            }
                                    }
                                }
                            }
                            
                        }
                        
                        
                    }
                }
                .presentationDetents([.large, .fraction(0.9)])
                .presentationDragIndicator(.hidden)
            }
            
        }.ignoresSafeArea()
            .onAppear{
                print("cgWidth is \(cgWidth), cgHeight is \(cgHeight).")
            }
        
        
    }
    //stroke
    var myView: some View {
        ZStack {
            if solidOrGradientSelected == "Solid fill"{
                Rectangle()
                    .fill(pickedColor)
                    .cornerRadius(radiusCorner)
                    .background(.black)
                    .ignoresSafeArea()
                
                Rectangle()
                    .fill(.black)
                    .cornerRadius(radiusCorner + 10)
                    .padding(paddingEdits)
                    .ignoresSafeArea()
            } else {
                if gradientType == "Linear" {
                    ZStack{
                        LinearGradient(gradient: Gradient(colors: [pickedGradientColor1, pickedGradientColor2]), startPoint: .bottom, endPoint: .top)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .ignoresSafeArea()
                        LinearGradient(gradient: Gradient(colors: [pickedGradientColor1, pickedGradientColor2]), startPoint: .bottom, endPoint: .top)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .cornerRadius(radiusCorner)
                            .background(.black)
                            .blur(radius: 10)
                            .rotationEffect(angle)
                            .ignoresSafeArea()
                    }
                    
                } else if gradientType == "Radial"{
                    RadialGradient(gradient: Gradient(colors: [pickedGradientColor1, pickedGradientColor2]), center: .center, startRadius: 1, endRadius: endRadius)
                        .ignoresSafeArea()
                } else {
                    AngularGradient(colors: [pickedGradientColor1, pickedGradientColor2], center: .center, startAngle: Angle(degrees: 0), endAngle: angularAngle)
                        .ignoresSafeArea()
                }
                
                
                Rectangle()
                    .fill(.black)
                    .cornerRadius(radiusCorner + 10)
                    .padding(paddingEdits)
                    .ignoresSafeArea()
                    .gesture(
                        RotationGesture()
                            .onChanged({ value in
                                angle += value
                            })
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ value in
                                endRadius += value
                            })
                        
                    )
            }
            
        }
        
    }
    //fill
    var FilledView: some View {
        ZStack {
            if solidOrGradientSelected == "Solid fill" {
                pickedColor
                    .ignoresSafeArea()
                
                
            } else {
                
                if gradientType == "Linear" {
                    ZStack{
                        LinearGradient(gradient: Gradient(colors: [pickedGradientColor1, pickedGradientColor2]), startPoint: .leading, endPoint: .trailing)
                        LinearGradient(gradient: Gradient(colors: [pickedGradientColor1, pickedGradientColor2]), startPoint: .leading, endPoint: .trailing)
                            .ignoresSafeArea()
                            .rotationEffect(angle)
                            .blur(radius: 10)
                    }
                    
                        .gesture(
                            RotationGesture()
                                .onChanged({ value in
                                    withAnimation(.spring()){
                                        angle += value
                                    }
                                })
                        )
                } else if gradientType == "Radial" {
                    RadialGradient(gradient: Gradient(colors: [pickedGradientColor1, pickedGradientColor2]), center: .center, startRadius: 50, endRadius: 100)
                        .scaleEffect(1 + currentAmount + lastAmount)
                        .ignoresSafeArea()
                        .gesture(
                            MagnificationGesture()
                                .onChanged({ value in
                                    withAnimation(.spring()){
                                        currentAmount = value - 1
                                    }
                                })
                                .onEnded({ value in
                                    withAnimation(.spring()){
                                        lastAmount += currentAmount
                                        currentAmount = 0
                                    }
                                })

                        )
                    
                } else if gradientType == "Angular" {
                    AngularGradient(colors: [pickedGradientColor1, pickedGradientColor2], center: .center, startAngle: Angle(degrees: 0), endAngle: angularAngle)
                        .ignoresSafeArea()
                        .gesture(
                        RotationGesture()
                            .onChanged({ value in
                                withAnimation(.spring()){
                                        angularAngle += value


                                }
                            })
        //
                        )
                }
            }
            
        }
        
    }
}
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
