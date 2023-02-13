//
//  WallpaperModel.swift
//  betterWallpapers
//
//  Created by Artem on 12/02/2023.
//

import SwiftUI



struct WallpaperModel: Identifiable {
    var id: Int
    var title: String
    var wallpaperView: AnyView
    static let wallpapers: [WallpaperModel] = [
        WallpaperModel(id: 1, title: "border_linear_gradient", wallpaperView: AnyView(StrokeLinearGradientView())),
        WallpaperModel(id: 2, title: "border_radial_gradient", wallpaperView: AnyView(StrokeRadialGradientView())),
        WallpaperModel(id: 3, title: "border_angular_gradient", wallpaperView: AnyView(StrokeAngularGradientView())),
        WallpaperModel(id: 4, title: "border_solid", wallpaperView: AnyView(StrokeSolidFillView())),
        WallpaperModel(id: 5, title: "fill_linear_gradient", wallpaperView: AnyView(FilledGradientView())),
        WallpaperModel(id: 6, title: "fill_radial_gradient", wallpaperView: AnyView(FilledRadialGradientView())),
        WallpaperModel(id: 7, title: "fill_angular_gradient", wallpaperView: AnyView(FilledAngularGradientView()))
    ]
}
