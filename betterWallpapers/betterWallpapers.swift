//
//  BetterWallpapersApp.swift
//  betterWallpapers
//
//  Created by Artem on 14/12/2022.
//

import SwiftUI


@main
struct BetterWallpapers: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(WallpapersViewModel())
                .environmentObject(SliderViewModel())
                .environmentObject(SliderCornerRadius())
                .environmentObject(SliderStartRadius())
                .environmentObject(SliderEndRadius())
        }
    }
}
