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
    
    @State var isPressedBlue: Bool = false
    @State var isPressedRed: Bool = false
    @State var isPressedGreen: Bool = false
    
    @State var preview: Bool = false
    

    
    

    
    @State var closed: Bool = true
    
    let wallpaperView = FilledGradientView()
    
    var body: some View {
        
        HStack(alignment: .center){
            ZStack{
                wallpaperView
                    .frame(width: isPressedBlue ? cardWidth : cardWidth * 0.7, height: isPressedBlue ? cardHeight : cardHeight * 0.7)
                    .cornerRadius(40)
                    .ignoresSafeArea()
                    .opacity(vm.showPreview ? 0 : 1)
                    .padding(isPressedBlue ? 20 : 10)
                    .offset(x: startingOffsetX)
                    .offset(x: currentDragOffsetX)
                    .offset(x: endingOffsetX)
           
                   
                
                    VStack{
                        //Overlay
                        VStack{
                            HStack{
                                Button {
                                    withAnimation(){
                                        isPressedBlue.toggle()
                                        closed = true
                                        vm.showOverlay = false
                                    }
                                }label: {
                                    Label("Back", systemImage: "arrow.left")
                                        .font(.system(size: 20))
                                }.padding(10)
                                Spacer()
                                Button {
                                    //
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
                                        vm.showOverlay = false
                                    }
                                } label: {
                                    Label("Preview", systemImage: "photo")
                                }.frame(width: 120, height: 50)
                                    .background(Color(red: 0.054, green: 0.093, blue: 0.158))
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                                    
                                
                                Button{
                                    let newView = FilledGradientView().environmentObject(vm)
                                    vm.Save(view: newView)
                                } label: {
                                   Image(systemName: "square.and.arrow.down")
                                }.frame(width: 50, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(40)
                                    .foregroundColor(.black)
                                    .padding(.trailing)
                                
                                
                                
                            }.padding(50)
                          
                            
                        }
                    
                        
                        
                    }
                    .frame(width: isPressedBlue ? vm.cgWidth : 0, height: isPressedBlue ? vm.cgHeight : 0)
                    .scaleEffect(vm.showOverlay ? 1 : 0)
                    .offset(x: startingOffsetX)
                    .offset(x: currentDragOffsetX)
                    .offset(x: endingOffsetX)
                
                   
                    Preview()
                    .frame(width: vm.showPreview ? vm.cgWidth : 0, height: vm.showPreview ? vm.cgHeight * 0.8 : 0)
                    .scaleEffect(vm.showPreview ? 1 : 0)
                    .offset(x: startingOffsetX)
                    .offset(x: currentDragOffsetX)
                    .offset(x: endingOffsetX)
                    .gesture( closed ?
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
                            isPressedBlue = true
                            isPressedRed = false
                            isPressedGreen = false
                            closed = false
                            vm.showOverlay = true
                        }
                    }

              
                    .sheet(isPresented: $vm.isShowingEdits) {
                        Edits()
                    }
            }
                
            
            ZStack{
                FilledSolidView()
                    .frame(width: isPressedRed ? cardWidth : cardWidth * 0.7, height: isPressedRed ? cardHeight : cardHeight * 0.7)
                    .cornerRadius(40)
                    .ignoresSafeArea()
                    .padding(isPressedRed ? 20 : 10)
                    .offset(x: startingOffsetX)
                    .offset(x: currentDragOffsetX)
                    .offset(x: endingOffsetX)
                    .gesture( closed ?
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
                                        
                                    } else if endingOffsetX != 0 && currentDragOffsetX > 80 {
                                        endingOffsetX += startingOffsetX
                                        currentDragOffsetX = 0
                                        print("red else if")
                                    } else {
                                        currentDragOffsetX = 0
                                    }
                                
                            }
                        }) : nil
                    
                    )
                    .onTapGesture {
                        withAnimation(.spring()){
                            isPressedRed.toggle()
                            isPressedBlue = false
                            isPressedGreen = false
                            
                            closed.toggle()
                        }
                    }
             
//                debug coordinates
//                VStack{
//                    Text("Current drag x: \(currentDragOffsetX)") .font(.headline)
//                    Text("Starting drag x: \(startingOffsetX)").font(.headline)
//                    Text("Ending drag x: \(endingOffsetX)") .font(.headline)
//                }.foregroundColor(.white)
                   
            }
            
            ZStack{
                StrokeGradientView()
                    .frame(width: isPressedGreen ? cardWidth : cardWidth * 0.7, height: isPressedGreen ? cardHeight : cardHeight * 0.7)
                    .cornerRadius(40)
                    .ignoresSafeArea()
                    .padding(isPressedGreen ? 20 : 10)
                    .offset(x: startingOffsetX)
                    .offset(x: currentDragOffsetX)
                    .offset(x: endingOffsetX)
                    .gesture( closed ?
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
                            isPressedGreen.toggle()
                            isPressedRed = false
                            isPressedBlue = false
                            
                            closed.toggle()
                        }
                    }
          
               
            }
            
        }.frame(maxWidth: .infinity)
    }
}




struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView().environmentObject(WallpapersViewModel())
    }
}
