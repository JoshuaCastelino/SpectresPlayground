//
//  Player.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 30/11/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//

import Foundation
import SpriteKit





class Player:SKSpriteNode {
    var initialSize = CGSize(width: 42, height: 108)
    let textureAtlas = SKTextureAtlas(named: "Jehua")
    var flyAble = true
    var flying = false
    let maxFlyingForce:CGFloat = 200
    let maxHeight : CGFloat = 500
    var forwardVelocity: CGFloat = 200
    var falling = false
    var lives = 3
    var shooting = false
    var invunerable = false
    let playerRadius: CGFloat = 200

    
    init(){
        super.init(texture: nil,color: .blue , size: initialSize)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 42, height: 48))
        
        self.physicsBody?.mass = 0.02
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.allowsRotation = false
        createAnimations()
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
        self.physicsBody?.contactTestBitMask =
            PhysicsCategory.reggie.rawValue |
            PhysicsCategory.leonard.rawValue |
            PhysicsCategory.marvin.rawValue |
            PhysicsCategory.ground.rawValue |
            PhysicsCategory.diamond.rawValue |
            PhysicsCategory.crusher.rawValue
        self.physicsBody?.collisionBitMask = PhysicsCategory.ground.rawValue
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
            }
    
    func createAnimations(){

        let walkFrames:[SKTexture] = [textureAtlas.textureNamed("JW1"), textureAtlas.textureNamed("JW2") ,textureAtlas.textureNamed("JW3") , textureAtlas.textureNamed("JW4")]
        let walkAnimated = SKAction.animate(with: walkFrames, timePerFrame: 0.4)
        let walking = SKAction.repeatForever(walkAnimated)
        self.run(walking, withKey: "Walking")
    
        
    }
    
    func Jump(){
       //self.physicsBody?.velocity =  CGVector(dx: 10, dy: 800)
        if self.lives > 0 {
            self.flying = true
        
        self.removeAction(forKey: "Walking")
        self.removeAction(forKey: "Falling")
        let flyFrames:[SKTexture] = [textureAtlas.textureNamed("JF1") , textureAtlas.textureNamed("JF2"), textureAtlas.textureNamed("JF3"), textureAtlas.textureNamed("JF4") ]
        let flyAnimated = SKAction.animate(with: flyFrames, timePerFrame: 0.1)
        self.run(flyAnimated, withKey: "FlyAnimated")
        }
        


    }
    
    
    func fire(){
        self.flyAble = false
        self.removeAction(forKey: "Walking")
        self.removeAction(forKey: "FlyAnimated")
        let shootFrames = [textureAtlas.textureNamed("JS1"),textureAtlas.textureNamed("JS2"),textureAtlas.textureNamed("JS3")]
        let flyAnimated = SKAction.animate(with: shootFrames, timePerFrame: 0.02)
        self.run(flyAnimated, withKey: "Shooting")
        self.flyAble = true



    }
    
    
    
    func fallingAnimation()  {
        self.removeAction(forKey: "FlyAnimated")
        let fallFrames:[SKTexture] = [textureAtlas.textureNamed("JF4") , textureAtlas.textureNamed("JF3") , textureAtlas.textureNamed("JF1") , textureAtlas.textureNamed("JF2") ]
        let fallAnimated = SKAction.animate(with: fallFrames, timePerFrame: 0.1)
        self.run(fallAnimated , withKey: "Falling")

    }
    
    func damage(){
        
        lives -= 1
        let fadeAnimationIn = SKAction.fadeAlpha(to:0.2, duration: 0.4)
        let fadeAnimationOut = SKAction.fadeAlpha(by: 1, duration: 0.4)
        let damageAnimation = SKAction.sequence([fadeAnimationIn , fadeAnimationOut])
        let repeatDamage = SKAction.repeat(damageAnimation, count: 3)
        self.run(repeatDamage)
        
        
    }
    
    func die(){
        let beginDeath = SKAction.run{
        self.physicsBody?.velocity.dx = 0
        self.physicsBody?.velocity.dy = 0
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody = SKPhysicsBody(circleOfRadius: 1)

        }
        let finalDeath = SKAction.fadeAlpha(to: 0, duration: 0.2)
        
        let turn =  SKAction.rotate(toAngle: 0.8, duration: 0.3)
        let explode = SKAction.scale(to: CGSize(width: 20, height: 20), duration: 0.3)
        let implode = SKAction.scale(to: CGSize(width: 0, height: 0), duration: 0.3)
        let death = SKAction.sequence([beginDeath,turn, explode , implode,finalDeath])
        self.run(death)
        
    }
    
    
    
    func update(){
        if self.flying {
            
            var forceToApply = maxFlyingForce
            
            if position.y > 600{
                let percentageOfMaxHeight = position.y / maxHeight
                let flappingForceSubtraction = percentageOfMaxHeight * maxFlyingForce
                forceToApply -= flappingForceSubtraction
            }
            self.physicsBody?.applyForce(CGVector(dx: 0, dy: forceToApply))
            if self.physicsBody!.velocity.dy > 150{
                self.physicsBody!.velocity.dy = 150
            }
        }
        self.physicsBody?.velocity.dx = self.forwardVelocity
        
       // if self.flapping == false && self.position.y > 0{
         //   fallingAnimation()
        //}
       // if self.physicsBody?.velocity == CGVector(dx: forwardVelocity , dy:0) {
           // createAnimations()
            
            
       // }
       // else{
       //     fallingAnimation()
       // }
        
       
        

    }
    
        func invincible(){
            invunerable = true
            
            let invincible = SKAction.run{
                //self.physicsBody?.categoryBitMask = PhysicsCategory.invincible.rawValue
                self.forwardVelocity = 500
            }
            
            let pause = SKAction.wait(forDuration: 8)
            let sizeUp = SKAction.scale(by: 2, duration: 0.2)
            let mortal = SKAction.run {
                //self.physicsBody?.categoryBitMask = PhysicsCategory.player.rawValue
                self.forwardVelocity = 200
                self.invunerable = false
            }
            let sizeDown = SKAction.scale(by: 0.5 ,duration:  0.2)
            
            let action = SKAction.sequence([sizeUp,invincible,pause,sizeDown,mortal])
            self.run(action)
            
            
        }
    
    func groundSlam(){
        self.physicsBody?.applyForce(CGVector(dx:20 , dy:-1600))
        
    }


    
    
}
