//
//  ARSceneController.swift
//  ARGeoTracker
//
//  Created by Артем Стратиенко on 01/10/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit
import NMAKit
import Foundation

class ARSceneController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ARGeoScene.scn")!
        // Set the scene to the view
        sceneView.scene = scene
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        // Run the view's session
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
        showShape()
        sceneView.session.run(configuration)
        
    }
   func showShape() {
    let text = SCNText(string: "Школа", extrusionDepth: 1)
    let material = SCNMaterial()
    material.diffuse.contents = UIColor.orange
    text.materials = [material]
    let node = SCNNode()
    node.position = SCNVector3(0,2, 2)
    node.scale = SCNVector3(0.01, 0.01, 0.01)
    node.geometry = text
    node.name = "shape"
    sceneView.scene.rootNode.addChildNode(node)
     }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    // MARK: - ARSCNViewDelegate
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()

     return node
     }
     */
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
}
