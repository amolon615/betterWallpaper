//
//  BetterWallpapersApp.swift
//  betterWallpapers
//
//  Created by Artem on 14/12/2022.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency

@main
struct BetterWallpapers: App {

    @Environment(\.scenePhase) private var scenePhase

    var ad = OpenAd()
    
    var body: some Scene {
        WindowGroup {
            TestView()
                .environmentObject(WallpapersViewModel())
                .environmentObject(SliderViewModel())
                .environmentObject(SliderCornerRadius())
                .environmentObject(SliderStartRadius())
                .environmentObject(SliderEndRadius())
        }
        .onChange(of: scenePhase) { phase in
                  if phase == .active {
                     ad.tryToPresentAd()
                      }
                  
            }
    }
}
