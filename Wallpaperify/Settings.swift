//
//  Settings.swift
//  Wallpaperify
//
//  Created by Artem on 23/12/2022.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        ZStack{
           VStack {
               Spacer()
                ZStack(alignment: .leading) {
                    withAnimation(.easeInOut(duration: 2)) {
                        Button{
                           //
                        }label:{
                            HStack{
                                Image(systemName: "newspaper")
                                    .foregroundColor(.black)
                                    .padding(.leading)
                                Text("Privacy Policy")
                                    .foregroundColor(.black)
                                Spacer()
                            }.foregroundColor(.black)
                        }
                        
                    }   .padding()
                        .frame(width: 350,height: 40)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                   
                }
                ZStack(alignment: .leading) {
                    withAnimation(.easeInOut(duration: 2)) {
                        Button{
                       //
                        }label:{
                            HStack{
                                Image(systemName: "ruler")
                                    .padding(.leading)
                                    .foregroundColor(.black)
                                Text("Terms of Use")
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        
                        }
                        
                    }   .padding()
                        .frame(width: 350,height: 40)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                   
                }
               ZStack(alignment: .leading) {
                   withAnimation(.easeInOut(duration: 2)) {
                       Button{
                          //
                       }label:{
                           HStack{
                               Image(systemName: "star")
                                   .foregroundColor(.black)
                                   .padding(.leading)
                               Text("Rate App")
                                   .foregroundColor(.black)
                               Spacer()
                           }.foregroundColor(.black)
                       }
                       
                   }   .padding()
                       .frame(width: 350,height: 40)
                       .background(.white)
                       .cornerRadius(10)
                       .shadow(radius: 5)
                  
               }
               ZStack(alignment: .leading) {
                   withAnimation(.easeInOut(duration: 2)) {
                       Button{
                      //
                       }label:{
                           HStack{
                               Image(systemName: "paperplane")
                                   .padding(.leading)
                                   .foregroundColor(.black)
                               Text("Send Feedback")
                                   .foregroundColor(.black)
                               Spacer()
                           }
                       
                       }
                       
                   }   .padding()
                       .frame(width: 350,height: 40)
                       .background(.white)
                       .cornerRadius(10)
                       .shadow(radius: 5)
                  
               }
               Spacer()
               Text("(c) Wallpaperify v.1.0")
            }
           
        }
       
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
