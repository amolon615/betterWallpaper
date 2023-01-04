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


final class WallpapersViewModel: ObservableObject {
    @Published  var feedback = UINotificationFeedbackGenerator()
    @Published  var showingAlert = false
    
    
    @Published var cgWidth: CGFloat = UIScreen.main.bounds.width
    @Published var cgHeight: CGFloat = UIScreen.main.bounds.height
    
    
    
    
    //menu controls
    @Published var isShowingEdits = false
    @Published var isShowingSettings = false
    
    let strokeOrFill = ["Stroke", "Fill"]
    @Published var strokeOrFillSelected = "Fill"
    
    let solidOrGradient = ["Solid fill", "Gradient fill"]
    @Published var solidOrGradientSelected = "Gradient fill"
    
    
    @Published var radiusCorner: CGFloat = 40
    @Published var paddingEdits: CGFloat = 10
    
    @Published var editButtonAnimated = false
    @Published var saveButtonAnimated = false
    @Published var settingsButtonAnimated = false
    @Published var infoButtonAnimated = false
    
    @Published var color1SelectedAnimation = false
    @Published var color2SelectedAnimation = false
    
    
    @Published var pickedColor: Color = .orange
    
    @Published var pickedGradientColor1: Color = .orange
    @Published var pickedGradientColor2: Color = .red
}


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
                        vm.feedback.notificationOccurred(.success)
                        let highresImage = mainView.asImage(size: CGSize(width: vm.cgWidth, height: vm.cgHeight))
                        UIImageWriteToSavedPhotosAlbum(highresImage, nil, nil, nil)
                        
                        vm.showingAlert.toggle()
                        vm.saveButtonAnimated = true
                        
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
                                
                                HStack{
                                    Circle()
                                        .fill(.red)
                                        .frame(width: 50, height: 50)
                                        .onTapGesture {
                                            vm.pickedColor = .red
                                        }
                                    Circle()
                                        .fill(.blue)
                                        .frame(width: 50, height: 50)
                                        .onTapGesture {
                                            vm.pickedColor = .blue
                                        }
                                    Circle()
                                        .fill(.yellow)
                                        .frame(width: 50, height: 50)
                                        .onTapGesture {
                                            vm.pickedColor = .yellow
                                        }
                                    Circle()
                                        .fill(.green)
                                        .frame(width: 50, height: 50)
                                        .onTapGesture {
                                            vm.pickedColor = .green
                                        }
                                    
                                }
                                HStack{
                                    Circle()
                                        .fill(.purple)
                                        .frame(width: 50, height: 50)
                                        .onTapGesture {
                                            vm.pickedColor = .purple
                                        }
                                    Circle()
                                        .fill(.orange)
                                        .frame(width: 50, height: 50)
                                        .onTapGesture {
                                            vm.pickedColor = .orange
                                        }
                                    Circle()
                                        .fill(.pink)
                                        .frame(width: 50, height: 50)
                                        .onTapGesture {
                                            vm.pickedColor = .pink
                                        }
                                    Circle()
                                        .fill(.gray)
                                        .frame(width: 50, height: 50)
                                        .onTapGesture {
                                            vm.pickedColor = .gray
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
                                                vm.pickedGradientColor1 = .red
                                                print("red color tapped")
                                            }
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .blue
                                            }
                                        Circle()
                                            .fill(.yellow)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .yellow
                                            }
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .green
                                            }
                                        
                                    }
                                    HStack{
                                        Circle()
                                            .fill(.purple)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .purple
                                            }
                                        Circle()
                                            .fill(.orange)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .orange
                                            }
                                        Circle()
                                            .fill(.pink)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .pink
                                            }
                                        Circle()
                                            .fill(.gray)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .gray
                                            }
                                    }
                                    Text("Select 2snd color")
                                        .padding()
                                    HStack{
                                        Circle()
                                            .fill(.red)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .red
                                            }
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .blue
                                            }
                                        Circle()
                                            .fill(.yellow)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .yellow
                                            }
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .green
                                            }
                                        
                                    }
                                    HStack{
                                        Circle()
                                            .fill(.purple)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .purple
                                            }
                                        Circle()
                                            .fill(.orange)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .orange
                                            }
                                        Circle()
                                            .fill(.pink)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .pink
                                            }
                                        Circle()
                                            .fill(.gray)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .gray
                                            }
                                    }
                                }
                            }
                        } else {
                            Text("Choose your color")
                            
                            if vm.solidOrGradientSelected == "Solid fill" {
                                VStack{
                                    HStack{
                                        Circle()
                                            .fill(.red)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedColor = .red
                                            }
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedColor = .blue
                                            }
                                        Circle()
                                            .fill(.yellow)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedColor = .yellow
                                            }
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedColor = .green
                                            }
                                        
                                    }
                                    HStack{
                                        Circle()
                                            .fill(.purple)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedColor = .purple
                                            }
                                        Circle()
                                            .fill(.orange)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedColor = .orange
                                            }
                                        Circle()
                                            .fill(.pink)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedColor = .pink
                                            }
                                        Circle()
                                            .fill(.gray)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedColor = .gray
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
                                                vm.pickedGradientColor1 = .red
                                                print("red color tapped")
                                            }
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .blue
                                            }
                                        Circle()
                                            .fill(.yellow)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .yellow
                                            }
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .green
                                            }
                                    }
                                    HStack{
                                        Circle()
                                            .fill(.purple)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .purple
                                            }
                                        Circle()
                                            .fill(.orange)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .orange
                                            }
                                        Circle()
                                            .fill(.pink)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .pink
                                            }
                                        Circle()
                                            .fill(.gray)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor1 = .gray
                                            }
                                    }
                                    Text("Select 2snd color")
                                        .padding()
                                    HStack{
                                        Circle()
                                            .fill(.red)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .red
                                            }
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .blue
                                            }
                                        Circle()
                                            .fill(.yellow)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .yellow
                                            }
                                        Circle()
                                            .fill(.green)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .green
                                            }
                                        
                                    }
                                    HStack{
                                        Circle()
                                            .fill(.purple)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .purple
                                            }
                                        Circle()
                                            .fill(.orange)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .orange
                                            }
                                        Circle()
                                            .fill(.pink)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .pink
                                            }
                                        Circle()
                                            .fill(.gray)
                                            .frame(width: 50, height: 50)
                                            .onTapGesture {
                                                vm.pickedGradientColor2 = .gray
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
        
        
    }
    //Main View selection
    
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
                .fill(LinearGradient(gradient: Gradient(colors: [vm.pickedGradientColor1, vm.pickedGradientColor2]), startPoint: .center, endPoint: .trailing))
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
        LinearGradient(gradient: Gradient(colors: [vm.pickedGradientColor1, vm.pickedGradientColor2]), startPoint: .leading, endPoint: .trailing)
            .ignoresSafeArea()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

