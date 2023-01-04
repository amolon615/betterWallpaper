//
//  SwiftUIView.swift
//  betterWallpapers
//
//  Created by Artem on 04/01/2023.
//

import SwiftUI

struct SwiftUIView: View {
    @EnvironmentObject var vm: WallpapersViewModel
    
    @State var cardWidth = UIScreen.main.bounds.width
    @State var cardHeight = UIScreen.main.bounds.height
    
    @State var isPressed = false
    @State var isPressed2 = false
    @State var isPressed3 = false
    @State var isPressed4 = false
    @State var isPressed5 = false
    @State var isPressed6 = false
    @State var expand = false
    
    @State var offset: CGSize = .zero
    
    var body: some View {
        GeometryReader{ geo in
                HStack{
                    VStack{
                        StrokeSolidFillView()
                        
                            .frame(width: isPressed2 ? cardWidth : cardWidth * 0.7, height: isPressed2 ? cardHeight : cardHeight * 0.7)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .padding(isPressed2 ? 0 : 20)
                            .onTapGesture {
                                withAnimation {
                                    isPressed2.toggle()
                                    isPressed = false
                                    isPressed3 = false
                                    isPressed4 = false
                                    isPressed5 = false
                                    isPressed6 = false
                                    expand.toggle()
                                    
                                    
                                }
                            }
                    }
                    
                    
                    VStack{
                        StrokeGradientView()
                        
                            .frame(width: isPressed3 ? cardWidth : cardWidth * 0.7, height: isPressed3 ? cardHeight : cardHeight * 0.7)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .padding(isPressed3 ? 0 : 20)
                            .onTapGesture {
                                withAnimation {
                                    isPressed3.toggle()
                                    isPressed = false
                                    isPressed2 = false
                                    isPressed4 = false
                                    isPressed5 = false
                                    isPressed6 = false
                                    expand.toggle()
                                   
                                }
                            }
                    }
                    VStack{
                        FilledView()
                            .frame(width: isPressed4 ? cardWidth: cardWidth * 0.7, height: isPressed4 ? cardHeight : cardHeight * 0.7)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .padding(isPressed4 ? 0 : 20)
                            .onTapGesture {
                                withAnimation {
                                    isPressed4.toggle()
                                    isPressed = false
                                    isPressed2 = false
                                    isPressed3 = false
                                    isPressed5 = false
                                    isPressed6 = false
                                    expand.toggle()
                                  
                                }
                            }
                    }
                    VStack{
                        FilledSolidView()
                            .frame(width: isPressed5 ? cardWidth: cardWidth * 0.7, height: isPressed5 ? cardHeight : cardHeight * 0.7)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .padding(isPressed5 ? 0 : 20)
                            .onTapGesture {
                                withAnimation {
                                    isPressed5.toggle()
                                    isPressed = false
                                    isPressed2 = false
                                    isPressed3 = false
                                    isPressed4 = false
                                    isPressed6 = false
                                    expand.toggle()
                                    
                                    print("Global center: \(geo.frame(in: .global).minX) x \(geo.frame(in: .global).minY)")
                                    print("Custom center: \(geo.frame(in: .named("custom")).minX) x \(geo.frame(in: .named("custom")).minY)")
                                    print("Local center: \(geo.frame(in: .local).minX) x \(geo.frame(in: .local).minY)")
                                    
                                }
                            }
                    }
                    
                    
                }.frame(maxWidth: cardWidth * 4).background(Color.green)
                .frame(width: cardWidth, height: cardHeight)
                .offset(x: offset.width, y: 0)
                .onTapGesture {
                    print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).minY)")
                    print("Custom center: \(geo.frame(in: .named("custom")).midX) x \(geo.frame(in: .named("custom")).midY)")
                    print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                }
                .ignoresSafeArea()
//                .offset(x: expand ? geo.frame(in: .local).minX : 0, y: expand ? geo.frame(in: .local).minY : 0)
//                .position(x: expand ? geo.frame(in: .local).minX : 0, y: expand ? geo.frame(in: .local).minY : 0)
                .simultaneousGesture(DragGesture(minimumDistance: expand ? 0 : 300).onChanged({ (_) in
                    print("dragging")
                }))
                .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        withAnimation(.spring()){
                                            self.offset.width = value.translation.width
                                        }
                                    }
                                    .onEnded { value in
                                        withAnimation(.spring()){
                                            if value.predictedEndTranslation.width > (cardWidth * 0.5) {
                                                self.offset.width +=  cardWidth
                                            } else if value.predictedEndTranslation.width < -(cardWidth * 0.7) {
                                                self.offset.width -= cardWidth
                                            } else {
                                                self.offset.width = 0
                                            }
                                        }
                                    }
                            )

        }
       
    
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
