//
//  DarkKnight.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 26/02/2020.
//  Copyright © 2020 Reborn. All rights reserved.
//

import Foundation
import SpriteKit

class DarkKnight: SKSpriteNode, sprite{
    var health = 1
    
    var initialSize = CGSize(width: 50, height: 50)
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "DarkKnight")
    var xp = 5

    init() {
        super.init(texture: textureAtlas.textureNamed("DarkKight1"), color: .clear, size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.leonard.rawValue
        self.physicsBody?.collisionBitMask =
            ~PhysicsCategory.damagedPlayer.rawValue |
            ~PhysicsCategory.leonard.rawValue
        self.physicsBody?.isDynamic = false
        createAnimations()

        


        

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
    
    func createAnimations(){

            let walkFrames:[SKTexture] = [textureAtlas.textureNamed("DarkKnight1"),
                                          textureAtlas.textureNamed("DarkKnight2"),
                                          textureAtlas.textureNamed("DarkKnight3"),
                                          textureAtlas.textureNamed("DarkKnightTurn"),
                                          textureAtlas.textureNamed("DarkKnightBack1"),
                                          textureAtlas.textureNamed("DarkKnightBack3"),
                                          textureAtlas.textureNamed("DarkKnightBack4")]
            let walkAnimated = SKAction.animate(with: walkFrames, timePerFrame: 0.4)
            let walking = SKAction.repeatForever(walkAnimated)
            self.run(walking, withKey: "Walking")
        
        
    }

    

    
    

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    
}
}
