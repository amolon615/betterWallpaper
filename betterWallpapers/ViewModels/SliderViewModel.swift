//
//  SliderViewModel.swift
//  betterWallpapers
//
//  Created by Artem on 17/01/2023.


import SwiftUI


class SliderCornerRadius: ObservableObject{
    @Published var maxWidth: CGFloat = UIScreen.main.bounds.width * 0.8
    @Published var sliderProgress: CGFloat = 0.43
    @Published var sliderWidth: CGFloat = 138
    @Published var lastDragValue: CGFloat = 138
    @Published var progress: CGFloat = 0.43
}


class SliderViewModel: ObservableObject {
    @Published var widthMaxWidth: CGFloat = UIScreen.main.bounds.width * 0.8
    @Published var widthSliderProgress: CGFloat = 99.33
    @Published var widthSliderWidth: CGFloat = 138
    @Published var widthLastDragValue: CGFloat = 99.3
    @Published var widthProgress: CGFloat = 0.31
}

class SliderStartRadius: ObservableObject {
    @Published var startMaxWidth: CGFloat = UIScreen.main.bounds.width * 0.8
    @Published var startSliderProgress: CGFloat = 169
    @Published var startSliderWidth: CGFloat = 169
    @Published var startLastDragValue: CGFloat = 169
    @Published var startProgress: CGFloat = 0.53
}

class SliderEndRadius: ObservableObject {
    @Published var endmaxWidth: CGFloat = UIScreen.main.bounds.width * 0.8
    @Published var endsliderProgress: CGFloat = 222
    @Published var endsliderWidth: CGFloat = 222
    @Published var endlastDragValue: CGFloat = 222
    @Published var endprogress: CGFloat = 0.7
}
