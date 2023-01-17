//
//  test.swift
//  betterWallpapers
//
//  Created by Artem on 04/01/2023.
//

import SwiftUI





struct SelectView: View {
    
  
    @EnvironmentObject var vm: WallpapersViewModel
    
    @State var cardWidth = UIScreen.main.bounds.width
    @State var cardHeight = UIScreen.main.bounds.height
    
    
    @State var startingOffsetX: CGFloat = UIScreen.main.bounds.width * 0.77
    @State var currentDragOffsetX: CGFloat = 0
    @State var endingOffsetX: CGFloat = 0
    
    
    
    @State var preview: Bool = false
 
    
    let wallpaperView =  GradientFillSelected()
    let strokeWallpaper = GradientStrokeSelected()
    let strokeFilledWallpaper = StrokeSolidFillView()
    
    var body: some View {
        Carousel
    }
    
    
    var Carousel: some View {
        ZStack{
            Color(red: 0.054, green: 0.093, blue: 0.158).ignoresSafeArea()
            HStack(alignment: .center){
                ZStack{
                    wallpaperView
                        .frame(width: vm.isPressedBlue ? cardWidth * 0 : cardWidth * 0.7, height: vm.isPressedBlue ? cardHeight * 0: cardHeight * 0.7)
                        .cornerRadius(10)
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
                            }
                        }

                        .fullScreenCover(isPresented: $vm.isPressedBlue) {
                            ZStack{
                                wallpaperView
                                NewSettings()
                                    .cornerRadius(50)
                                    .frame(width: vm.cgWidth * 0.9, height: vm.cgHeight * 0.7)
                                    .scaleEffect(vm.isShowingEdits ? 1 : 0)
//                                    .offset(y: 50)
//                                    .padding(.bottom, 20)
                            }
                                .overlay(
                                    VStack{
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isPressedBlue.toggle()
                                                    vm.closed = true

                                                }
                                            }label: {
                                                Label("Back", systemImage: "arrow.left")
                                                    .font(.system(size: 20))
                                                    .shadow(radius: 10)
                                                    .foregroundColor(.white)
                                            }.padding(10)
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
                                                }
                                            }label: {
                                                HStack (spacing: vm.saveButtonPressed ? 10 : 5){
                                                    Image(systemName: "pencil.tip.crop.circle")
                                                        .font(.system(size: 20))
                                                    Text(vm.saveButtonPressed ? "" : "Edit")
                                                }
                                            }
                                            .frame(width: vm.saveButtonPressed ? 50 : 120, height: 50)
                                            .shadow(radius: 10)
                                            .background(Color.blue)
                                                .cornerRadius(50)
                                                .foregroundColor(.white)
                                                .padding(.leading)
                                            Button{
                                                withAnimation(.spring()){
                                                    vm.showPreview = true
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
                                                    }
                                                }
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
                        .sheet(isPresented: $vm.isShowingSettings) {
                            Settings()
                                .environmentObject(WallpapersViewModel())
                                .presentationDetents([.medium])
                        }
                    
                }
                    
                
                ZStack{
                    strokeWallpaper
                        .frame(width: vm.isPressedRed ? 0 : cardWidth * 0.7, height: vm.isPressedRed ? 0 : cardHeight * 0.7)
                        .cornerRadius(10)
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
                                            
                                        } else if endingOffsetX != 0 && currentDragOffsetX > 80 {
                                            endingOffsetX += startingOffsetX
                                            currentDragOffsetX = 0
                                            print("red else if")
                                            vm.selectedTemplate = 1
                                            print("selected \(vm.selectedTemplate) view")
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
                            }
                        }
                        .fullScreenCover(isPresented: $vm.isPressedRed) {
                            ZStack{
                                strokeWallpaper
                                NewSettingsStrokeGradient()
                                    .cornerRadius(50)
                                    .frame(width: vm.cgWidth * 0.9, height: vm.cgHeight * 0.7)
                                    .scaleEffect(vm.isShowingEdits ? 1 : 0)

                            }
                                .overlay(
                                    VStack{
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isPressedRed.toggle()
                                                    vm.closed = true
                                                }
                                            }label: {
                                                Label("Back", systemImage: "arrow.left")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.white)
                                            }.padding()
                                            
                                            Spacer()

                                        }.padding()
//
                                            .foregroundColor(.white)
                                        Spacer()
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isShowingEdits.toggle()
                                                }
                                            }label: {
                                                HStack (spacing: vm.saveButtonPressed ? 10 : 5){
                                                    Image(systemName: "pencil.tip.crop.circle")
                                                    Text(vm.saveButtonPressed ? "" : "Edit")
                                                }
                                            }
                                            .frame(width: vm.saveButtonPressed ? 50 : 150, height: 50)
                                            .background(Color.blue)
                                            .shadow(radius: 10)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(.leading)
                                            
                                            Button{
                                                withAnimation(.spring()){
                                                    vm.showPreview = true
                                              
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
                                                    withAnimation(.spring()){
                                                        vm.saveButtonPressed.toggle()
                                                        let newView =   GradientStrokeSelected().environmentObject(vm)
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
                        .cornerRadius(10)
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
                            }
                        }
                        .fullScreenCover(isPresented: $vm.isPressedGreen) {
                            ZStack{
                                strokeFilledWallpaper
                                NewSettingsStrokeSolid()
                                    .cornerRadius(50)
                                    .frame(width: vm.cgWidth * 0.9, height: vm.cgHeight * 0.7)
                                    .scaleEffect(vm.isShowingEdits ? 1 : 0)

                            }
                                .overlay(
                                    VStack{
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isPressedGreen = false
                                                    vm.closed = true
                                                }
                                            }label: {
                                                HStack{
                                                    Image(systemName: "arrow.left")
                                                    Text("Back")
                                                }
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.white)
                                            }.padding(10)
                                            Spacer()

                                        }.padding()
                                          
                                            .foregroundColor(.white)
                                        Spacer()
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isShowingEdits.toggle()
                                                }
                                            }label: {
                                                HStack (spacing: vm.saveButtonPressed ? 10 : 5){
                                                    Image(systemName: "pencil.tip.crop.circle")
                                                        .font(.system(size: 20))
                                                    Text(vm.saveButtonPressed ? "" : "Edit")
                                                }
                                            } 
                                            .frame(width: vm.saveButtonPressed ? 50 : 150, height: 50)
                                            .background(Color.blue)
                                                .cornerRadius(40)
                                                .shadow(radius: 10)
                                                .foregroundColor(.white)
                                                .padding(.leading)
                                            
                                            Button{
                                                withAnimation(.spring()){
                                                    vm.showPreview = true
                                              
                                                }
                                            } label: {
                                                HStack (spacing: vm.saveButtonPressed ? 10 : 5){
                                                    Image(systemName: "photo.circle")
                                                        .font(.system(size: 20))
                                                    Text(vm.saveButtonPressed ? "" : "Preview")
                                                }
                                            }.frame(width: vm.saveButtonPressed ? 50 : 120, height: 50)
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
                                            
                                                .fullScreenCover(isPresented: $vm.showPreview) {
                                                    Preview3()
                                                }
                                            
                                            
                                            
                                        }.padding(50)
                                        .scaleEffect(vm.isShowingEdits ? 0: 1)

                                    }
                            )
                        }
              
                   
                }
                
            }.frame(maxWidth: .infinity)
                
        }
    }
}




struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView().environmentObject(WallpapersViewModel())
    }
}
