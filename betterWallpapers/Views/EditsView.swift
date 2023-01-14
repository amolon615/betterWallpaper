//
//  EditsView.swift
//  betterWallpapers
//
//  Created by Artem on 13/01/2023.
//

import SwiftUI

struct EditsView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    @State var openEditor = false
    
    
    var body: some View {
        ZStack{
            VStack{
                Button {
                    withAnimation{
                        openEditor.toggle()
                        print("button tapped")
                    }
                } label : {
                    Text("Open editor")
                }
                ZStack (alignment: .bottom){
                    mainView.cornerRadius(20)
                }.scaleEffect(openEditor ? 0.8 : 0)
            }
        }
        
    }
    
    var mainView: some View {
        ZStack{
            Color(red: 0.054, green: 0.093, blue: 0.158)
                .ignoresSafeArea()
            
            
            VStack(spacing: -10){
               
              
                VStack (alignment: .center){
                    HStack(alignment: .center){
                        Text("Select gradient type").foregroundColor(.white)
                            .padding()
                    }
                    HStack{
                        Rectangle()
                            .strokeBorder(.white, lineWidth: vm.gradientSelected == "Linear" ? 2 : 0)
                            .frame(width: 80, height: 40)
                            .cornerRadius(5)
                            .overlay(
                                HStack{
                                    Image("linear").resizable().scaledToFit().frame(width: 15, height: 15)
                                    Text("Linear")
                                }
                                    .font(.footnote)
                                .foregroundColor(.white)
                            ).padding()
                            .onTapGesture {
                                withAnimation(.spring()){
                                    vm.gradientSelected = "Linear"
                                }
                            }
                        
                        Rectangle()
                            .strokeBorder(.white, lineWidth: vm.gradientSelected == "Radial" ? 2 : 0)
                            .frame(width: 80, height: 40)
                            .cornerRadius(3)
                            .overlay(
                                HStack{
                                    Image("radial").resizable().scaledToFit().frame(width: 15, height: 15)
                                    Text("Radial")
                                }
                                .font(.footnote)
                                .foregroundColor(.white)
                            ).padding()
                            .onTapGesture {
                                withAnimation(.spring()){
                                    vm.gradientSelected = "Radial"
                                }
                            }
                        
                        Rectangle()
                            .strokeBorder(.white, lineWidth: vm.gradientSelected == "Angular" ? 2 : 0)
                            .frame(width: 80, height: 40)
                            .cornerRadius(3)
                            .overlay(
                                HStack{
                                    Image("angular").resizable().scaledToFit().frame(width: 15, height: 15)
                                    Text("Angular")
                                }
                                .font(.footnote)
                                .foregroundColor(.white)
                            ).padding()
                            .onTapGesture {
                                withAnimation(.spring()){
                                    vm.gradientSelected = "Angular"
                                }
                            }
                           
                    
                    }
                }
                .frame(width: 300, height: 100)
//                .background(.blue)
                
                
                VStack{
                    HStack{
                        Text("Adjust parameters").foregroundColor(.white)
                    }
                    HStack(spacing: 10){
                            Text(vm.gradientSelected == "Radial" ? "Start radius" : "Scale amount").foregroundColor(.white)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.trailing)
                            Slider(value: $vm.startRadius, in: 0...400).frame(width: 150)
                                
                        }
                    HStack(spacing: 20){
                            Text(vm.gradientSelected == "Radial" ? "End radius" : "Corner radius").foregroundColor(.white)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Slider(value: $vm.endRadius, in: 0...400).frame(width: 150)
                                
                        }
                    HStack (spacing: 10){
                            Text(vm.gradientSelected == "Radial" ? "Corner radius" : "Rotation amount").foregroundColor(.white)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Slider(value: $vm.radiusCorner, in: 0...400).frame(width: 150)
                       
                               
                                
                        }
                    }.frame(width: 300, height: 160)
//                    .background(.red)
                    .padding()
                
                    VStack{
                        HStack{
                            Text("Select colors").foregroundColor(.white)
                        }
                        ZStack{
                            HStack{
                                Rectangle().fill(vm.pickedColor)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                    .padding()
                                    .onTapGesture {
                                        withAnimation(.spring()){
                                            vm.pickedColorIndex = 1
                                            vm.showPalette = true
                                        }
                                    }
                                
                                Rectangle().fill(vm.pickedColor2)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                    .padding()
                                    .onTapGesture {
                                        withAnimation(.spring()){
                                            vm.pickedColorIndex = 2
                                            vm.showPalette = true
                                        }
                                    }
                                
                                Rectangle().fill(vm.pickedColor3)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                    .padding()
                                    .onTapGesture {
                                        withAnimation(.spring()){
                                            vm.pickedColorIndex = 3
                                            vm.showPalette = true
                                        }
                                    }
                                
                                    
                            }.scaleEffect(!vm.showPalette ? 1 : 0)
                                .padding()
                            ColorPicker()
                                .scaleEffect(vm.showPalette ? 1 : 0)
                            
                            
                            
                        }
                    }.frame(width: 300, height: 170)
//                    .background(.green)
                    .padding()
             
                HStack{
                    Button {
                        withAnimation(){
                            vm.isShowingEdits = false
                        }
                    }label: {
                        Label("Save", systemImage: "checkmark.circle")
                    }
                    .frame(width: 183, height: 50)
                    .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                        
                    
                    Button{
                        withAnimation(.spring()){
                            vm.radiusCorner = 40
                            vm.startRadius = 0
                            vm.endRadius = 200
                            vm.isShowingEdits = false
                        }
                    } label: {
                       Image(systemName: "arrow.counterclockwise")
                    }.frame(width: 50, height: 50)
                        .background(Color.white)
                        .cornerRadius(40)
                        .foregroundColor(.black)
                        .padding(.trailing)
                    
                    
                    
                }.frame(width: 300, height: 60)
//                    .background(.pink)
                    .padding(10)
            }

          
   
        
        }
    }
}

struct EditsView_Previews: PreviewProvider {
    static var previews: some View {
        EditsView().environmentObject(WallpapersViewModel())
    }
}
