//
//  test.swift
//  betterWallpapers
//
//  Created by Artem on 04/01/2023.
//

import SwiftUI
import StoreKit
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport


struct SelectView: View {
    
    @Environment(\.requestReview) var requestReview
    @EnvironmentObject var vm: WallpapersViewModel
    @State var cardWidth = UIScreen.main.bounds.width
    @State var cardHeight = UIScreen.main.bounds.height
    @State var startingOffsetX: CGFloat = UIScreen.main.bounds.width * 0.77
    @State var currentDragOffsetX: CGFloat = 0
    @State var endingOffsetX: CGFloat = 0
    
    
    
    @State var preview: Bool = false
 
    func requestPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")
                    
                    // Now that we are authorized we can get the IDFA
                    print(ASIdentifierManager.shared().advertisingIdentifier)
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            }
        }
    }
    
    
    let wallpaperView =  GradientFillSelected()
    let strokeWallpaper = GradientStrokeSelected()
    let strokeFilledWallpaper = StrokeSolidFillView()
    
    var body: some View {
        Carousel
    }
    
    var Carousel: some View {
        ZStack{
            Color(red: 0.054, green: 0.093, blue: 0.158).ignoresSafeArea()
            Image("mesh")
                .resizable()
                .scaledToFit()
            HStack(alignment: .center){
                ZStack{
                    wallpaperView
                        .frame(width: vm.isPressedBlue ? cardWidth * 0 : cardWidth * 0.7, height: vm.isPressedBlue ? cardHeight * 0: cardHeight * 0.7)
                        .cornerRadius(20)
                        .ignoresSafeArea()
                        .opacity(vm.showPreview ? 0 : 1)
                        .padding(vm.isPressedBlue ? 20 : 10)
                        .scaleEffect(vm.selectedTemplate == 1 ? 1 : 0.95)
                        .offset(x: startingOffsetX)
                        .offset(x: currentDragOffsetX)
                        .offset(x: endingOffsetX)
                        .gesture( vm.closed ?
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.spring()){
                                    currentDragOffsetX = value.translation.width
                                }
                                
                            })
                            .onEnded({ value in
                                withAnimation(.spring()){
                                        if currentDragOffsetX < -80 {
                                            endingOffsetX = -startingOffsetX
                                            currentDragOffsetX = 0
                                            print("blue if")
                                            vm.selectedTemplate = 2
                                            print("selected \(vm.selectedTemplate) view")
                                            vm.cardTitle = "Stunning Gradient Edge"
                                            
                                            
                                        } else if endingOffsetX != 0 && currentDragOffsetX > 80 {
                                            endingOffsetX = 0
                                            currentDragOffsetX = 0
                                            print("blue else")
                                        }
                                        currentDragOffsetX = 0
                                    
                                }
                            }) : nil
                        
                        )
                        .onTapGesture {
                            withAnimation(.spring()){
                                vm.isPressedBlue = true
                                vm.isPressedRed = false
                                vm.isPressedGreen = false
                                vm.closed = false
                                vm.radiusCorner = 43.89
                                
                            }
                        }
                        .fullScreenCover(isPresented: $vm.isPressedBlue) {
                            ZStack{
                                wallpaperView
                                NewSettings()
                                    .cornerRadius(50)
                                    .frame(width: vm.cgWidth * 0.87, height: vm.cgHeight * 0.67)
                                    .scaleEffect(vm.isShowingEdits ? 1 : 0)
                            }
                                .overlay(
                                    VStack{
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isPressedBlue.toggle()
                                                    vm.closed = true
                                                    vm.radiusCorner = 20
                                                    

                                                }
                                            }label: {
                                                Image("back")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 100, height: 100)
                                                    .font(.system(size: 20))
                                                    .shadow(radius: 10)
                                                    .foregroundColor(.white)
                                            }
                                           
                                            .scaleEffect(vm.isShowingEdits ? 0 : 1)
                                            Spacer()
//
                                        }.padding()
                                           
