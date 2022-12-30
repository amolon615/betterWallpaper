//
//  SwiftUIView.swift
//  betterWallpapers
//
//  Created by Artem on 30/12/2022.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State var angle: Angle = Angle(degrees: 120)
    @State var scale: CGFloat = 0
    
    @State var endRadius: CGFloat = 50
    
    var body: some View {
        //LinearGradient
        ZStack{
            Color.blue
                .ignoresSafeArea()
            LinearGradient(gradient: Gradient(colors: [.yellow, .blue]), startPoint: .bottom, endPoint: .top)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .cornerRadius(50)
                .ignoresSafeArea()
                .rotationEffect(angle)
                .scaleEffect(1.0 + scale)
            Rectangle()
                .fill(.white.opacity(0.9))
                .ignoresSafeArea()
                .gesture(
                RotationGesture()
                    .onChanged({ value in
                        angle += value
                    })
                    .onEnded({ value in
                        //
                    })

                )

        }
        
        //radial gradient
//        ZStack{
//            RadialGradient(gradient: Gradient(colors: [.red, .yellow, .orange]), center: .center, startRadius: 10, endRadius: endRadius)
//                .ignoresSafeArea()
//                .gesture(
//                    MagnificationGesture()
//                        .onChanged({ value in
//                            endRadius += value
//                        })
//
//                )
//        }
        
        //Angular gradient
//        ZStack{
//            AngularGradient(colors: [.red, .yellow], center: .center, startAngle: Angle(degrees: 0), endAngle: angle)
//
//                .ignoresSafeArea()
//                .gesture(
//                RotationGesture()
//                    .onChanged({ value in
//                        withAnimation(.spring()){
//
//                                angle += value
//
//
//                        }
//                    })
////
//                )
//        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
