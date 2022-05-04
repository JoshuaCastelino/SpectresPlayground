//
//  Platform3.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 07/12/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//

import Foundation
import SpriteKit

class Platform3:SKSpriteNode {
    var initialSize = CGSize(width: 47, height: 47)
    var textureAtlas = SKTextureAtlas(named: "env")
    
    init() {
        super.init(texture: textureAtlas.textureNamed("Earth"),color : .clear , size: initialSize )
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