//
                                            .foregroundColor(.white)
                                        Spacer()
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isShowingEdits.toggle()
                                                    vm.previewBlocked = true
                                                }
                                            }label: {
                                                HStack (spacing: vm.saveButtonPressed ? 10 : 5){
                                                    Image(systemName: "pencil.tip.crop.circle")
                                                        .font(.system(size: 20))
                                                    Text(vm.saveButtonPressed ? "" : "Edit")
                                                }
                                            }
                                            .frame(width: vm.saveButtonPressed ? 50 : 120, height: 50)
                                            .disabled(vm.previewBlocked)
                                            .shadow(radius: 10)
                                            .background(Color.blue)
                                                .cornerRadius(50)
                                                .foregroundColor(.white)
                                                .padding(.leading)
                                            Button{
                                                withAnimation(.spring()){
                                                    vm.showPreview = true
                                                    vm.radiusCorner = 20
                                                    vm.paddingEdits = vm.paddingEdits * 0.5
                                                }
                                            } label: {
                                                HStack (spacing: vm.saveButtonPressed ? 10 : 5){
                                                    Image(systemName: "photo.circle")
                                                        .font(.system(size: 20))
                                                    Text(vm.saveButtonPressed ? "" : "Preview")
                                                }
                                            }.frame(width: vm.saveButtonPressed ? 50 : 120, height: 50)
                                                .background(Color(red: 0.054, green: 0.093, blue: 0.158))
                                                .shadow(radius: 10)
                                                .cornerRadius(50)
                                                .foregroundColor(.white)
                                                .disabled(vm.previewBlocked)
                                                
                                            
                                            
                                            Rectangle().fill(vm.saveButtonPressed ? .green : .white)
                                                .frame(width: vm.saveButtonPressed ? 150 : 50, height: 50)
                                                .cornerRadius(50)
                                                .overlay(
                                                    ZStack{
                                                        HStack(spacing: vm.saveButtonPressed ? 10 : 0){
                                                            Image(systemName: vm.saveButtonPressed ? "checkmark.circle" : "arrow.down.circle")
                                                                .foregroundColor(vm.saveButtonPressed ? .white : .black)
                                                                .font(.system(size: 20))
                                                            Text(vm.saveButtonPressed ? "Saved" : "").foregroundColor(vm.saveButtonPressed ? .white : .black)
                                                            
                                                        }
                                                    }
                                                )
                                                .shadow(radius: 10)
                                                .onTapGesture {
                                                    withAnimation(.spring()){
                        
                                                        vm.saveButtonPressed.toggle()
                                                        let newView =   GradientFillSelected().environmentObject(vm)
                                                        vm.Save(view: newView)
                                                        
                                    
                                                        print("saved from preview success")
//                                                        requestReview()
                                                    }
                                                }
                                                .disabled(vm.previewBlocked)
                                                .onChange(of: vm.saveButtonPressed, perform: { _ in
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                        withAnimation(.spring()){
                                                            vm.saveButtonPressed = false
                                                        }
                                                    }
                                                })
                                            
                                            
                                                .fullScreenCover(isPresented: $vm.showPreview) {
                                                    Preview()
                                                }
                                            
                                            
                                        }.padding(50)
                                            .scaleEffect(vm.isShowingEdits ? 0 : 1)

                                       
                                    }
                            )
                        }

                        .fullScreenCover(isPresented: $vm.isShowingSettings) {
                            Settings()
                        }
                    
                }
                    
                
                ZStack{
                    strokeWallpaper
                        .frame(width: vm.isPressedRed ? 0 : cardWidth * 0.7, height: vm.isPressedRed ? 0 : cardHeight * 0.7)
                        .cornerRadius(20)
                        .ignoresSafeArea()
                        .padding(vm.isPressedRed ? 20 : 10)
                        .scaleEffect(vm.selectedTemplate == 2 ? 1 : 0.95)
                        .offset(x: startingOffsetX)
                        .offset(x: currentDragOffsetX)
                        .offset(x: endingOffsetX)
                        .gesture( vm.closed ?
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.spring()){
                                    currentDragOffsetX = value.translation.width
                                }
                                
                            })
                            .onEnded({ value in
                                withAnimation(.spring()){
                                    
                                        if currentDragOffsetX < -80 {
                                            endingOffsetX -= startingOffsetX
                                            currentDragOffsetX = 0
                                            print("red if")
                                            vm.selectedTemplate = 3
                                            print("selected \(vm.selectedTemplate) view")
                                            vm.cardTitle = "Minimalistic Monocolor Edge"
                                            
                                        } else if endingOffsetX != 0 && currentDragOffsetX > 80 {
                                            endingOffsetX += startingOffsetX
                                            currentDragOffsetX = 0
                                            print("red else if")
                                            vm.selectedTemplate = 1
                                            print("selected \(vm.selectedTemplate) view")
                                            vm.cardTitle = "Gorgeous Gradient Fill"
                                        } else {
                                            currentDragOffsetX = 0
                                        }
                                    
                                }
                            }) : nil
                        
                        )
                        .onTapGesture {
                            withAnimation(.spring()){
                                vm.isPressedRed.toggle()
                                vm.isPressedBlue = false
                                vm.isPressedGreen = false
                                
                                vm.closed.toggle()
                                vm.radiusCorner = 43.89
                            }
                        }
                        .fullScreenCover(isPresented: $vm.isPressedRed) {
                            ZStack{
                                strokeWallpaper
                                NewSettingsStrokeGradient()
                                    .cornerRadius(50)
                                    .frame(width: vm.cgWidth * 0.9, height: vm.cgHeight * 0.5)
                                    .scaleEffect(vm.isShowingEdits ? 1 : 0)

                            }
                                .overlay(
                                    VStack{
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isPressedRed.toggle()
                                                    vm.closed = true
                                                    vm.radiusCorner = 20
                                                }
                                            }label: {
                                                Image("back")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 100, height: 100)
                                                    .font(.system(size: 20))
                                                    .shadow(radius: 10)
                                                    .foregroundColor(.white)
                                            }
                                            .padding()
                                            .scaleEffect(vm.isShowingEdits ? 0 : 1)
                                            
                                            Spacer()

                                        }.padding()
