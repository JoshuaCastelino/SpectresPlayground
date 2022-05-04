//
//  Bullet.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 09/12/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//

/*import Foundation
import SpriteKit
let degreesToRadians = CGFloat.pi / 180
let radiansToDegrees = 180 / CGFloat.pi
let bullet = SKSpriteNode()

class Bullet: SKSpriteNode{
    var initialSize = CGSize(width: 30 , height: 11)
    let textureAtlas = SKTextureAtlas(named : "env")

    
    init(){
        super.init(texture: textureAtlas.textureNamed("Bullet") , color: .clear , size: initialSize)
        self.size = CGSize(width: 30 , height: 11)
        self.physicsBody = SKPhysicsBody(rectangleOf: initialSize)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.bullet.rawValue
        self.physicsBody?.contactTestBitMask =
            PhysicsCategory.reggie.rawValue |
            PhysicsCategory.leonard.rawValue |
            PhysicsCategory.marvin.rawValue |
            PhysicsCategory.ground.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.ground.rawValue
        self.alpha = 1
    
        
    }
    
    func createBullet(player: SKSpriteNode) -> SKSpriteNode{
           let bullet = Bullet()
           bullet.position = CGPoint(x: player.position.x + 43 , y: player.position.y )
           return bullet
       }
    
    func updateBullet(){
        let dx = Double((self.physicsBody?.velocity.dx)!)
        let dy = Double((self.physicsBody?.velocity.dy)!)
        let angle = atan2(dy, dx)
        bullet.zRotation = CGFloat(angle) - 90 * degreesToRadians
        
        
        
    }
  
    
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
 */


import Foundation
import SpriteKit

class Bullet: SKSpriteNode{
    var initialSize = CGSize(width: 30 , height: 11)
    let textureAtlas = SKTextureAtlas(named : "env")
    func aPatientlyWaitingFunction(){
        print("Waiting")
    }
    
    init(){
        super.init(texture: nil , color: .clear , size: initialSize)
    
        
    }
    
    func createBullet(node: SKSpriteNode, bulletPosition: CGPoint ,shooter: String) -> SKSpriteNode{
           let bulletTexture = textureAtlas.textureNamed("Bullet")
           let bullet = SKSpriteNode()

           bullet.size = CGSize(width: 30 , height: 11)
           bullet.texture = bulletTexture
           bullet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 11))
           bullet.physicsBody?.usesPreciseCollisionDetection = true
           bullet.physicsBody?.allowsRotation = false
           bullet.physicsBody?.isDynamic = true

           bullet.position = bulletPosition
           bullet.physicsBody?.categoryBitMask = PhysicsCategory.bullet.rawValue
           bullet.physicsBody?.collisionBitMask = 0

           if shooter == "player"{
            // If the shooter is the player it should only collide with enemies
			print("Switching to player mask")
               bullet.physicsBody?.contactTestBitMask =
                     PhysicsCategory.reggie.rawValue |
                     PhysicsCategory.leonard.rawValue |
                     PhysicsCategory.marvin.rawValue |
                     PhysicsCategory.ground.rawValue
            
         }
            
            
		  else{
			//It should only collide with the player if it is not an enemy shooting the bullet
			print("Switching to enemy mask")
			bullet.physicsBody?.contactTestBitMask =
					PhysicsCategory.player.rawValue |
					PhysicsCategory.ground.rawValue
			bullet.zRotation = -3.14

		}
		
		if shooter == "marvin" {
			DispatchQueue.main.asyncAfter(deadline:.now() + 10){
				print("Ten ")
			}

		}
        
           bullet.alpha = 1
           return bullet
           
       }
    
  
    
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

