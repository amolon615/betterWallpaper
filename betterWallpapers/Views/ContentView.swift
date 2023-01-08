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
  
    @EnvironmentObject var vm: WallpapersViewModel

    
    var body: some View {
        
        ZStack(alignment: .bottom){
            let mainView = MainView().environmentObject(vm)
            mainView
            
            ZStack{
                HStack{
                    Button{
                        vm.isShowingEdits = true
                        vm.feedback.notificationOccurred(.success)
                        vm.editButtonAnimated = true
                    } label: {
                        Image(systemName: "slider.vertical.3")
                    }
                    .frame(width: 70, height: 70)
                    .background(vm.editButtonAnimated ? .black.opacity(0.3) : .black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: vm.editButtonAnimated ? 50 : 15))
                    .foregroundColor(.white)
                    .scaleEffect(vm.editButtonAnimated ? 0.8 : 1)
                    
                    .onChange(of: vm.editButtonAnimated, perform: { newValue in
                        withAnimation(.easeInOut(duration: 0.3)){
                            vm.editButtonAnimated = false
                        }
                    })
                    
                    Button {
                        vm.Save(view: mainView)
                        
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                    }
                    
                    .frame(width: 70, height: 70)
                    .background(vm.saveButtonAnimated ? .black.opacity(0.2) : .black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: vm.saveButtonAnimated ? 50 : 15))
                    .foregroundColor(.white)
                    .scaleEffect(vm.saveButtonAnimated ? 0.8 : 1)
                    
                    .onChange(of: vm.saveButtonAnimated, perform: { newValue in
                        withAnimation(.easeInOut(duration: 0.3)){
                            vm.saveButtonAnimated = false
                        }
                    })
                    
                    Button{
                        vm.settingsButtonAnimated = true
                        vm.isShowingSettings = true
                        vm.feedback.notificationOccurred(.success)
                    } label: {
                        Image(systemName: "gear")
                    }
                    .frame(width: 70, height: 70)
                    .background(vm.settingsButtonAnimated ? .black.opacity(0.2) : .black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: vm.settingsButtonAnimated ? 50 : 15))
                    .foregroundColor(.white)
                    .scaleEffect(vm.settingsButtonAnimated ? 0.8 : 1)
                    
                    .onChange(of: vm.settingsButtonAnimated, perform: { newValue in
                        withAnimation(.easeInOut(duration: 0.3)){
                            vm.settingsButtonAnimated = false
                        }
                    })
                    
                    .alert("Image saved", isPresented: $vm.showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    .sheet(isPresented: $vm.isShowingSettings) {
                        Settings()
                    }
                }
                .onAppear {
                    vm.feedback.prepare()
                }
            }
            .frame(width: 250, height: 90)
            .background(.thinMaterial)
            .foregroundColor(.black)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding()
            
            
            //edit image view
            .sheet(isPresented: $vm.isShowingEdits) {
                Edits()
                .presentationDetents([.large, .fraction(0.9)])
                .presentationDragIndicator(.hidden)
            }
            
        }.ignoresSafeArea()
        
        
    }
    
}
    
struct Edits: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View{
        ZStack{
            ScrollView{
                Picker("Select amount of minutes", selection: $vm.strokeOrFillSelected) {
                    withAnimation{
                        ForEach(vm.strokeOrFill, id:\.self) {
                            Text("\($0)")
                        }
                    }
                }.pickerStyle(.segmented)
                    .frame(width: 250)
                    .padding()
                
                Picker("Select amount of minutes", selection: $vm.solidOrGradientSelected) {
                    withAnimation{
                        ForEach(vm.solidOrGradient, id:\.self) {
                            Text("\($0)")
                        }
                    }
                }.pickerStyle(.segmented)
                    .frame(width: 250)
                    .padding()
                
                if vm.strokeOrFillSelected == "Stroke" {
                    Text("Slide to edit stroke width")
                        .padding()
                    Slider(value: $vm.paddingEdits, in: 1...20)
                        .frame(width: 250)
                        .padding()
                    Text("Slide to edit corner radius")
                        .padding()
                    Slider(value: $vm.radiusCorner, in: 1...50)
                        .frame(width: 250)
                        .padding()
                    Text("Choose your color")
                    
                    if vm.solidOrGradientSelected == "Solid fill" {
                        
                        ColorPickerView()
                        
                    } else {
                        VStack{
                            Text("Select 1st color")
                                .padding()
                            ColorPickerView()
                            Text("Select 2snd color")
                                .padding()
                           ColorPickerGradients()
                           
                        }
                    }
                } else {
                    Text("Choose your color")
                    
                    if vm.solidOrGradientSelected == "Solid fill" {
                        ColorPickerView()
                    } else {
                        VStack{
                            Text("Select 1st color")
                                .padding()
                            ColorPickerView()
                            Text("Select 2snd color")
                                .padding()
                         
                        ColorPickerGradients()
                        }
                    }
                    
                }
                
                
            }
        }
    }
}




