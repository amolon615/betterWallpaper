//
//  preview.swift
//  betterWallpapers
//
//  Created by Artem on 06/01/2023.
//

import SwiftUI

struct Preview_Layout: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View{
        
        Preview()
            .overlay(
                VStack{
                    HStack{
                        HStack{
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                
                            Text("betterWallpapers")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                                .font(.system(.body, design: .rounded))
                                
                        }
                            .padding(.horizontal)
                        Spacer()
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .padding(.horizontal)
                            .onTapGesture {
                                vm.isShowingSettings = true
                            }
                       
                    }
                    .frame(width: vm.cgWidth)
                    .scaleEffect(!vm.closed ? 0 : 1)
           
   Spacer()
                }
            
            )
    }
}



//1st preview
struct Preview: View {
    @EnvironmentObject var vm: WallpapersViewModel
    
    
    
    
    
    var body: some View{
        //preview 1
        ZStack{
            Color(red: 0.054, green: 0.093, blue: 0.158).ignoresSafeArea()
            VStack{
                //title
                Spacer()
                HStack{
                    Text("Preview your wallpaper")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                }
                //preview screen
                
                
                HStack (spacing: 0){
                    //lockscreen preview
                    ZStack{
                        GradientFillSelected()
                        Image(vm.cgWidth > 740 ? "ipad_layout_lockscreen" : "iphone_layout_lockscreen")
                            .resizable()
                            .scaledToFit()
                            .offset(y: vm.cgWidth > 740 ? 0 : -10)
                    }

                    .cornerRadius(vm.radiusCorner)
                    
                    .frame(width: vm.cgWidth * 0.5, height: vm.cgHeight * 0.5)
                    .scaleEffect(vm.cgWidth > 740 ? 0.87 : 0.9)
                  
                    
                    ZStack{
                        GradientFillSelected()
                        Image(vm.cgWidth > 740 ? "ipad_layout_homescreen" : "iphone_layout_homescreen")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.9)
                            .offset(y: +10)
                    }
                .cornerRadius(vm.radiusCorner)
                        .frame(width: vm.cgWidth * 0.5, height: vm.cgHeight * 0.5)
                        .scaleEffect(vm.cgWidth > 740 ? 0.87 : 0.9)
                    
                    
                }
                
                //bottom buttons menu
                Spacer()
                
                
                HStack{
                    Button {
                        withAnimation(){
                            vm.showPreview = false
                            print("dismissed preview")
                        }
                    }label: {
                        Label("Back to edit", systemImage: "arrow.counterclockwise.circle")
                            .font(.system(size: 20))
                    }
                    .frame(width: vm.saveButtonPressed ? 150 : 250, height: 50)
                    .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                        
                    
                    Rectangle().fill(vm.saveButtonPressed ? .green : .white)
                        .frame(width: vm.saveButtonPressed ? 150 : 50, height: 50)
                        .cornerRadius(50)
                        .overlay(
                            ZStack{
                                HStack(spacing: vm.saveButtonPressed ? 10 : 0){
                                    Image(systemName: vm.saveButtonPressed ? "checkmark.circle" : "arrow.down.circle")
                                        .foregroundColor(vm.saveButtonPressed ? .white : .black)
                                        .font(.system(size: 20))
                                    Text(vm.saveButtonPressed ? "Saved" : "")
                                        .foregroundColor(vm.saveButtonPressed ? .white : .black)
                                }
                            }
                        )
                        .shadow(radius: 10)
                        .onTapGesture {
                            withAnimation(.spring()){
                                vm.saveButtonPressed.toggle()
                                let newView = GradientFillSelected().environmentObject(vm)
                                vm.Save(view: newView)
                                print("saved from preview success")
                            }
                        }
                        .onChange(of: vm.saveButtonPressed, perform: { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.spring()){
                                    vm.saveButtonPressed = false
                                }
                            }
                        })
                    
                  
                    
                    
                    
                }
            }
        }
            
    }
}


struct Preview2: View {
    @EnvironmentObject var vm: WallpapersViewModel
    
