//
//  BetterWallpapersApp.swift
//  betterWallpapers
//
//  Created by Artem on 14/12/2022.
//

import SwiftUI


@main
struct BetterWallpapers: App {
    @StateObject var vm = WallpapersViewModel()
    var body: some Scene {
        WindowGroup {
            SelectView()
                .environmentObject(vm)
        }
    }
}
