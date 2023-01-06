//
//  SwiftUIView.swift
//  betterWallpapers
//
//  Created by Artem on 04/01/2023.
//

import SwiftUI

struct SwiftUIView: View {
    @State var showed = false
    var body: some View {
        HStack(spacing: 20){
            ZStack{
                Color.blue
                    .frame(width: 250, height: 400)
                    .onTapGesture {
                        withAnimation(){
                            showed.toggle()
                        }
                    }
                Color.red
                    .frame(width: showed ? 0 : 70, height: showed ? 0 : 70)
                
            }
            ZStack{
                Color.blue
                    .frame(width: 250, height: 400)
                    .onTapGesture {
                        withAnimation(){
                            showed.toggle()
                        }
                    }
                Color.green
                    .frame(width: 100, height: 100)
                Color.red
                    .frame(width: showed ? 0 : 70, height: showed ? 0 : 70)
                    .onTapGesture {
                        print("red tapped")
                    }
            }
            ZStack{
                Color.blue
                    .frame(width: 250, height: 400)
                Color.red
                    .frame(width: 70, height: 70)
            }
        }
    
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView().environmentObject(WallpapersViewModel())
    }
}
