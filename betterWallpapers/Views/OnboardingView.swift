//
//  Onboarding.swift
//  betterWallpapers
//
//  Created by Artem on 24/12/2022.
//

import SwiftUI
import WebKit

struct Onboarding: View {
    @State private var currentTab = 0
    
    @EnvironmentObject var appState: AppState

    
    var body: some View {
        ZStack{
            Color(red: 0.054, green: 0.093, blue: 0.158).opacity(0.9).ignoresSafeArea()
//            Color.blue.opacity(0.3).ignoresSafeArea()
            TabView(selection: $currentTab,
                    content:  {
                VStack{
                    ZStack{
                        VStack (spacing: 0){
                                Text("Swipe to select wallpaper type")
                                .font(.system(size: 26, design: .rounded))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .padding()

                            GifImage("select")
                                .frame(width: 180, height: 380)
                                .cornerRadius(20)
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
                            Text("Adjust it in your style")
                                .font(.system(size: 26, design: .rounded))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .padding()
                            GifImage("adjust")
                                .frame(width: 180, height: 380)
                                .cornerRadius(20)
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
                            Text("Check preview and tap Save")
                                .font(.system(size: 26, design: .rounded))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .padding()
                            GifImage("save")
                                .frame(width: 180, height: 380)
                                .cornerRadius(20)
                                    .padding()
                                    
                        }
                    }
                    .padding()
                    
                    Button("Get started"){
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
        }
//        .edgesIgnoringSafeArea(.all)
    }
    
    func saveOnboardingStatus(key: String, value: Bool) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
}


struct GifImage: UIViewRepresentable {
    private let name: String

    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.scrollView.isScrollEnabled = false

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }

}
struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
        GifImage("select")
    }
}
