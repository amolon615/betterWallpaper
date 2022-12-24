//
//  Onboarding.swift
//  betterWallpapers
//
//  Created by Artem on 24/12/2022.
//

import SwiftUI

struct Onboarding: View {
    @State private var currentTab = 0
    
    @EnvironmentObject var appState: AppState

    
    var body: some View {
        TabView(selection: $currentTab,
                content:  {
            VStack{
                ZStack{
                    VStack (spacing: 0){
                            Text("Create stunning edges")
                                .font(.largeTitle)
                                .multilineTextAlignment(.center)
                                .padding()
                            Image("edge-solid")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300)
                                .padding()
                                
                    }
                }
                .padding()
                
                Button("Next"){
                    withAnimation{
                        currentTab = 1
                    }
                }
               
                .frame(width: 130, height: 50)
                .background(.blue)
                .cornerRadius(10)
                .padding(50)
                .foregroundColor(.white)
            }
            .frame(width: 300, height: 700)
            .tag(0)
            
            
            VStack{
                ZStack{
                    VStack (spacing: 0){
                        Text("Make them glowing with gradients")
                                .font(.largeTitle)
                                .multilineTextAlignment(.center)
                                .padding()
                        Image("edge-gradient")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300)
                                .padding()
                                
                    }
                }
                .padding()
                
                Button("Next"){
                    withAnimation{
                        currentTab = 2
                    }
                }
               
                .frame(width: 130, height: 50)
                .background(.blue)
                .cornerRadius(10)
                .padding(50)
                .foregroundColor(.white)
            }
            .frame(width: 300, height: 700)
            .tag(1)
            
            
            VStack{
                ZStack{
                    VStack (spacing: 0){
                        Text("Or fill your screen with color or gradient")
                                .font(.largeTitle)
                                .multilineTextAlignment(.center)
                                .padding()
                        Image("fill-gradient")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300)
                                .padding()
                                
                    }
                }
                .padding()
                
                Button("Start creating!"){
                    withAnimation{
                        appState.hasOnboarded = true
                        saveOnboardingStatus(key: "hasOnboarded", value: true)
                    }
                }
               
                .frame(width: 130, height: 50)
                .background(.blue)
                .cornerRadius(10)
                .padding(50)
                .foregroundColor(.white)
            }
            .frame(width: 300, height: 700)
            .tag(2)
        })
        .tabViewStyle(PageTabViewStyle())
        .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .edgesIgnoringSafeArea(.all)
    }
    
    func saveOnboardingStatus(key: String, value: Bool) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
}
struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
