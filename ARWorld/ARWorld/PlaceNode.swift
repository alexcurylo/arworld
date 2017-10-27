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

    private func add() {
        let width: CGFloat = 6
        let height: CGFloat = 3
        let radius: CGFloat = 0.3

        let plane = SCNPlane(width: width, height: height)
        plane.cornerRadius = radius
        plane.firstMaterial?.diffuse.contents = UIColor.purple

        let text = SCNText(string: title, extrusionDepth: 0)
        text.font = UIFont.systemFont(ofSize: 1, weight: .thin)
        text.isWrapped = true
        text.alignmentMode = kCAAlignmentCenter
        text.truncationMode = kCATruncationMiddle
        text.firstMaterial?.diffuse.contents = UIColor.white
        text.containerFrame = CGRect(x: 0, y: 0, width: width, height: height)

        let textNode = SCNNode(geometry: text)
        textNode.position = SCNVector3(0, 0, radius)
        textNode.center()
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.addChildNode(textNode)
        
        node.scale = SCNVector3(3,3,3)
        node.addChildNode(planeNode)
        
        let constraint = SCNBillboardConstraint()
        constraint.freeAxes = .Y
        constraints = [constraint]

        addChildNode(node)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
