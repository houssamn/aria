//
//  ViewController.swift
//  aria
//
//  Created by Houssam on 3/21/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Start the view's AR session with a configuration that uses the rear camera,
        // device position and orientation tracking, and plane detection.
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        sceneView.session.run(configuration)

        // Set a delegate to track the number of plane anchors for providing UI feedback.
        sceneView.session.delegate = self
        
        // Prevent the screen from being dimmed after a while as users will likely
        // have long periods of interaction without touching the screen or buttons.
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Show debug UI to view performance metrics (e.g. frames per second).
        sceneView.showsStatistics = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self

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
    
    /// - Tag: PlaceARContent
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Place content only for anchors found by plane detection.
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // Create a custom object to visualize the plane geometry and extent.
        //let plane = Plane(anchor: planeAnchor, in: sceneView)
        
        // Add the visualization to the ARKit-managed node so that it tracks
        // changes in the plane anchor as plane estimation continues.
        // node.addChildNode(plane)
        
        print("Added a Plane ")
    }
    
    /// - Tag: UpdateARContent
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // Update only anchors and nodes set up by `renderer(_:didAdd:for:)`.
//        guard let planeAnchor = anchor as? ARPlaneAnchor,
//            let plane = node.childNodes.first as? Plane
//            else { return }
//
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        print("Updating a plane anchor ")
        // Update ARSCNPlaneGeometry to the anchor's new estimated shape.
//        if let planeGeometry = plane.meshNode.geometry as? ARSCNPlaneGeometry {
//            planeGeometry.update(from: planeAnchor.geometry)
//        }

//        // Update extent visualization to the anchor's new bounding rectangle.
//        if let extentGeometry = plane.extentNode.geometry as? SCNPlane {
//            extentGeometry.width = CGFloat(planeAnchor.extent.x)
//            extentGeometry.height = CGFloat(planeAnchor.extent.z)
//            plane.extentNode.simdPosition = planeAnchor.center
//        }
//
//        // Update the plane's classification and the text position
//        if #available(iOS 12.0, *),
//            let classificationNode = plane.classificationNode,
//            let classificationGeometry = classificationNode.geometry as? SCNText {
//            let currentClassification = planeAnchor.classification.description
//            if let oldClassification = classificationGeometry.string as? String, oldClassification != currentClassification {
//                classificationGeometry.string = currentClassification
//                classificationNode.centerAlign()
//            }
//        }
        
    }
    
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