    var body: some View{
        //preview 1
        ZStack{
            Color(red: 0.054, green: 0.093, blue: 0.158).ignoresSafeArea()
            VStack{
                //title
                HStack{
                    Text("Preview your wallpaper")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                }
                //preview screen
                Spacer()
                HStack (spacing: 0){
                    //lockscreen preview
                    ZStack{
                        GradientStrokeSelected()
                        Image(vm.cgWidth > 740 ? "ipad_layout_lockscreen" : "iphone_layout_lockscreen")
                            .resizable()
                            .scaledToFit()
                            .offset(y: vm.cgWidth > 740 ? 0 : -10)
                    }

                    .cornerRadius(vm.radiusCorner)
                    
                    .frame(width: vm.cgWidth * 0.5, height: vm.cgHeight * 0.5)
                    .scaleEffect(vm.cgWidth > 740 ? 0.87 : 0.9)
                  
                    
                    ZStack{
                        GradientStrokeSelected()
                        Image(vm.cgWidth > 740 ? "ipad_layout_homescreen" : "iphone_layout_homescreen")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.9)
                            .offset(y: +10)
                    }
                .cornerRadius(vm.radiusCorner)
                        .frame(width: vm.cgWidth * 0.5, height: vm.cgHeight * 0.5)
                        .scaleEffect(vm.cgWidth > 740 ? 0.87 : 0.9)
                    
                    
                }
                //bottom buttons menu
                Spacer()
                HStack{
                    Button {
                        withAnimation(){
                            vm.showPreview = false
                            print("dismissed preview")
                        }
                    }label: {
                        Label("Back to edit", systemImage: "arrow.counterclockwise.circle")
                            .font(.system(size: 20))
                    }
                    .frame(width: vm.saveButtonPressed ? 150 : 250, height: 50)
                    .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                    Rectangle().fill(vm.saveButtonPressed ? .green : .white)
                        .frame(width: vm.saveButtonPressed ? 150 : 50, height: 50)
                        .cornerRadius(50)
                        .overlay(
                            ZStack{
                                HStack(spacing: vm.saveButtonPressed ? 10 : 0){
                                    Image(systemName: vm.saveButtonPressed ? "checkmark.circle" : "arrow.down.circle")
                                        .foregroundColor(vm.saveButtonPressed ? .white : .black)
                                        .font(.system(size: 20))
                                    Text(vm.saveButtonPressed ? "Saved" : "")
                                        .foregroundColor(vm.saveButtonPressed ? .white : .black)
                                }
                            }
                        )
                        .shadow(radius: 10)
                        .onTapGesture {
                            withAnimation(.spring()){
                                vm.saveButtonPressed.toggle()
                                let newView = GradientFillSelected().environmentObject(vm)
                                vm.Save(view: newView)
                                print("saved from preview success")
                            }
                        }
                        .onChange(of: vm.saveButtonPressed, perform: { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.spring()){
                                    vm.saveButtonPressed = false
                                }
                            }
                        })
                    
                   
                    
                    
                }
            }
        }
            
    }
}

struct Preview3: View {
    @EnvironmentObject var vm: WallpapersViewModel
    
    var body: some View{
        //preview 1
        ZStack{
            Color(red: 0.054, green: 0.093, blue: 0.158).ignoresSafeArea()
            
            VStack{
                Spacer()
                    Text("Preview your wallpaper")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                
                HStack (spacing: 0){
                    //lockscreen preview
                    ZStack{
                        StrokeSolidFillView()
                        Image(vm.cgWidth > 740 ? "ipad_layout_lockscreen" : "iphone_layout_lockscreen")
                            .resizable()
                            .scaledToFit()
                            .offset(y: vm.cgWidth > 740 ? 0 : -10)
                    }

                    .cornerRadius(vm.radiusCorner)
                    
                    .frame(width: vm.cgWidth * 0.5, height: vm.cgHeight * 0.5)
                    .scaleEffect(vm.cgWidth > 740 ? 0.87 : 0.9)
                  
                    
                    ZStack{
                        StrokeSolidFillView()
                        Image(vm.cgWidth > 740 ? "ipad_layout_homescreen" : "iphone_layout_homescreen")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.9)
                            .offset(y: +10)
                    }
                .cornerRadius(vm.radiusCorner)
                        .frame(width: vm.cgWidth * 0.5, height: vm.cgHeight * 0.5)
                        .scaleEffect(vm.cgWidth > 740 ? 0.87 : 0.9)
                    
                    
                }
                     
                Spacer()
                HStack{
                    Button {
                        withAnimation(){
                            vm.showPreview = false
                            print("dismissed preview")
                        }
                    }label: {
                        Label("Back to edit", systemImage: "arrow.counterclockwise.circle")
                            .font(.system(size: 20))
                    }
                    .frame(width: vm.saveButtonPressed ? 150 : 250, height: 50)
                    .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                    
                    Rectangle().fill(vm.saveButtonPressed ? .green : .white)
                        .frame(width: vm.saveButtonPressed ? 150 : 50, height: 50)
                        .cornerRadius(50)
                        .overlay(
                            ZStack{
                                HStack(spacing: vm.saveButtonPressed ? 10 : 0){
                                    Image(systemName: vm.saveButtonPressed ? "checkmark.circle" : "arrow.down.circle")
                                        .foregroundColor(vm.saveButtonPressed ? .white : .black)
                                        .font(.system(size: 20))
                                    Text(vm.saveButtonPressed ? "Saved" : "")
                                        .foregroundColor(vm.saveButtonPressed ? .white : .black)
                                }
                            }
                        )
                        .shadow(radius: 10)
                        .onTapGesture {
                            withAnimation(.spring()){
                                vm.saveButtonPressed.toggle()
                                let newView = StrokeSolidFillView().environmentObject(vm)
                                vm.Save(view: newView)
                                print("saved from preview success")
                            }
                        }
                        .onChange(of: vm.saveButtonPressed, perform: { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.spring()){
                                    vm.saveButtonPressed = false
                                }
                            }
                        })



                }
//                    .frame(width: 300, height: 100)
                    
            }
//            .frame(width: 300, height: 700)
         
        }
            
    }
}


struct preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview_Layout().environmentObject(WallpapersViewModel())
        Preview().environmentObject(WallpapersViewModel())
        Preview2().environmentObject(WallpapersViewModel())
        Preview3().environmentObject(WallpapersViewModel())
       
    }
}



