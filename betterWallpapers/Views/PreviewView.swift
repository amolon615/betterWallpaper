//
//  preview.swift
//  betterWallpapers
//
//  Created by Artem on 06/01/2023.
//

import SwiftUI

struct Preview: View {
    @EnvironmentObject var vm: WallpapersViewModel
    
    
    var body: some View{
        ZStack{
        
            VStack{
                //title
                HStack{
                    Text("Preview your wallpaper")
                        .font(.headline)
                        .padding()
                }
                //preview screen
                Spacer()
                HStack{
                    //lockscreen preview
                    ZStack{
                        GradientSelected()
                        Image("lockscreen")
                            .resizable()
                            .scaledToFit()
    //                        .offset(y: -10)
                    }
                    .frame(width: vm.cgWidth * 0.45, height: vm.cgHeight * 0.5)
                    .cornerRadius(20)
                    .padding(.leading)
                    //homescreen preview
                    ZStack{
                        GradientSelected()
                        Image("homescreen")
                            .resizable()
                            .scaledToFit()
    //                        .offset(y: -10)
                    }
                    .frame(width: vm.cgWidth * 0.45, height: vm.cgHeight * 0.5)
                    .cornerRadius(20)
                    .padding(.trailing)
                }
                //bottom buttons menu
                Spacer()
                HStack{
                    Button {
                        withAnimation(){
                            vm.showPreview = false
                            vm.showOverlay = true
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
                        let newView = GradientSelected().environmentObject(vm)
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
    }
}



