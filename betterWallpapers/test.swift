//
//  test.swift
//  betterWallpapers
//
//  Created by Artem on 04/01/2023.
//

import SwiftUI





struct test: View {

    
    @State var cardWidth = UIScreen.main.bounds.width
    @State var cardHeight = UIScreen.main.bounds.height
    
    
    @State var startingOffsetX: CGFloat = UIScreen.main.bounds.width * 0.77
    @State var currentDragOffsetX: CGFloat = 0
    @State var endingOffsetX: CGFloat = 0
    
    @State var isPressedBlue: Bool = false
    @State var isPressedRed: Bool = false
    @State var isPressedGreen: Bool = false
    
    

    
    @State var closed: Bool = true
    
    var body: some View {
        
        HStack{
            ZStack{
                Rectangle().fill(.blue.opacity(0.5))
                    .frame(width: isPressedBlue ? cardWidth : cardWidth * 0.7, height: isPressedBlue ? cardHeight : cardHeight * 0.7)
                    .cornerRadius(isPressedBlue ? 40 : 10)
                    .ignoresSafeArea()
                    .padding(isPressedBlue ? 20 : 10)
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
                            isPressedBlue.toggle()
                            isPressedRed = false
                            isPressedGreen = false
                            
                            closed.toggle()
                        }
                    }
            
            }
                
            
            ZStack{
                Rectangle().fill(.red.opacity(0.5))
                    .frame(width: isPressedRed ? cardWidth : cardWidth * 0.7, height: isPressedRed ? cardHeight : cardHeight * 0.7)
                    .cornerRadius(isPressedRed ? 40 : 10)
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
             
                 
                VStack{
                    Text("Current drag x: \(currentDragOffsetX)") .font(.headline)
                    Text("Starting drag x: \(startingOffsetX)").font(.headline)
                    Text("Ending drag x: \(endingOffsetX)") .font(.headline)
                }
                   
            }
            
            ZStack{
                Rectangle().fill(.green.opacity(0.5))
                    .frame(width: isPressedGreen ? cardWidth : cardWidth * 0.7, height: isPressedGreen ? cardHeight : cardHeight * 0.7)
                    .cornerRadius(isPressedGreen ? 40 : 10)
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





struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
