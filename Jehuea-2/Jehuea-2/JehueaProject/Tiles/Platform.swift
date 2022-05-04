//
//  LavaGround.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 05/12/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//

import Foundation
import SpriteKit

class Platform:SKSpriteNode {
    
    var initialSize = CGSize(width: 48, height: 48)
    var textureAtlas = SKTextureAtlas(named: "env")
    
    init() {
        super.init(texture: textureAtlas.textureNamed("FloorLava"),color : .clear , size: initialSize )
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 48, height: 48))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue 
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


