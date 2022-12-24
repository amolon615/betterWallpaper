//
//  Settings.swift
//  betterWallpapers
//
//  Created by Artem on 23/12/2022.
//

import SwiftUI
import SafariServices
import StoreKit


struct Settings: View {
    @Environment(\.requestReview) var requestReview
    
    
    @State private var showPP = false
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack{
           VStack {
               Spacer()
                ZStack(alignment: .leading) {
                    withAnimation(.easeInOut(duration: 2)) {
                        Button{
                            showPP.toggle()
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
                            appState.hasOnboarded = false
                            saveOnboardingStatus(key: "hasOnboarded", value: false)
                        }label:{
                            HStack{
                                Image(systemName: "ruler")
                                    .padding(.leading)
                                    .foregroundColor(.black)
                                Text("Reset onboarding")
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
                           requestReview()
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
              
               Spacer()
               Text("(c) betterWallpapers v.1.0")
                   .sheet(isPresented: $showPP){
                       SFSafariViewWrapper(url: URL(string: "https://horovenko.com/betterwallpapers-privacy-policy/")!)
                   }
            }
         
        }
       
    }
    
    struct SFSafariViewWrapper: UIViewControllerRepresentable {
        let url: URL

        func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
            return SFSafariViewController(url: url)
        }

        func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
            return
        }
    }
    
    func saveOnboardingStatus(key: String, value: Bool) {
        UserDefaults.standard.set(value, forKey: key)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
