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
    @EnvironmentObject var vm: WallpapersViewModel
    
    @State private var showPP = false
    @State private var showTT = false
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack{
            Color(red: 0.054, green: 0.093, blue: 0.158).ignoresSafeArea()
            Image("mesh")
           VStack {
               Spacer()
                ZStack(alignment: .leading) {
                    withAnimation(.easeInOut(duration: 2)) {
                        Button{
                            showPP.toggle()
                        }label:{
                            HStack{
                                Image(systemName: "hand.raised")
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
//                ZStack(alignment: .leading) {
//                    withAnimation(.easeInOut(duration: 2)) {
//                        Button{
//                            appState.hasOnboarded = false
//                            saveOnboardingStatus(key: "hasOnboarded", value: false)
//                        }label:{
//                            HStack{
//                                Image(systemName: "arrow.counterclockwise")
//                                    .padding(.leading)
//                                    .foregroundColor(.black)
//                                Text("Reset onboarding")
//                                    .foregroundColor(.black)
//                                Spacer()
//                            }
//
//                        }
//
//                    }   .padding()
//                        .frame(width: 350,height: 40)
//                        .background(.white)
//                        .cornerRadius(10)
//                        .shadow(radius: 5)
//
//                }
               ZStack(alignment: .leading) {
                   withAnimation(.easeInOut(duration: 2)) {
                       Button{
                           showTT.toggle()
                       }label:{
                           HStack(spacing: 0){
//                               Image(systemName: "person.crop.circle.fill.badge.plus")
                               Image("twitter")
                                   .resizable()
                                   .scaledToFit()
                                   .cornerRadius(30)
                                   .frame(width: 30, height: 30)
                                   .foregroundColor(.black)
                                   .padding(.leading, 10)
                                  
                               Text("Follow me on Twitter")
                                   .foregroundColor(.black)
                               Spacer()
                           }.foregroundColor(.black)
                       }
                       .fullScreenCover(isPresented: $showTT){
                           SFSafariViewWrapper(url: URL(string: "https://twitter.com/amolon210")!)
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
               VStack{
                   HStack{
                       Image("logo")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 20, height: 20)
                           
                       Text("betterWallpapers")
                           .foregroundColor(.white)
                           .font(.system(size: 12))
                           .font(.system(.body, design: .rounded))
                           
                   }
                   HStack{
                       Text("v1.5.1")
                           .foregroundColor(.white)
                           .font(.caption)
                   }
               }
                   .sheet(isPresented: $showPP){
                       SFSafariViewWrapper(url: URL(string: "https://horovenko.com/betterwallpapers-privacy-policy/")!)
                   }
            }
         
        }
        .overlay(
            VStack{
                HStack{
                    Spacer()
                    Button {
                        withAnimation(.spring()){
                            vm.isShowingSettings = false
                        }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 40))
                            .shadow(radius: 10)
                            .foregroundColor(.white)
                    }
                  
                }.padding(.horizontal)
                    .padding(.trailing, 30)
                Spacer()
            }
        )
       
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
        Settings().environmentObject(WallpapersViewModel())
    }
}
