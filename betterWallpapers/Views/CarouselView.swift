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
                        .cornerRadius(40)
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
                            wallpaperView
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
                                            }.padding(10)
                                            Spacer()
                                            Button {
                                                vm.isPressedBlue.toggle()
                                            } label : {
                                                Image(systemName: "gearshape.fill")
                                                    .font(.system(size: 25))
                                                   
                                            }
                                        }.padding()
                                            .position(x: 190, y: 84)
                                            .foregroundColor(.white)
                                        Spacer()
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isShowingEdits.toggle()
                                                }
                                            }label: {
                                                Label("Edit", systemImage: "slider.horizontal.3")
                                            }
                                            .frame(width: 150, height: 50)
                                            .background(Color.blue)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(.leading)
                                            
                                            Button{
                                                withAnimation(.spring()){
                                                    vm.showPreview = true
                                                }
                                            } label: {
                                                Label("Preview", systemImage: "photo")
                                            }.frame(width: 120, height: 50)
                                                .background(Color(red: 0.054, green: 0.093, blue: 0.158))
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                
                                            
                                            Button{
                                                let newView =   GradientFillSelected().environmentObject(vm)
                                                vm.Save(view: newView)
                                            } label: {
                                               Image(systemName: "square.and.arrow.down")
                                            }.frame(width: 50, height: 50)
                                                .background(Color.white)
                                                .cornerRadius(40)
                                                .foregroundColor(.black)
                                                .padding(.trailing)
                                                .fullScreenCover(isPresented: $vm.showPreview) {
                                                    Preview()
                                                }
                                            
                                            
                                        }.padding(50)
                                            .sheet(isPresented: $vm.isShowingEdits) {
                                                NewSettings()
                                                    .presentationDetents([.fraction(0.73)])
                                                    .presentationDragIndicator(.hidden)
                                            }
                                            
                                    }
                            )
                        }
                }
                    
                
                ZStack{
                    strokeWallpaper
                        .frame(width: vm.isPressedRed ? 0 : cardWidth * 0.7, height: vm.isPressedRed ? 0 : cardHeight * 0.7)
                        .cornerRadius(40)
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
                            strokeWallpaper
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
                                            }.padding(10)
                                            Spacer()
                                            Button {
                                                vm.isPressedBlue.toggle()
                                            } label : {
                                                Image(systemName: "gearshape.fill")
                                                    .font(.system(size: 25))
                                                   
                                            }
                                        }.padding()
                                            .position(x: 190, y: 84)
                                            .foregroundColor(.white)
                                        Spacer()
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isShowingEdits.toggle()
                                                }
                                            }label: {
                                                Label("Edit", systemImage: "slider.horizontal.3")
                                            }
                                            .frame(width: 150, height: 50)
                                            .background(Color.blue)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(.leading)
                                            
                                            Button{
                                                withAnimation(.spring()){
                                                    vm.showPreview = true
                                              
                                                }
                                            } label: {
                                                Label("Preview", systemImage: "photo")
                                            }.frame(width: 120, height: 50)
                                                .background(Color(red: 0.054, green: 0.093, blue: 0.158))
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                
                                            
                                            Button{
                                                let newView =   GradientStrokeSelected().environmentObject(vm)
                                                vm.Save(view: newView)
                                            } label: {
                                               Image(systemName: "square.and.arrow.down")
                                            }.frame(width: 50, height: 50)
                                                .background(Color.white)
                                                .cornerRadius(40)
                                                .foregroundColor(.black)
                                                .padding(.trailing)
                                                .fullScreenCover(isPresented: $vm.showPreview) {
                                                    Preview2()
                                                }
                                            
                                            
                                            
                                        }.padding(50)
                                            .sheet(isPresented: $vm.isShowingEdits) {
                                                NewSettingsStrokeGradient()
                                                    .presentationDetents([.fraction(0.73)])
                                                    .presentationDragIndicator(.hidden)
                                            }
                                    }
                            )
                        }
                 
    //                debug coordinates
//                    VStack{
//                        Text("Current drag x: \(currentDragOffsetX)") .font(.headline)
//                        Text("Starting drag x: \(startingOffsetX)").font(.headline)
//                        Text("Ending drag x: \(endingOffsetX)") .font(.headline)
//                    }.foregroundColor(.white)
//
                }
                
                ZStack{
                    strokeFilledWallpaper
                        .frame(width: vm.isPressedGreen ? 0 : cardWidth * 0.7, height: vm.isPressedGreen ? 0 : cardHeight * 0.7)
                        .cornerRadius(40)
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
                            strokeFilledWallpaper
                                .overlay(
                                    VStack{
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isPressedGreen = false
                                                    vm.closed = true
                                                }
                                            }label: {
                                                Label("Back", systemImage: "arrow.left")
                                                    .font(.system(size: 20))
                                            }.padding(10)
                                            Spacer()
                                            Button {
                                                vm.isPressedBlue.toggle()
                                            } label : {
                                                Image(systemName: "gearshape.fill")
                                                    .font(.system(size: 25))
                                                   
                                            }
                                        }.padding()
                                            .position(x: 190, y: 84)
                                            .foregroundColor(.white)
                                        Spacer()
                                        HStack{
                                            Button {
                                                withAnimation(){
                                                    vm.isShowingEdits.toggle()
                                                }
                                            }label: {
                                                Label("Edit", systemImage: "slider.horizontal.3")
                                            } 
                                            .frame(width: 150, height: 50)
                                            .background(Color.blue)
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                .padding(.leading)
                                            
                                            Button{
                                                withAnimation(.spring()){
                                                    vm.showPreview = true
                                              
                                                }
                                            } label: {
                                                Label("Preview", systemImage: "photo")
                                            }.frame(width: 120, height: 50)
                                                .background(Color(red: 0.054, green: 0.093, blue: 0.158))
                                                .cornerRadius(40)
                                                .foregroundColor(.white)
                                                
                                            
                                            Button{
                                                let newView =   GradientStrokeSelected().environmentObject(vm)
                                                vm.Save(view: newView)
                                            } label: {
                                               Image(systemName: "square.and.arrow.down")
                                            }.frame(width: 50, height: 50)
                                                .background(Color.white)
                                                .cornerRadius(40)
                                                .foregroundColor(.black)
                                                .padding(.trailing)
                                                .fullScreenCover(isPresented: $vm.showPreview) {
                                                    Preview3()
                                                }
                                            
                                            
                                            
                                        }.padding(50)
                                            .sheet(isPresented: $vm.isShowingEdits) {
                                                NewSettingsStrokeSolid()
                                                    .presentationDetents([.fraction(0.5)])
                                                    .presentationDragIndicator(.hidden)
                                            }
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
