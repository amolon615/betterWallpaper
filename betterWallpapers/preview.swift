//
//  preview.swift
//  betterWallpapers
//
//  Created by Artem on 06/01/2023.
//

import SwiftUI

struct preview: View {
    var body: some View{
        VStack{
            //title
            HStack{
                
            }
            //preview screen
            HStack{
                //lockscreen preview
                ZStack{
                    
                    FilledGradientView()
                }
                //homescreen preview
                ZStack{
                    
                    FilledGradientView()
                }
            }
            //bottom buttons menu
            HStack{
                
            }
        }
    }
}



struct preview_Previews: PreviewProvider {
    static var previews: some View {
        preview()
    }
}



