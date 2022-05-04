//
//  Platform4.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 26/02/2020.
//  Copyright © 2020 Reborn. All rights reserved.
//

import Foundation
import SpriteKit

class Platform4:SKSpriteNode {
    var initialSize = CGSize(width: 47, height: 47)
    var textureAtlas = SKTextureAtlas(named: "env")
    
    init() {
        super.init(texture: textureAtlas.textureNamed("BrokenFloor"),color : .clear , size: initialSize )
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 47, height: 47))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false

        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
