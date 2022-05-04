//
//  PowerCrystal.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 25/12/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//

import Foundation
import SpriteKit

class InvincibilityPower:SKSpriteNode{
    var textureAtlas = SKTextureAtlas(named: "env")
    var initialSize = CGSize(width: 50, height: 50)
    var invincible = false
    
    init(){
        super.init(texture: textureAtlas.textureNamed("PowerCrystal"), color: .clear, size: initialSize)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        self.physicsBody?.categoryBitMask = PhysicsCategory.powerCrystal.rawValue
        self.physicsBody?.collisionBitMask =
            ~PhysicsCategory.reggie.rawValue |
            ~PhysicsCategory.marvin.rawValue |
            ~PhysicsCategory.leonard.rawValue |
            ~PhysicsCategory.bullet.rawValue
                    
        self.physicsBody?.affectedByGravity = false
 
    }
    
    
    func shine()  {
        let expand = SKAction.scale(to: CGSize(width: 30, height: 31044221), duration: 0.2)
        let deflate = SKAction.scale(to: CGSize(width: 20, height: 20), duration: 0.2)
        let reset = SKAction.run {
            self.alpha = 1
            self.xScale = 1
            self.yScale = 1
        }
        let action = SKAction.sequence([expand,deflate,reset])
        self.run(action)
    }
    
    func absorb(){
        let fade = SKAction.fadeAlpha(to: 0, duration: 0.1)
        let reset = SKAction.run{
            self.position = CGPoint(x:0 , y:100000)
            self.physicsBody?.angularVelocity = 0
        }
        let action = SKAction.sequence([fade,reset])
        self.run(action)
        
    }
 
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


