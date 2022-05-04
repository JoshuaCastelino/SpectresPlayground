//
//  Ground.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 30/11/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//

import Foundation
import SpriteKit

class Ground: SKSpriteNode{
    var textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "env")
    var initialSize = CGSize.zero
    var tileCount:CGFloat = 0
    var jumpWidth = CGFloat()
    var jumpCount = CGFloat()
    
    
    
    func createGround(){
        let groundTexture = textureAtlas.textureNamed("BrokenFloor")
        let groundTextureSize = CGSize(width: 44, height: 44)
        while tileCount * groundTextureSize.width < self.size.width {
            let tile = SKSpriteNode(texture: groundTexture)
             tile.size = groundTextureSize
             tile.position.x = tileCount * tile.size.width
            
            self.anchorPoint = CGPoint(x:0 , y:1)
            
            self.addChild(tile)
            tileCount += 1
            
            let pointTopLeft = CGPoint(x:0 ,y:24)
            let pointTopRight = CGPoint(x: size.width, y:24)
            self.physicsBody = SKPhysicsBody(edgeFrom: pointTopLeft, to: pointTopRight)
            self.physicsBody?.categoryBitMask = PhysicsCategory.ground.rawValue
            
            jumpWidth = groundTextureSize.width * floor(tileCount / 4)
            
        }
    }
    
    func checkForReposition(playerProgress : CGFloat){
        let groundJumpPosition = jumpWidth*jumpCount
        if playerProgress >= groundJumpPosition{
            self.position.x += jumpWidth
            jumpCount += 1
            
        }
    }
    
    
}
