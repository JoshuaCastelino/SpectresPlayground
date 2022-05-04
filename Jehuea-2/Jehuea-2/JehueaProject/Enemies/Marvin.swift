//
//  Marvin.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 02/12/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//


import Foundation
import SpriteKit

class Marvin:SKSpriteNode {
    var initialSize:CGSize = CGSize(width: 60, height: 80)
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Enemies")
    var health = 1
    let xp = 10
    let shotDetectionRadius: CGFloat = 150

    
    init() {
        super.init(texture: textureAtlas.textureNamed("Marvin"), color: .clear, size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2 )
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.marvin.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPlayer.rawValue
        self.physicsBody?.isDynamic = false


      //  self.physicsBody?.contactTestBitMask =PhysicsCategory.bullet.rawValue |PhysicsCategory.player.rawValue
   
        
    }
    
    
    func trackShot(playerPosition: CGPoint , nodePosition: CGPoint) -> CGFloat{
        let X = ((playerPosition.x - nodePosition.x))
        let Y = ((playerPosition.y - nodePosition.y))
        
        let angle = atan2(X, Y)
        return angle
    }
    
    
    
    
    func update(){
        health -= 1

        if health == 0{
            let die = SKAction.fadeAlpha(to: 0, duration: 0.1)
            self.run(die)
            print("dead")
            print()
            
        }
    }
    
     func nodeFade()  {
           self.physicsBody?.categoryBitMask = 0
           let fade = SKAction.fadeAlpha(to: 0, duration: 0.01)
           let reset = SKAction.run{
               self.physicsBody?.categoryBitMask =
               PhysicsCategory.marvin.rawValue
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
