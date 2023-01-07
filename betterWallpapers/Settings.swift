//
//  Settings.swift
//  betterWallpapers
//
//  Created by Artem on 06/01/2023.
//

import SwiftUI

struct NewSettings: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        ZStack{
            VStack{
                
                HStack(spacing:10){
                    HStack(spacing: 10){
                        Rectangle()
                            .fill(Color(red: 0.107, green: 0.158, blue: 0.213))
                            .frame(width: 50, height : 50)
                            .cornerRadius(10)
                          
                        Rectangle()
                            .fill(Color(red: 0.107, green: 0.158, blue: 0.213))
                            .frame(width: 50, height : 50)
                            .cornerRadius(10)
                            
                    }
                    .frame(width: vm.cgWidth * 0.35, height: vm.cgHeight * 0.09)
                    .background(Color(red: 0.107, green: 0.158, blue: 0.213).opacity(0.5))
                    .cornerRadius(20)
           
                    
                    HStack(spacing: 10){
                        Rectangle()
                            .fill(Color(red: 0.107, green: 0.158, blue: 0.213))
                            .frame(width: 50, height : 50)
                            .cornerRadius(10)
                        Rectangle()
                            .fill(Color(red: 0.107, green: 0.158, blue: 0.213))
                            .frame(width: 50, height : 50)
                            .cornerRadius(10)
                        Rectangle()
                            .fill(Color(red: 0.107, green: 0.158, blue: 0.213))
                            .frame(width: 50, height : 50)
                            .cornerRadius(10)
                        
                    }
                    .frame(width: vm.cgWidth * 0.52, height: vm.cgHeight * 0.09)
                    .background(Color(red: 0.107, green: 0.158, blue: 0.213).opacity(0.5))
                    .cornerRadius(20)
                   
                }.padding()
                
                ZStack{
                    
                }
                .frame(width: vm.cgWidth * 0.9, height: vm.cgHeight * 0.15)
                .background(Color(red: 0.107, green: 0.158, blue: 0.213).opacity(0.5))
                    .cornerRadius(20)
                .padding()
                
                HStack{
                    
                    
                }.padding()
                
                HStack{
                    Button {
                      //
                    }label: {
                        Label("Save", systemImage: "slider.horizontal.3")
                    }
                    .frame(width: 250, height: 50)
                    .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(.leading)
                    
                        Spacer()
                    
                    Button{
                        //
                    } label: {
                       Image(systemName: "arrow.counterclockwise")
                    }.frame(width: 80, height: 50)
                        .background(Color.white)
                        .cornerRadius(40)
                        .foregroundColor(.black)
                        .padding(.trailing)
                    
                    
                    
                }
            }
            
        }
    }
}

struct NewSettings_Previews: PreviewProvider {
    static var previews: some View {
        NewSettings().environmentObject(WallpapersViewModel())
    }
}
