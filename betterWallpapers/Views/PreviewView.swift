//
//  preview.swift
//  betterWallpapers
//
//  Created by Artem on 06/01/2023.
//

import SwiftUI


//1st preview
struct Preview: View {
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
                HStack{
                    //lockscreen preview
                    ZStack{
                        GradientFillSelected()
                        Image("lockscreen")
                            .resizable()
                            .scaledToFit()
    //                        .offset(y: -10)
                    }
                    .frame(width: vm.cgWidth * 0.45, height: vm.cgHeight * 0.47)
                    .cornerRadius(20)
                    .padding(.leading)
                    //homescreen preview
                    ZStack{
                        GradientFillSelected()
                        Image("homescreen")
                            .resizable()
                            .scaledToFit()
    //                        .offset(y: -10)
                    }
                    .frame(width: vm.cgWidth * 0.45, height: vm.cgHeight * 0.47)
                    .cornerRadius(20)
                    .padding(.trailing)
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
                        Label("Back to edit", systemImage: "slider.horizontal.3")
                    }
                    .frame(width: 250, height: 50)
                    .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                        
                    
                    Button{
                        let newView = GradientFillSelected().environmentObject(vm)
                        vm.Save(view: newView)
                        print("saved from preview success")
                    } label: {
                       Image(systemName: "square.and.arrow.down")
                    }.frame(width: 50, height: 50)
                        .background(Color.white)
                        .cornerRadius(40)
                        .foregroundColor(.black)
                        .padding(.trailing)
                    
                    
                    
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
                HStack{
                    //lockscreen preview
                    ZStack{
                        GradientStrokeSelected()
                        Image("lockscreen")
                            .resizable()
                            .scaledToFit()
    //                        .offset(y: -10)
                    }
                    .frame(width: vm.cgWidth * 0.45, height: vm.cgHeight * 0.47)
                    .cornerRadius(20)
                    .padding(.leading)
                    //homescreen preview
                    ZStack{
                        GradientStrokeSelected()
                        Image("homescreen")
                            .resizable()
                            .scaledToFit()
    //                        .offset(y: -10)
                    }
                    .frame(width: vm.cgWidth * 0.45, height: vm.cgHeight * 0.47)
                    .cornerRadius(20)
                    .padding(.trailing)
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
                        Label("Back to edit", systemImage: "slider.horizontal.3")
                    }
                    .frame(width: 250, height: 50)
                    .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                        
                    
                    Button{
                        let newView = GradientFillSelected().environmentObject(vm)
                        vm.Save(view: newView)
                        print("saved from preview success")
                    } label: {
                       Image(systemName: "square.and.arrow.down")
                    }.frame(width: 50, height: 50)
                        .background(Color.white)
                        .cornerRadius(40)
                        .foregroundColor(.black)
                        .padding(.trailing)
                    
                    
                    
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
                //title
                HStack{
                    Text("Preview your wallpaper")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                }
                //preview screen
                Spacer()
                HStack{
                    //lockscreen preview
                    ZStack{
                        StrokeSolidFillView()
                        Image("lockscreen")
                            .resizable()
                            .scaledToFit()
    //                        .offset(y: -10)
                    }
                    .frame(width: vm.cgWidth * 0.45, height: vm.cgHeight * 0.47)
                    .cornerRadius(20)
                    .padding(.leading)
                    //homescreen preview
                    ZStack{
                        StrokeSolidFillView()
                        Image("homescreen")
                            .resizable()
                            .scaledToFit()
    //                        .offset(y: -10)
                    }
                    .frame(width: vm.cgWidth * 0.45, height: vm.cgHeight * 0.47)
                    .cornerRadius(20)
                    .padding(.trailing)
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
                        Label("Back to edit", systemImage: "slider.horizontal.3")
                    }
                    .frame(width: 250, height: 50)
                    .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                        
                    
                    Button{
                        let newView = StrokeSolidFillView().environmentObject(vm)
                        vm.Save(view: newView)
                        print("saved from preview success")
                    } label: {
                       Image(systemName: "square.and.arrow.down")
                    }.frame(width: 50, height: 50)
                        .background(Color.white)
                        .cornerRadius(40)
                        .foregroundColor(.black)
                        .padding(.trailing)
                    
                    
                    
                }
            }
        }
            
    }
}


struct preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview().environmentObject(WallpapersViewModel())
        Preview2().environmentObject(WallpapersViewModel())
    }
}



