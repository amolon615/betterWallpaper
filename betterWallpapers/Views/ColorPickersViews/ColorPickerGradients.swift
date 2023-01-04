//
//  ColorPickerGradients.swift
//  betterWallpapers
//
//  Created by Artem on 04/01/2023.
//

import SwiftUI

struct ColorPickerGradients: View {
    @EnvironmentObject var vm: WallpapersViewModel
    
    var body: some View{
        VStack{
            HStack{
                Circle()
                    .fill(.red)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        vm.pickedColor2 = .red
                    }
                Circle()
                    .fill(.blue)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        vm.pickedColor2 = .blue
                    }
                Circle()
                    .fill(.yellow)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        vm.pickedColor2 = .yellow
                    }
                Circle()
                    .fill(.green)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        vm.pickedColor2 = .green
                    }
                
            }
            HStack{
                Circle()
                    .fill(.purple)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        vm.pickedColor2 = .purple
                    }
                Circle()
                    .fill(.orange)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        vm.pickedColor2 = .orange
                    }
                Circle()
                    .fill(.pink)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        vm.pickedColor2 = .pink
                    }
                Circle()
                    .fill(.gray)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        vm.pickedColor2 = .gray
                    }
            }
            .environmentObject(vm)
        }
    }
}

struct ColorPickerGradients_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerGradients()
    }
}
