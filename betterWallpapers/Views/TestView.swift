//
//  TestView.swift
//  betterWallpapers
//
//  Created by Artem on 08/02/2023.
//

import SwiftUI
import SceneKit




struct ColorView: View {
    @Environment(\.dismiss) var dismiss
    var wallpaper: WallpaperModel? = nil
    @EnvironmentObject var vm: WallpapersViewModel
    @EnvironmentObject var sliderVM: SliderViewModel
    @EnvironmentObject var scrVM : SliderCornerRadius
    @State var showEditor: Bool = false
    
    @ViewBuilder
    func fetchView() -> some View {
        switch wallpaper?.title {
        case "border_linear_gradient":
             StrokeLinearGradientView()
        case "border_radial_gradient":
             StrokeRadialGradientView()
        case  "border_angular_gradient":
            StrokeAngularGradientView()
        case "border_solid":
           StrokeSolidFillView()
        case "fill_linear_gradient":
          FilledGradientView()
        case "fill_radial_gradient":
           FilledRadialGradientView()
        default:
            FilledAngularGradientView()
        }
   }
    
    @ViewBuilder
    func getEditors() -> some View {
        switch wallpaper?.title {
        case "border_linear_gradient":
          LinearBorderEditor()
        case "border_radial_gradient":
           RadialBorderEditor()
        case  "border_angular_gradient":
           AngularBorderEditor()
        case "border_solid":
            LinearFillEditor()
        case "fill_linear_gradient":
            LinearFillEditor()
        case "fill_radial_gradient":
           RadialFillEditor()
        default:
           AngularFillEditor()
             
        }
   }
    

    var body: some View {
        ZStack{
            fetchView()
            VStack{
                Text(wallpaper?.title ?? "default")
                Button{
                    dismiss()
                } label: {
                    Text("Dismiss!")
                        .foregroundColor(.white)
                        .background(.black)
                }
                Button {
                    vm.Save(view: fetchView())
                } label: {
                    Text("Save wallpaper")
                }
                Button {
                    self.showEditor = true
                } label: {
                    Text("show editor")
                        .foregroundColor(.white)
                }
                .sheet(isPresented: $showEditor) {

                        getEditors()

                }
            }
        }
    }
}


struct ObjectView: View {
    @Environment(\.dismiss) var dismiss
    var objectModel: ObjectModel? = nil
    @EnvironmentObject var vm: WallpapersViewModel
    @State var showEditor: Bool = false
    
    @ViewBuilder
    func fetchView() -> some View {
        switch objectModel?.name {
        case "Cubes":
            WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: "Cubes.usdz", allowControl: true).ignoresSafeArea()
        case "Mondrian":
            WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: "Mondrian.usdz", allowControl: true).ignoresSafeArea()
        case  "Lazers":
            WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: "Lazers.usdz", allowControl: true).ignoresSafeArea()
        case "Ball":
            WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: "Ball.usdz", allowControl: true).ignoresSafeArea()
        case "Blob":
            WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: "Blob.usdz", allowControl: true).ignoresSafeArea()
        case "Swirl":
            WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: "Swirl.usdz", allowControl: true).ignoresSafeArea()
        case "Abstract_Cube":
            WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: "Abstract_Cube.usdz", allowControl: true).ignoresSafeArea()
        case "Green_Bananas":
            WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: "Green_Bananas.usdz", allowControl: true).ignoresSafeArea()
        case "Abstract_Art":
            WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: "Abstract_Art.usdz", allowControl: true).ignoresSafeArea()
        default:
            WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: "Mega_Swirl.usdz", allowControl: true).ignoresSafeArea()
        }
   }
    

    @State var isScreenShot: Bool = false
    @State var uiImg: UIImage? = nil

    var body: some View {
        ZStack{
            fetchView()
            VStack{
                Button{
                    dismiss()
                } label: {
                    Text("Dismiss!")
                        .foregroundColor(.white)
                        .background(.black)
                }
                Button {
                        self.isScreenShot = true
                        if let savedImage = self.uiImg {
                            UIImageWriteToSavedPhotosAlbum(savedImage, nil, nil, nil)
                            print("image saved")
                        }
                } label: {
                    Text("Save wallpaper")
                }
            }
        }
    }
}


struct TestView: View {

        @EnvironmentObject var vm: WallpapersViewModel
    
        @State var showWallpaper: Bool = false
        @State var showSettings: Bool = false
        @State private var navPath = NavigationPath()
        @State var showCover: Int? = nil
        @State var wallpaperModel: WallpaperModel? = nil
        @State var objectModel: ObjectModel? = nil
    
        @State var isScreenShot: Bool = false
        @State var uiImg: UIImage? = nil
    
    
       var body: some View {
           NavigationStack(path: $navPath){
               ScrollView{
                   
                   Section{
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack{
                               ForEach(WallpaperModel.wallpapers){wallpaper in
                                   wallpaper.wallpaperView
                                       .frame(width: 250, height: 350)
                                       .cornerRadius(43)
                                       .onTapGesture {
                                           wallpaperModel = wallpaper
                                       }
                                       
                               }
                               .fullScreenCover(item: $wallpaperModel) { item in
                                   ColorView(wallpaper: item)
                               }
                           }
                       }
                   } header: {
                       Text("Gradient Edges & Fills")
                   }
                   
                   Section{
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack{
                               ForEach(ObjectModel.objectModels){model in
                                   WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: model.modelName)
                                       .frame(width: 250, height: 350)
                                       .cornerRadius(43)
                                       .onTapGesture {
                                           objectModel = model
                                       }
                                  
                                       
                               }
                               .fullScreenCover(item: $objectModel) { item in
                                   ObjectView(objectModel: item)
                               }
                           }
                       }
                   } header: {
                       Text("3d Models")
                   }
                   Section{
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack{
                               ForEach(ObjectModel.objectModels){model in
                                   WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: model.modelName)
                                       .frame(width: 250, height: 350)
                                       .cornerRadius(43)
                                  
                                       
                               }
                               .fullScreenCover(item: $wallpaperModel) { item in
                                   ColorView(wallpaper: item)
                               }
                           }
                       }
                   } header: {
                       Text("Red")
                   }
                   Section{
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack{
                               ForEach(1...10, id:\.self){_ in
                                   ObjectModelView()
//                                   Rectangle()
//                                       .fill(.purple)
//                                       .frame(width: 150, height: 200)
//                                       .cornerRadius(10)
                               }
                               
                           }
                       }
                   } header: {
                       Text("Purple")
                   }
                   Section{
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack{
                               ForEach(1...10, id:\.self){_ in
//                                   Rectangle()
//                                       .fill(.pink)
//                                       .frame(width: 150, height: 200)
//                                       .cornerRadius(10)
                                   ObjectModelView()
                               }
                               
                           }
                       }
                   } header: {
                       Text("Pink")
                   }
               }
           }  .navigationDestination(for: Int.self) { i in
               VStack {
                   Text("Detail \(i)")
               }
           }
          

       }
}

struct TestView_Preview: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(WallpapersViewModel())
            .environmentObject(SliderViewModel())
            .environmentObject(SliderCornerRadius())
            .environmentObject(SliderStartRadius())
            .environmentObject(SliderEndRadius())
    }
}
