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
            Color(red: 0.054, green: 0.093, blue: 0.158) 
                .ignoresSafeArea()
            VStack{
                Spacer()
                VStack (alignment: .center){
                    HStack(alignment: .center){
                        Text("Select gradient type").padding()
                    }
                    HStack{
                        Rectangle()
                            .strokeBorder(.white, lineWidth: vm.gradientSelected == "Linear" ? 2 : 0)
                            .frame(width: vm.cgWidth * 0.2, height: vm.cgWidth * 0.1)
                            .cornerRadius(5)
                            .overlay(
                                Text("Linear")
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
                            .frame(width: vm.cgWidth * 0.2, height: vm.cgWidth * 0.1)
                            .cornerRadius(3)
                            .overlay(
                            Text("Radial")
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
                            .frame(width: vm.cgWidth * 0.2, height: vm.cgWidth * 0.1)
                            .cornerRadius(3)
                            .overlay(
                            Text("Angular")
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
               .frame(width: vm.cgWidth * 0.5)
                .padding()
                
                    VStack{
                        HStack{
                            Text("Scale amount")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Slider(value: $vm.startRadius, in: 0...400).padding()
                        }
                        HStack{
                            Text("Corner radius")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Slider(value: $vm.endRadius, in: 0...400).padding()
                        }
                        HStack{
                            Text("Rotation amount")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Slider(value: $vm.radiusCorner, in: 0...400).padding()
                        }
                    }.frame(width: 300, height: 100)
                    .padding()
                
                    VStack{
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
                    }.frame(width: 300, height: vm.cgHeight * 0.16)
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
                    
                    
                    
                }.frame(width: vm.cgWidth, height: vm.cgHeight * 0.2)
                    .padding(30)
            }
          
   
        
        }
        
    }
}

struct NewSettings_Previews: PreviewProvider {
    static var previews: some View {
//        ColorPicker(color: .green)
        NewSettings().environmentObject(WallpapersViewModel())
    }
}


struct ColorPicker: View {
    
    @EnvironmentObject var vm: WallpapersViewModel
    
    var body: some View{
        ZStack{
            VStack{
                HStack{
                    Rectangle().fill((Color(#colorLiteral(red: 1, green: 0.3625222445, blue: 0, alpha: 1))))
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                        .padding()
                        .onTapGesture {
                            withAnimation(.spring()){
                                if vm.pickedColorIndex == 1 {
                                    vm.pickedColor = (Color(#colorLiteral(red: 1, green: 0.3625222445, blue: 0, alpha: 1)))
                                } else if vm.pickedColorIndex == 2 {
                                    vm.pickedColor2 = (Color(#colorLiteral(red: 1, green: 0.3625222445, blue: 0, alpha: 1)))
                                } else if vm.pickedColorIndex == 3 {
                                    vm.pickedColor3 = (Color(#colorLiteral(red: 1, green: 0.3625222445, blue: 0, alpha: 1)))
                                }
                                vm.showPalette = false
                            }
                        }
                        
                    Rectangle().fill(Color(#colorLiteral(red: 1, green: 0.6517165303, blue: 0, alpha: 1)))
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                        .padding()
                        .onTapGesture {
                            withAnimation(.spring()){
                                switch vm.pickedColorIndex {
                                case 1:
                                    vm.pickedColor = Color(#colorLiteral(red: 1, green: 0.6517165303, blue: 0, alpha: 1))
                                case 2:
                                    vm.pickedColor2 = Color(#colorLiteral(red: 1, green: 0.6517165303, blue: 0, alpha: 1))
                                default:
                                    vm.pickedColor3 = Color(#colorLiteral(red: 1, green: 0.6517165303, blue: 0, alpha: 1))
                                }
                                vm.showPalette = false
                            }
                        }
                    Rectangle().fill(Color(#colorLiteral(red: 0.998711288, green: 0.983805716, blue: 0, alpha: 1)))
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                        .padding()
                        .onTapGesture {
                            withAnimation(.spring()){
                                switch vm.pickedColorIndex {
                                case 1:
                                    vm.pickedColor = Color(#colorLiteral(red: 0.998711288, green: 0.983805716, blue: 0, alpha: 1))
                                case 2:
                                    vm.pickedColor2 = Color(#colorLiteral(red: 0.998711288, green: 0.983805716, blue: 0, alpha: 1))
                                default:
                                    vm.pickedColor3 = Color(#colorLiteral(red: 0.998711288, green: 0.983805716, blue: 0, alpha: 1))
                                }
                                vm.showPalette = false
                            }
                        }
                    Rectangle().fill(Color(#colorLiteral(red: 0.4865537882, green: 0.9959833026, blue: 0.5822482109, alpha: 1)))
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                        .padding()
                        .onTapGesture {
                            withAnimation(.spring()){
                                switch vm.pickedColorIndex {
                                case 1:
                                    vm.pickedColor = Color(#colorLiteral(red: 0.4865537882, green: 0.9959833026, blue: 0.5822482109, alpha: 1))
                                case 2:
                                    vm.pickedColor2 = Color(#colorLiteral(red: 0.4865537882, green: 0.9959833026, blue: 0.5822482109, alpha: 1))
                                default:
                                    vm.pickedColor3 = Color(#colorLiteral(red: 0.4865537882, green: 0.9959833026, blue: 0.5822482109, alpha: 1))
                                }
                                vm.showPalette = false
                            }
                        }
                    Rectangle().fill(.white)
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                        .padding()
                        .onTapGesture {
                            withAnimation(.spring()){
                                switch vm.pickedColorIndex {
                                case 1:
                                    vm.pickedColor = .white
                                case 2:
                                    vm.pickedColor2 = .white
                                default:
                                    vm.pickedColor3 = .white
                                }
                                vm.showPalette = false
                            }
                        }
                }
                HStack{
                    Rectangle().fill(.red)
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                        .padding()
                        .onTapGesture {
                            withAnimation(.spring()){
                                switch vm.pickedColorIndex {
                                case 1:
                                    vm.pickedColor = .red
                                case 2:
                                    vm.pickedColor2 = .red
                                default:
                                    vm.pickedColor3 = .red
                                }
                                vm.showPalette = false
                            }
                        }
                    Rectangle().fill(.purple)
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                        .padding()
                        .onTapGesture {
                            withAnimation(.spring()){
                                switch vm.pickedColorIndex {
                                case 1:
                                    vm.pickedColor = .purple
                                case 2:
                                    vm.pickedColor2 = .purple
                                default:
                                    vm.pickedColor3 = .purple
                                }
                                vm.showPalette = false
                            }
                        }
                    Rectangle().fill(Color(#colorLiteral(red: 0.233363837, green: 0.09431201965, blue: 0.6043669581, alpha: 1)))
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                        .padding()
                        .onTapGesture {
                            withAnimation(.spring()){
                                switch vm.pickedColorIndex {
                                case 1:
                                    vm.pickedColor = Color(#colorLiteral(red: 0.233363837, green: 0.09431201965, blue: 0.6043669581, alpha: 1))
                                case 2:
                                    vm.pickedColor2 = Color(#colorLiteral(red: 0.233363837, green: 0.09431201965, blue: 0.6043669581, alpha: 1))
                                default:
                                    vm.pickedColor3 = Color(#colorLiteral(red: 0.233363837, green: 0.09431201965, blue: 0.6043669581, alpha: 1))
                                }
                                vm.showPalette = false
                            }
                        }
                    Rectangle().fill(Color(#colorLiteral(red: 0, green: 0.3440731168, blue: 0.8709706664, alpha: 1)))
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                        .padding()
                        .onTapGesture {
                            withAnimation(.spring()){
                                switch vm.pickedColorIndex {
                                case 1:
                                    vm.pickedColor = Color(#colorLiteral(red: 0, green: 0.3440731168, blue: 0.8709706664, alpha: 1))
                                case 2:
                                    vm.pickedColor2 = Color(#colorLiteral(red: 0, green: 0.3440731168, blue: 0.8709706664, alpha: 1))
                                default:
                                    vm.pickedColor3 = Color(#colorLiteral(red: 0, green: 0.3440731168, blue: 0.8709706664, alpha: 1))
                                }
                                vm.showPalette = false
                            }
                        }
                    Rectangle().fill(Color(#colorLiteral(red: 0, green: 0.794865191, blue: 1, alpha: 1)))
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                        .padding()
                        .onTapGesture {
                            withAnimation(.spring()){
                                switch vm.pickedColorIndex {
                                case 1:
                                    vm.pickedColor = Color(#colorLiteral(red: 0, green: 0.794865191, blue: 1, alpha: 1))
                                case 2:
                                    vm.pickedColor2 = Color(#colorLiteral(red: 0, green: 0.794865191, blue: 1, alpha: 1))
                                default:
                                    vm.pickedColor3 = Color(#colorLiteral(red: 0, green: 0.794865191, blue: 1, alpha: 1))
                                }
                                vm.showPalette = false
                            }
                        }
                }
            }
        }
    }
}
