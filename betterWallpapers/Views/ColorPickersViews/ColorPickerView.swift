//
//  ColorPickerView.swift
//  betterWallpapers
//
//  Created by Artem on 04/01/2023.
//

import SwiftUI

struct ColorPickerView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    
    var body: some View{
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
            .environmentObject(vm)
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView().environmentObject(WallpapersViewModel())
    }
}
