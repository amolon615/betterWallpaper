//
//  3dView.swift
//  betterWallpapers
//
//  Created by Artem on 12/02/2023.
//

import SwiftUI
import SceneKit



struct ObjectModel: Identifiable {
    var id: Int
    var name: String
    var modelName: String
    
    static let objectModels = [
        ObjectModel(id: 0, name: "Cubes", modelName: "Cubes.usdz"),
        ObjectModel(id: 1, name: "Mondrian", modelName: "Mondrian.usdz"),
        ObjectModel(id: 2, name: "Lazers", modelName: "Lazers.usdz"),
        ObjectModel(id: 3, name: "Ball", modelName: "Ball.usdz"),
        ObjectModel(id: 4, name: "Blob", modelName: "Blob.usdz"),
        ObjectModel(id: 5, name: "Swirl", modelName: "Swirl.usdz"),
        ObjectModel(id: 6, name: "Abstract_Cube", modelName: "Abstract_Cube.usdz"),
        ObjectModel(id: 7, name: "Green_Bananas", modelName: "Green_Bananas.usdz"),
        ObjectModel(id: 8, name: "Abstract_Art", modelName: "Abstract_Art.usdz"),
        ObjectModel(id: 9, name: "Mega_Swirl", modelName: "Mega_Swirl.usdz")
    ]
    
}

struct TestModelView: View {
    @EnvironmentObject var vmMain: WallpapersViewModel
  
    @State var isScreenShot: Bool = false
    @State var uiImg: UIImage? = nil
    
    var body: some View {
        ZStack{
            WrappedSceneView(isScreenShot: self.$isScreenShot, uiImg: self.$uiImg, sceneName: "Blob.usdz").ignoresSafeArea()
        }.overlay(
            VStack{
                Spacer()
                Button {
                self.isScreenShot = true
                    if let savedImage = self.uiImg {
                        UIImageWriteToSavedPhotosAlbum(savedImage, nil, nil, nil)
                        print("image saved")
                    }
                } label: {
                    Text("Save")
                }
            }
        )
    }
}


struct ObjectModelView: View {
    @EnvironmentObject var vmMain: WallpapersViewModel
    var body: some View {
            ZStack{
                SceneView(scene: SCNScene(named: ObjectModel.objectModels[0].modelName), options: [.allowsCameraControl, .autoenablesDefaultLighting])
            }
    }
}

struct _dView_Previews: PreviewProvider {
    static var previews: some View {
        ObjectModelView()
            .environmentObject(WallpapersViewModel())
    }
}
