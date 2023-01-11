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
        SelectView()
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
                                .font(.system(size: 16))
                        }
                            .padding(.horizontal)
                        Spacer()
                        Image(systemName: "gear")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .padding(.horizontal)
                       
                    }
                    .frame(width: vm.cgWidth)
                    .scaleEffect(!vm.closed ? 0.3 : 1)
                     Spacer()
                }
            
            )
        
        
    }
    
}
    


//Stroke with solid color
struct StrokeView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        ZStack{
            if vm.solidOrGradientSelected == "Gradient fill" {
                StrokeLinearGradientView().environmentObject(vm)
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

//stroke with linear gradient filling
struct StrokeLinearGradientView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        ZStack{
            Rectangle()
                .fill( LinearGradient(gradient: Gradient(colors: [vm.pickedColor, vm.pickedColor2, vm.pickedColor3]), startPoint: .leading, endPoint: .trailing))
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

struct StrokeRadialGradientView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        ZStack{
            Rectangle()
                .fill(RadialGradient(gradient: Gradient(colors: [vm.pickedColor, vm.pickedColor2, vm.pickedColor3, vm.pickedColor]), center: .center, startRadius: vm.startRadius, endRadius: vm.endRadius))
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

struct StrokeAngularGradientView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        ZStack{
            Rectangle()
                .fill(AngularGradient(gradient: Gradient(colors: [vm.pickedColor, vm.pickedColor2, vm.pickedColor3, vm.pickedColor]), center: .center, startAngle: Angle(degrees: vm.startRadius), endAngle: Angle(degrees: vm.endRadius)))
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

        }
            
    }
}


struct FilledRadialGradientView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        ZStack{
            RadialGradient(gradient: Gradient(colors: [vm.pickedColor, vm.pickedColor2, vm.pickedColor3, vm.pickedColor]), center: .center, startRadius: vm.startRadius, endRadius: vm.endRadius)
                .ignoresSafeArea()
               
        }
    }
}


    struct FilledAngularGradientView: View {
        @EnvironmentObject var vm: WallpapersViewModel
        var body: some View {
            ZStack{
                AngularGradient(gradient: Gradient(colors: [vm.pickedColor, vm.pickedColor2, vm.pickedColor3, vm.pickedColor]), center: .center, startAngle: Angle(degrees: vm.startRadius), endAngle: Angle(degrees: vm.endRadius))
                    .ignoresSafeArea()
            }
        }
    }


struct GradientFillSelected: View {
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


struct GradientStrokeSelected: View {
    @EnvironmentObject var vm: WallpapersViewModel
    var body: some View {
        
        if vm.gradientSelected == "Linear" {
            StrokeLinearGradientView().environmentObject(vm)
        } else if vm.gradientSelected == "Radial" {
            StrokeRadialGradientView().environmentObject(vm)
            
        } else if vm.gradientSelected == "Angular" {
            StrokeAngularGradientView().environmentObject(vm)
        }
           
        
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(WallpapersViewModel())
        GradientStrokeSelected().environmentObject(WallpapersViewModel())
    }
}

