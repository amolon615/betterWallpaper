//
//  slider.swift
//  betterWallpapers
//
//  Created by Artem on 17/01/2023.
//

import SwiftUI

struct BWSliderCornerRadius: View {
    @EnvironmentObject var vm: WallpapersViewModel
    @EnvironmentObject var scrVM : SliderCornerRadius
    var body: some View {
        VStack{
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(.white.opacity(0.3))
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple ]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: scrVM.sliderWidth, height: 40)
            }.overlay(Text("CORNER RADIUS")
                .foregroundColor(.white))
            .frame(width: scrVM.maxWidth, height: 40 )
                .cornerRadius(35)
                .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        let tranlation = value.translation
                        scrVM.sliderWidth = tranlation.width + scrVM.lastDragValue
                        scrVM.sliderWidth = scrVM.sliderWidth > scrVM.maxWidth ? scrVM.maxWidth : scrVM.sliderWidth
                        scrVM.sliderWidth = scrVM.sliderWidth >= 0 ? scrVM.sliderWidth : 0
                        scrVM.progress = scrVM.sliderWidth / scrVM.maxWidth
                        vm.radiusCorner = scrVM.progress * 100
                        print("corner radius changed \(vm.radiusCorner)")
                    })
                    .onEnded({ value in
                        scrVM.sliderWidth = scrVM.sliderWidth > scrVM.maxWidth ? scrVM.maxWidth : scrVM.sliderWidth
                        scrVM.sliderWidth = scrVM.sliderWidth >= 0 ? scrVM.sliderWidth : 0
                        scrVM.lastDragValue = scrVM.sliderWidth
                    })
                )
        }
               
    }
}


struct BWSliderStrokeWidth: View {
    @EnvironmentObject var vm: WallpapersViewModel
    @EnvironmentObject var sliderVM: SliderViewModel
    var body: some View {
        VStack{
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(.white.opacity(0.3))
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple ]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: sliderVM.widthSliderProgress, height: 40)
            }.overlay(
                Text("STROKE WIDTH")
                .foregroundColor(.white))
            .frame(width: sliderVM.widthMaxWidth, height: 40 )
                .cornerRadius(35)
                .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        let tranlation = value.translation
                        sliderVM.widthSliderProgress = tranlation.width + sliderVM.widthLastDragValue
                        sliderVM.widthSliderProgress = sliderVM.widthSliderProgress > sliderVM.widthMaxWidth ? sliderVM.widthMaxWidth : sliderVM.widthSliderProgress
                        sliderVM.widthSliderProgress = sliderVM.widthSliderProgress >= 0 ? sliderVM.widthSliderProgress : 0
                        sliderVM.widthProgress = sliderVM.widthSliderProgress / sliderVM.widthMaxWidth
                        vm.paddingEdits =  sliderVM.widthProgress * 20
                    })
                    .onEnded({ value in
                        sliderVM.widthSliderProgress = sliderVM.widthSliderProgress > sliderVM.widthMaxWidth ? sliderVM.widthMaxWidth : sliderVM.widthSliderProgress
                        sliderVM.widthSliderProgress = sliderVM.widthSliderProgress >= 0 ? sliderVM.widthSliderProgress : 0
                        sliderVM.widthLastDragValue = sliderVM.widthSliderProgress
                    })
                )

        }
               
    }
}

struct BWSliderStartRadius: View {
    @EnvironmentObject var vm: WallpapersViewModel
    @EnvironmentObject var srVM: SliderStartRadius
    var body: some View {
        VStack{
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(.white.opacity(0.3))
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple ]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: srVM.startSliderWidth, height: 40)

            }.overlay(
                Text(vm.gradientSelected == "Angular" ? "START ANGLE" : "START RADIUS")
                    .foregroundColor(.white)
            )
            .frame(width: srVM.startMaxWidth, height: 40 )
                .cornerRadius(35)
                .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        let tranlation = value.translation
                        srVM.startSliderWidth = tranlation.width + srVM.startLastDragValue
                        srVM.startSliderWidth =  srVM.startSliderWidth > srVM.startMaxWidth ? srVM.startMaxWidth :  srVM.startSliderWidth
                        srVM.startSliderWidth =  srVM.startSliderWidth >= 0 ?  srVM.startSliderWidth : 0
                        srVM.startProgress =  srVM.startSliderWidth / srVM.startMaxWidth
                        vm.startRadius = srVM.startProgress * 400
                    })
                    .onEnded({ value in
                        srVM.startSliderWidth =  srVM.startSliderWidth > srVM.startMaxWidth ? srVM.startMaxWidth :  srVM.startSliderWidth
                        srVM.startSliderWidth =  srVM.startSliderWidth >= 0 ?  srVM.startSliderWidth : 0
                        srVM.startLastDragValue =  srVM.startSliderWidth
                    })
                )
                
//            VStack{
//                Text("slider progress is \(srVM.startSliderWidth)")
//                Text("slider width is \(srVM.startSliderWidth)")
//                Text("lastdrag value is \(srVM.startLastDragValue)")
//                Text("MaxWidth is \(srVM.startMaxWidth)")
//                Text("Progress is \(srVM.startProgress)")
//                Text("start radius is \(vm.startRadius)")
//            }
        }
               
    }
}

struct BWSliderEndRadius: View {
    @EnvironmentObject var vm: WallpapersViewModel
    @EnvironmentObject var erVM: SliderEndRadius
    var body: some View {
        VStack{
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(.white.opacity(0.3))
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple ]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: erVM.endsliderWidth, height: 40)
            }.overlay(Text(vm.gradientSelected == "Angular" ? "END ANGLE" : "END RADIUS")
                .foregroundColor(.white))
            .frame(width: erVM.endmaxWidth, height: 40 )
                .cornerRadius(35)
                .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        let tranlation = value.translation
                        erVM.endsliderWidth = tranlation.width + erVM.endlastDragValue
                        erVM.endsliderWidth =    erVM.endsliderWidth > erVM.endmaxWidth ? erVM.endmaxWidth :    erVM.endsliderWidth
                        erVM.endsliderWidth =    erVM.endsliderWidth >= 0 ?    erVM.endsliderWidth : 0
                        erVM.endprogress =    erVM.endsliderWidth / erVM.endmaxWidth
                        vm.endRadius =  erVM.endprogress * 400
                    })
                    .onEnded({ value in
                        erVM.endsliderWidth =    erVM.endsliderWidth > erVM.endmaxWidth ? erVM.endmaxWidth : erVM.endsliderWidth
                        erVM.endsliderWidth =    erVM.endsliderWidth >= 0 ?    erVM.endsliderWidth : 0
                        erVM.endlastDragValue = erVM.endsliderWidth
                    })
                
                )
//
//            VStack{
//                Text("slider width is \(erVM.endsliderWidth)")
//                Text("lastdrag value is \(erVM.endlastDragValue)")
//                Text("MaxWidth is \(erVM.endmaxWidth)")
//                Text("Progress is \( erVM.endprogress)")
//                Text("End radius is \(vm.endRadius)")
//            }
        }
               
    }
}

struct slider_Previews: PreviewProvider {
    static var previews: some View {
        BWSliderCornerRadius().environmentObject(WallpapersViewModel())
        BWSliderStrokeWidth().environmentObject(WallpapersViewModel()).environmentObject(SliderViewModel())
        BWSliderStartRadius().environmentObject(WallpapersViewModel()).environmentObject(SliderStartRadius())
        BWSliderEndRadius().environmentObject(WallpapersViewModel()).environmentObject(SliderEndRadius())
    }
}



