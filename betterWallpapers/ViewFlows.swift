//
//  ViewFlows.swift
//  betterWallpapers
//
//  Created by Artem on 24/12/2022.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var hasOnboarded: Bool
    

    init(hasOnboarded: Bool) {
        self.hasOnboarded = hasOnboarded
      
    }
}

struct ViewFlows: View {
    @StateObject var appState = AppState(hasOnboarded: false)
    @EnvironmentObject var vm: WallpapersViewModel
    
    var body: some View {
        
        if let onboardingStatus = loadBool(key: "hasOnboarded"){
            if onboardingStatus{
                ContentView()
                    .environmentObject(appState)
                   
            } else {
                Onboarding()
                    .environmentObject(appState)
            }
        }
    }
    
    func loadBool(key: String) -> Bool? {
        return UserDefaults.standard.bool(forKey: key)
    }
}

struct ViewFlows_Previews: PreviewProvider {
    static var previews: some View {
        ViewFlows()
    }
}
