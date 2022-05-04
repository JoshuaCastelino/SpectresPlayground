//
//  Reggie.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 03/12/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//

import Foundation
import SpriteKit

class Reggie:SKSpriteNode , sprite{
    var health = 1
    
    var initialSize:CGSize = CGSize(width: 80, height: 80)
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enemies")
    var xp = 20
    let shotDetectionRadius: CGFloat = 150

    
    init() {
        super.init(texture: textureAtlas.textureNamed("Reggie"), color: .clear, size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 3)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.reggie.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPlayer.rawValue
        self.physicsBody?.isDynamic = false



      //  self.physicsBody?.contactTestBitMask =PhysicsCategory.bullet.rawValue |PhysicsCategory.player.rawValue
   
        
    }
    

    
     func nodeFade()  {
           self.physicsBody?.categoryBitMask = 0
           let fade = SKAction.fadeAlpha(to: 0, duration: 0.01)
           let reset = SKAction.run{
               self.physicsBody?.categoryBitMask =
               PhysicsCategory.reggie.rawValue
               self.alpha = 1
               self.position.y = 10000000
               
           }
           let nodeDeath = SKAction.sequence([fade  , reset])
           
           self.run(nodeDeath)

           print("Dead")
           
           
       }
    

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
