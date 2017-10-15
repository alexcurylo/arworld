//
//  PlaceNode.swift
//  ARWorld
//
//  Created by Alex Curylo on 10/14/17.
//  Copyright © 2017 Trollwerks Inc. All rights reserved.
//

import ARCL
import CoreLocation
import SceneKit

final class PlaceNode: LocationNode {

    private let node: SCNNode
    private let title: String

    init(location: CLLocation, title: String) {
        self.node = SCNNode()
        self.title = title
        super.init(location: location)

        add()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func add() {
        let plane = SCNPlane(width: 5, height: 3)
        plane.cornerRadius = 0.2
        let color = UIColor(red: 0x34/0xFF, green: 0x98/0xFF, blue: 0xdb/0xFF, alpha: 1)
        plane.firstMaterial?.diffuse.contents = color

        let text = SCNText(string: title, extrusionDepth: 0)
        text.containerFrame = CGRect(x: 0, y: 0, width: 5, height: 3)
        text.isWrapped = true
        text.font = UIFont(name: "Futura", size: 1.0)
        text.alignmentMode = kCAAlignmentCenter
        text.truncationMode = kCATruncationMiddle
        text.firstMaterial?.diffuse.contents = UIColor.white
        
        let textNode = SCNNode(geometry: text)
        textNode.position = SCNVector3(0, 0, 0.2)
        textNode.center()
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.addChildNode(textNode)
        
        node.scale = SCNVector3(3,3,3)
        node.addChildNode(planeNode)
        
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = .Y
        constraints = [billboardConstraint]

        addChildNode(node)
    }
}

extension SCNNode {

    func center() {
        let (min, max) = boundingBox
        let dx = min.x + 0.5 * (max.x - min.x)
        let dy = min.y + 0.5 * (max.y - min.y)
        let dz = min.z + 0.5 * (max.z - min.z)
        pivot = SCNMatrix4MakeTranslation(dx, dy, dz)
    }
}
