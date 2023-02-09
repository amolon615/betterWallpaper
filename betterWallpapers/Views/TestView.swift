//
//  TestView.swift
//  betterWallpapers
//
//  Created by Artem on 08/02/2023.
//

import SwiftUI

struct TestView: View {
        @State var start = UnitPoint(x: 0, y: -2)
       @State var end = UnitPoint(x: 4, y: 0)
       
    
       
       var body: some View {
           
           ZStack{
               Circle()
                   .fill(.blue)
                   .frame(width: 100)
           }
       }
}

struct TestView_Preview: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