//
                                            .foregroundColor(.white)
                                        Spacer()
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isShowingEdits.toggle()
                                                    vm.previewBlocked = true
                                                }
                                            }label: {
                                                HStack (spacing: vm.saveButtonPressed ? 10 : 5){
                                                    Image(systemName: "pencil.tip.crop.circle")
                                                    Text(vm.saveButtonPressed ? "" : "Edit")
                                                }
                                            }
                                            .frame(width: vm.saveButtonPressed ? 50 : 150, height: 50)
                                            .disabled(vm.previewBlocked)
                                            .background(Color.blue)
                                            .shadow(radius: 10)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(.leading)
                                            
                                            Button{
                                                withAnimation(.spring()){
                                                    vm.showPreview = true
                                                    vm.radiusCorner = 20
                                                    vm.paddingEdits = vm.paddingEdits * 0.5
                                              
                                                }
                                            } label: {
                                                HStack (spacing: vm.saveButtonPressed ? 10 : 5){
                                                    Image(systemName: "photo.circle")
                                                        .font(.system(size: 20))
                                                    Text(vm.saveButtonPressed ? "" : "Preview")
                                                }
                                            }.frame(width: vm.saveButtonPressed ? 50 : 120, height: 50)
                                                .background(Color(red: 0.054, green: 0.093, blue: 0.158))
                                                .disabled(vm.previewBlocked)
                                                .shadow(radius: 10)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                
                                            
                                            Rectangle().fill(vm.saveButtonPressed ? .green : .white)
                                                .frame(width: vm.saveButtonPressed ? 150 : 50, height: 50)
                                                .cornerRadius(50)
                                                .overlay(
                                                    ZStack{
                                                        HStack(spacing: vm.saveButtonPressed ? 10 : 0){
                                                            Image(systemName: vm.saveButtonPressed ? "checkmark.circle" : "arrow.down.circle")
                                                                .foregroundColor(vm.saveButtonPressed ? .white : .black)
                                                            Text(vm.saveButtonPressed ? "Saved" : "").foregroundColor(vm.saveButtonPressed ? .white : .black)
                                                        }
                                                    }
                                                )
                                                .shadow(radius: 10)
                                                .onTapGesture {
                                                    vm.showAd = true
                                                    withAnimation(.spring()){
                                                        vm.saveButtonPressed.toggle()
                                                        let newView =   GradientStrokeSelected().environmentObject(vm)
                                                        vm.Save(view: newView)

                                                        requestReview()
                                                    }
                                                }
                                                .disabled(vm.previewBlocked)
                                                .onChange(of: vm.saveButtonPressed, perform: { _ in
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                        withAnimation(.spring()){
                                                            vm.saveButtonPressed = false
                                                        }
                                                    }
                                                })
                                            
                                                .fullScreenCover(isPresented: $vm.showPreview) {
                                                    Preview2()
                                                }
                                            
                                            
                                            
                                        }.padding(50)
                                            .scaleEffect(vm.isShowingEdits ? 0 : 1)

                                    }
                            )
                        }
                 

                }
                
                ZStack{
                    strokeFilledWallpaper
                        .frame(width: vm.isPressedGreen ? 0 : cardWidth * 0.7, height: vm.isPressedGreen ? 0 : cardHeight * 0.7)
                        .cornerRadius(20)
                        .ignoresSafeArea()
                        .padding(vm.isPressedGreen ? 20 : 10)
                        .scaleEffect(vm.selectedTemplate == 3 ? 1 : 0.95)
                        .offset(x: startingOffsetX)
                        .offset(x: currentDragOffsetX)
                        .offset(x: endingOffsetX)
                        .gesture( vm.closed ?
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.spring()){
                                    currentDragOffsetX = value.translation.width
                                }
                            })
                            .onEnded({ value in
                                withAnimation(.spring()){
                                   
                                        if currentDragOffsetX > 80 {
                                            endingOffsetX += startingOffsetX
                                            currentDragOffsetX = 0
                                            print("green if")
                                            vm.selectedTemplate = 2
                                            print("selected \(vm.selectedTemplate) view")
                                            vm.cardTitle = "Stunning Gradient Edge"
                                          
                                        } else if endingOffsetX != 0 && currentDragOffsetX > 80 {
                                            endingOffsetX = 0
                                            currentDragOffsetX = 0
                                        }
                                        currentDragOffsetX = 0
                                    
                                }
                            }) : nil
                        
                        )
                        .onTapGesture {
                            withAnimation(.spring()){
                                vm.isPressedGreen = true
                                vm.isPressedRed = false
                                vm.isPressedBlue = false
                                
                                vm.closed = false
                                vm.radiusCorner = 43.89
                            }
                        }
                        .fullScreenCover(isPresented: $vm.isPressedGreen) {
                            ZStack{
                                strokeFilledWallpaper
                                NewSettingsStrokeSolid()
                                    .cornerRadius(50)
                                    .frame(width: vm.cgWidth * 0.8, height: vm.cgHeight * 0.4)
                                    .scaleEffect(vm.isShowingEdits ? 1 : 0)
                                    

                            }
                                .overlay(
                                    VStack{
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isPressedGreen = false
                                                    vm.closed = true
                                                    vm.radiusCorner = 20
                                                }
                                            }label: {
                                                HStack{
                                                    Image("back")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 100, height: 100)
                                                        .font(.system(size: 20))
                                                        .shadow(radius: 10)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .padding(10)
                                            .scaleEffect(vm.isShowingEdits ? 0 : 1)
                                            Spacer()

                                        }.padding()
                                          
                                            .foregroundColor(.white)
                                        Spacer()
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isShowingEdits.toggle()
                                                    vm.previewBlocked = true
                                                }
                                            }label: {
                                                HStack (spacing: vm.saveButtonPressed ? 10 : 5){
                                                    Image(systemName: "pencil.tip.crop.circle")
                                                        .font(.system(size: 20))
                                                    Text(vm.saveButtonPressed ? "" : "Edit")
                                                }
                                            } 
                                            .frame(width: vm.saveButtonPressed ? 50 : 150, height: 50)
                                            .disabled(vm.previewBlocked)
                                            .background(Color.blue)
                                                .cornerRadius(40)
                                                .shadow(radius: 10)
                                                .foregroundColor(.white)
                                                .padding(.leading)
                                            
                                            Button{
                                                withAnimation(.spring()){
                                                    vm.showPreview = true
                                                    vm.radiusCorner = 20
                                                    vm.paddingEdits = vm.paddingEdits * 0.5
                                              
                                                }
                                            } label: {
                                                HStack (spacing: vm.saveButtonPressed ? 10 : 5){
                                                    Image(systemName: "photo.circle")
                                                        .font(.system(size: 20))
                                                    Text(vm.saveButtonPressed ? "" : "Preview")
                                                }
                                            }.frame(width: vm.saveButtonPressed ? 50 : 120, height: 50)
                                                .disabled(vm.previewBlocked)
                                                .background(Color(red: 0.054, green: 0.093, blue: 0.158))
                                                .cornerRadius(40)
                                                .shadow(radius: 10)
                                                .foregroundColor(.white)
                                                
                                            
                                            
                                            Rectangle().fill(vm.saveButtonPressed ? .green : .white)
                                                .frame(width: vm.saveButtonPressed ? 150 : 50, height: 50)
                                                .cornerRadius(50)
                                                .overlay(
                                                    ZStack{
                                                        HStack(spacing: vm.saveButtonPressed ? 10 : 0){
                                                            Image(systemName: vm.saveButtonPressed ? "checkmark.circle" : "arrow.down.circle")
                                                                .foregroundColor(vm.saveButtonPressed ? .white : .black)
                                                            Text(vm.saveButtonPressed ? "Saved" : "").foregroundColor(vm.saveButtonPressed ? .white : .black)
                                                        }
                                                    }
                                                )
                                                .shadow(radius: 10)
                                                .onTapGesture {
                                                    withAnimation(.spring()){
                                                        vm.saveButtonPressed.toggle()
                                                        let newView =   StrokeSolidFillView().environmentObject(vm)
                                                        vm.Save(view: newView)
                                                        requestReview()
                                                        print("saved from preview success")
                                                    }
                                                }
                                                .disabled(vm.previewBlocked)
                                                .onChange(of: vm.saveButtonPressed, perform: { _ in
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                        withAnimation(.spring()){
                                                            vm.saveButtonPressed = false
                                                        }
                                                    }
                                                })
                                            
                                                .fullScreenCover(isPresented: $vm.showPreview) {
                                                    Preview3()
                                                }
                                            
                                            
                                            
                                        }.padding(50)
                                        .scaleEffect(vm.isShowingEdits ? 0: 1)

                                    }
                            )
                        }
              
                   
                }
                
            }
            .frame(maxWidth: .infinity)
            .onAppear{
                requestPermission()
            }
                
        }
    }
}




struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView()
            .environmentObject(WallpapersViewModel())
    }
}
