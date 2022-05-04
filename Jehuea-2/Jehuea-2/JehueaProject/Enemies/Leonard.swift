//
//  Leonard.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 02/12/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//

import Foundation
import SpriteKit

class Leonard: SKSpriteNode, sprite{
    var health = 1 
    let shotDetectionRadius: CGFloat = 150
    var initialSize = CGSize(width: 50, height: 50)
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enemies")
    var xp = 5

    init() {
        super.init(texture: textureAtlas.textureNamed("Leonard"), color: .clear, size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.leonard.rawValue
        self.physicsBody?.collisionBitMask =
            ~PhysicsCategory.damagedPlayer.rawValue |
            ~PhysicsCategory.leonard.rawValue
        self.physicsBody?.isDynamic = false

        


        

        //self.physicsBody?.contactTestBitMask =PhysicsCategory.bullet.rawValue |PhysicsCategory.player.rawValue

    }
    
    
    
    func nodeFade()  {
           self.physicsBody?.categoryBitMask = 0
           let fade = SKAction.fadeAlpha(to: 0, duration: 0.1)
           let reset = SKAction.run{
               self.physicsBody?.categoryBitMask =
               PhysicsCategory.leonard.rawValue
               self.alpha = 1
               self.position.y = 100000000
               
           }
           let nodeDeath = SKAction.sequence([fade , reset])
           
           self.run(nodeDeath)

           print("Dead")
           
           
       }

    

    
    

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    
}
}