struct MainView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    
    var body: some View {
        ZStack{
            if vm.strokeOrFillSelected == "Fill" {
                FilledView().environmentObject(vm)
                   
            } else {
                StrokeView().environmentObject(vm)
                   
            }
        }
    }
       
}


//Stroke with solid color
struct StrokeView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        ZStack{
            if vm.solidOrGradientSelected == "Gradient fill" {
                StrokeGradientView().environmentObject(vm)
            } else {
                StrokeSolidFillView().environmentObject(vm)
            }
        }
    }
}

//stroke with solid filling
struct StrokeSolidFillView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        ZStack{
            Rectangle()
                .fill(vm.pickedColor)
                .cornerRadius(vm.radiusCorner)
                .background(.black)
                .ignoresSafeArea()
            
            Rectangle()
                .fill(.black)
                .cornerRadius(vm.radiusCorner)
                .padding(vm.paddingEdits)
                .ignoresSafeArea()
        } .ignoresSafeArea()
        
    }
}

//stroke with gradient filling
struct StrokeGradientView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        ZStack{
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [vm.pickedColor, vm.pickedColor2]), startPoint: .center, endPoint: .trailing))
                .cornerRadius(vm.radiusCorner)
                .background(.black)
            
                .ignoresSafeArea()
            
            Rectangle()
                .fill(.black)
                .cornerRadius(vm.radiusCorner)
                .padding(vm.paddingEdits)
                .ignoresSafeArea()
        } .ignoresSafeArea()
        
    }
}


//filled view

struct FilledView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        ZStack {
            if vm.solidOrGradientSelected == "Solid fill" {
                FilledSolidView().environmentObject(vm)
            } else {
                FilledGradientView().environmentObject(vm)
            }
        }
    }
}
//filled view with solid color
struct FilledSolidView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        vm.pickedColor
            .ignoresSafeArea()
    }
}
//filled view with gradient
struct FilledGradientView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [vm.pickedColor, vm.pickedColor2, vm.pickedColor3]), startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
                .rotationEffect(Angle(degrees: vm.startRadius))
                .sheet(isPresented: $vm.isShowingEdits) {
                    NewSettings()
                        .presentationDetents([.large, .fraction(0.8)])
                        .presentationDragIndicator(.hidden)
                }
        }
            
    }
}


struct FilledRadialGradientView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        ZStack{
            RadialGradient(gradient: Gradient(colors: [vm.pickedColor, vm.pickedColor2, vm.pickedColor3, vm.pickedColor]), center: .center, startRadius: vm.startRadius, endRadius: vm.endRadius)
                .ignoresSafeArea()
                .sheet(isPresented: $vm.isShowingEdits) {
                    NewSettings()
                        .presentationDetents([.large, .fraction(0.8)])
                        .presentationDragIndicator(.hidden)
                }
               
        }
    }
}


    struct FilledAngularGradientView: View {
        @EnvironmentObject var vm: WallpapersViewModel
        var body: some View {
            ZStack{
                AngularGradient(gradient: Gradient(colors: [vm.pickedColor, vm.pickedColor2, vm.pickedColor3, vm.pickedColor]), center: .center, startAngle: Angle(degrees: vm.startRadius), endAngle: Angle(degrees: vm.endRadius))
                    .ignoresSafeArea()
                    .sheet(isPresented: $vm.isShowingEdits) {
                        NewSettings()
                            .presentationDetents([.large, .fraction(0.8)])
                            .presentationDragIndicator(.hidden)
                    }
            }
        }
    }


struct GradientSelected: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        
        if vm.gradientSelected == "Linear" {
            FilledGradientView().environmentObject(vm)
        } else if vm.gradientSelected == "Radial" {
            FilledRadialGradientView().environmentObject(vm)
        } else if vm.gradientSelected == "Angular" {
            FilledAngularGradientView().environmentObject(vm)
        }
           
        
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilledAngularGradientView().environmentObject(WallpapersViewModel())
    }
}

