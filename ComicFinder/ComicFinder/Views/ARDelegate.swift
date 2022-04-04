//
//  ComicARView.swift
//  ComicFinder
//
//  Created by Brian Carey on 4/3/22.
//

import SwiftUI
import Foundation
import ARKit
import UIKit

class ARDelegate: NSObject, ARSCNViewDelegate, ObservableObject {
    public var imageURL: URL
    
    init(savedURL comicImageURL: URL){
        imageURL = comicImageURL
    }
    
    func setARView(_ arView: ARSCNView) {
        self.arView = arView
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration)
        
        arView.delegate = self
        arView.scene = SCNScene()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnARView))
        arView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panOnARView))
        arView.addGestureRecognizer(panGesture)
    }
    
    @objc func panOnARView(sender: UIPanGestureRecognizer) {
        guard let arView = arView else { return }
        let location = sender.location(in: arView)
        switch sender.state {
        case .began:
            if let node = nodeAtLocation(location) {
                trackedNode = node
            }
        case .changed:
            if let node = trackedNode {
                if let result = raycastResult(fromLocation: location) {
                    moveNode(node, raycastResult:result)
                }
            }
        default:
            ()
        }
    }
    
    @objc func tapOnARView(sender: UITapGestureRecognizer) {
        guard let arView = arView else { return }
        let location = sender.location(in: arView)
        if let result = raycastResult(fromLocation: location) {
            addComic(raycastResult: result)
        }
    }
    
    private var arView: ARSCNView?
    private var arComics:[SCNNode] = []
    private var trackedNode:SCNNode?
    
    private func addComic(raycastResult: ARRaycastResult) {
        //width and height set to usual comic book cover aspect ratio
        let planeGeometry = SCNPlane(width: 0.197, height: 0.267)
        let material = SCNMaterial()
        let data = try? Data(contentsOf: imageURL)
        material.diffuse.contents = UIImage(data: data!)
        planeGeometry.materials = [material]
        
        let comicNode = SCNNode(geometry: planeGeometry)
        comicNode.transform = SCNMatrix4(raycastResult.worldTransform)
        comicNode.eulerAngles = SCNVector3(comicNode.eulerAngles.x + (-Float.pi / 2), comicNode.eulerAngles.y, comicNode.eulerAngles.z)
        comicNode.position = SCNVector3(raycastResult.worldTransform.columns.3.x, raycastResult.worldTransform.columns.3.y, raycastResult.worldTransform.columns.3.z)
        
        arView?.scene.rootNode.addChildNode(comicNode)
        arComics.append(comicNode)
    }
    
    private func moveNode(_ node:SCNNode, raycastResult:ARRaycastResult) {
        node.simdWorldTransform = raycastResult.worldTransform
    }
    
    private func nodeAtLocation(_ location:CGPoint) -> SCNNode? {
        guard let arView = arView else { return nil }
        let result = arView.hitTest(location, options: nil)
        return result.first?.node
    }
    
    private func raycastResult(fromLocation location: CGPoint) -> ARRaycastResult? {
        guard let arView = arView,
              let query = arView.raycastQuery(from: location,
                                              allowing: .existingPlaneGeometry,
                                              alignment: .horizontal) else { return nil }
        let results = arView.session.raycast(query)
        return results.first
    }
}
