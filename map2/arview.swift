//
//  arview.swift
//  map2
//
//  Created by Leona  Meharenna on 12/7/21.
//

import Foundation
import UIKit
import RealityKit

class ARViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Best312pantry.loadScene()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
    }
}
