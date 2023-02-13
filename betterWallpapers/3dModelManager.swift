//
//  3dModelManager.swift
//  betterWallpapers
//
//  Created by Artem on 12/02/2023.
//

import SwiftUI
import SceneKit

struct Model: Identifiable {
    var id : Int
    var name : String
    var modelName : String
    var details : String
}


//struct CustomSceneView: UIViewRepresentable {
//
//    @Binding var scene: SCNScene?
//
//    func makeUIView(context: Context) -> SCNView {
//        let view = SCNView()
//        view.allowsCameraControl = false
//        view.autoenablesDefaultLighting = true
//        view.antialiasingMode = .multisampling2X
//        view.scene = scene
//        view.backgroundColor = .clear
//        return view
//    }
//
//    func updateUIView(_ uiView: SCNView, context: Context) {
//
//    }
//}


struct WrappedSceneView: UIViewRepresentable {

    @Binding var isScreenShot: Bool
    @Binding var uiImg: UIImage?
     var sceneName: String?
    var allowControl: Bool = false

    typealias UIViewType = SCNView
    
    func makeUIView(context: Context) -> SCNView {
        
        let scene = SCNScene(named: sceneName ?? "Blob.usdz")
        let scnView = SCNView()
        scnView.allowsCameraControl = false
        scnView.autoenablesDefaultLighting = true
        scnView.antialiasingMode = .multisampling2X
        scnView.backgroundColor = .clear
        scnView.scene = scene

        // 2: Add camera node
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        // 3: Place camera
        cameraNode.position = SCNVector3(x: 0, y: 10, z: 35)
        // 4: Set camera on scene
//        scene.rootNode.addChildNode(cameraNode)
        
        // 5: Adding light to scene
//        let lightNode = SCNNode()
//        lightNode.light = SCNLight()
//        lightNode.light?.type = .omni
//        lightNode.position = SCNVector3(x: 0, y: 10, z: 35)
//        scene?.rootNode.addChildNode(lightNode)
//
        // 6: Creating and adding ambient light to scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.blue
        scene?.rootNode.addChildNode(ambientLightNode)
        
        // Allow user to manipulate camera
        scnView.allowsCameraControl = allowControl
        
        // Show FPS logs and timming
        // sceneView.showsStatistics = true
        
        // Set background color
        scnView.backgroundColor = UIColor.white
        
        // Allow user translate image
        scnView.cameraControlConfiguration.allowsTranslation = false
        
        // Set scene settings
        scnView.scene = scene
        
        return scnView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        if isScreenShot {
            // スクリーンショット保存
            DispatchQueue.main.async {
                self.uiImg = uiView.snapshot()
                self.isScreenShot = false
            }
        }
    }
}

struct CustomSceneView: UIViewRepresentable {

    @Binding var scene: SCNScene?

    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = false
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.scene = scene
        view.backgroundColor = .clear
        view.snapshot()
        print("made a snapshot")
        return view
    }

    func updateUIView(_ uiView: SCNView, context: Context) {

    }
}

    




//class ModelControl: ObservableObject {
//    @Published var scaleY: Float = 1
//    @Published var posY: Float = 1
//    @Published var posYLeaves: Float = 60
//
//    @Published var scene: SCNScene? = .init(named: "Cubes.usdz")
//
//}

