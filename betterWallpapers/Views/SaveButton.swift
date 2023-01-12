//
//  SaveButton.swift
//  betterWallpapers
//
//  Created by Artem on 12/01/2023.
//

import SwiftUI

struct SaveButton: View {
    @State var isPressed = false
    @State var isAnimated = false
    
    var body: some View {
        
        HStack{
            Button {
                withAnimation(){
                    //
                    print("dismissed preview")
                }
            }label: {
                Label("Back to edit", systemImage: "slider.horizontal.3")
            }
            .frame(width: isPressed ? 150: 250, height: 50)
            .background(Color.blue)
                .cornerRadius(40)
                .foregroundColor(.white)
                .padding(.leading)
            
            
           
            Rectangle().fill(isPressed ? .green : .blue)
                .frame(width: isPressed ? 150 : 50, height: 50)
                .cornerRadius(50)
                .overlay(
                    ZStack{
                        HStack(spacing: isPressed ? 10 : 0){
                            Image(systemName: isPressed ? "checkmark" : "square.and.arrow.down")
                                .foregroundColor(.white)
                            Text(isPressed ? "Saved" : "").foregroundColor(.white)
                        }
                    }
                )
                .onTapGesture {
                    withAnimation(.spring()){
                        isPressed.toggle()
                        print("pressed")
                    }
                }
                .onChange(of: isPressed, perform: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.spring()){
                            isPressed = false
                        }
                    }
                })
            
        }
        
        
        
        
    
    }
}

struct SaveButton_Previews: PreviewProvider {
    static var previews: some View {
        SaveButton()
    }
}
