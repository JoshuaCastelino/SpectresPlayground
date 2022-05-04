//
//  Coin.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 01/12/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//

import Foundation
import SpriteKit

class Diamond:SKSpriteNode{
    var initialSize: CGSize = CGSize(width:32 , height:32)
    var textureAtlas = SKTextureAtlas(named: "env")
    var value = 1
    
    init() {
        super.init(texture: textureAtlas.textureNamed("Diamond") , color: .clear , size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.diamond.rawValue
        self.physicsBody?.collisionBitMask = 0
        

    }
    
 
  func collect(){
        self.physicsBody?.categoryBitMask = 0
        let collectAnimation = SKAction.group([SKAction.fadeAlpha(to: 0, duration: 0.2) , SKAction.scale(to: 1.5, duration: 0.2) , SKAction.move(by: CGVector(dx:0 , dy:25), duration: 0.2)] )
        let resetAfterCollected = SKAction.run {
            self.position.y = 10000
            self.alpha = 1
            self.xScale = 1
            self.yScale = 1
            self.physicsBody?.categoryBitMask = PhysicsCategory.diamond.rawValue
        }
        let collectSequence = SKAction.sequence([collectAnimation , resetAfterCollected])
        self.run(collectSequence)
        value += 1
    }
    
    func nodeFade()  {
           self.physicsBody?.categoryBitMask = 0
           let fade = SKAction.fadeAlpha(to: 0, duration: 0.1)
           let pause =  SKAction.wait(forDuration: 2)
           let reset = SKAction.run{
               self.physicsBody?.categoryBitMask =
               PhysicsCategory.marvin.rawValue
               self.alpha = 1
               self.position.y = 10000
               
           }
           let nodeDeath = SKAction.sequence([fade , pause , reset])
           
           self.run(nodeDeath)

           print("Dead")
           
           
       }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
