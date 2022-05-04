//
//  Crusher.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 19/02/2020.
//  Copyright © 2020 Reborn. All rights reserved.
//

import Foundation
import SpriteKit

class Crusher:SKSpriteNode{
    
    let player = Player()
    var initialSize =  CGSize(width:60 , height:60)
    let textureAtlas: SKTextureAtlas = SKTextureAtlas(named:"crusher")
    let falling = false
    var crushing = false
    var timer: DispatchSourceTimer?
    func aPatientlyWaitingFunction(){
    }

    


    
    init(){
        super.init(texture: textureAtlas.textureNamed("Idle0000"), color: .clear, size: initialSize)
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.crusher.rawValue
        self.physicsBody?.collisionBitMask = ~PhysicsCategory.damagedPlayer.rawValue
        self.physicsBody?.mass = 20000000
        self.physicsBody?.isDynamic = true
        //startTimer()
        idleAnimation()
        //checking()
 
    }
    
    //Initial try to check distance, however later replaced when the .convert function was found to be more useful
    
    
//    func checking(){
//        let checkPos = SKAction.run(){
//            let positionOfCrusher = self.convert(self.position, from: self.encounterManager.encounters[3])
//            let modulusMagnitudeDistance = abs(positionOfCrusher.x - self.player.position.x)
//        if modulusMagnitudeDistance < 100{
//            print("WW")
//
//                    }
//        }
    

    
    
    func debug(){
        print("ok")
    }
    

    //creates the animations for when the crusher is idling
    func idleAnimation(){
        let idleFrames:[SKTexture] = [textureAtlas.textureNamed("Idle0000"),
                                      textureAtlas.textureNamed("Idle0001"),
                                      textureAtlas.textureNamed("Idle0002"),
                                      textureAtlas.textureNamed("Idle0003"),
                                      textureAtlas.textureNamed("Idle0004"),
                                      textureAtlas.textureNamed("Idle0005"),
                                      textureAtlas.textureNamed("Idle0006"),
                                      textureAtlas.textureNamed("Idle0007")
        ]
    
        let idleAnimated = SKAction.animate(with: idleFrames, timePerFrame: 0.1)
        let idleForever = SKAction.repeatForever(idleAnimated)
        self.run(idleForever)
        
//        let positionOfCrusher = convert(self.position, from: encounterManager.encounters[3])
//        let modulusMagnitudeDistance = abs(positionOfCrusher.x - player.position.x)
//        if modulusMagnitudeDistance < 100{
//            print("WW")
//
//                }

       
        
        
    }
    
    //creates animation for crusher that is crushing
    func crushingAnimation() {
         self.removeAction(forKey: "idling")
         let crushingFrames:[SKTexture] = [textureAtlas.textureNamed("Down0000"),
                                           textureAtlas.textureNamed("Down0001"),
                                           textureAtlas.textureNamed("Down0002"),
                                           textureAtlas.textureNamed("Down0003"),
                                           textureAtlas.textureNamed("Down0004"),
                                           textureAtlas.textureNamed("Down0005"),
                                           textureAtlas.textureNamed("Down0006")
                                      
            ]
        
        let crushingAnimated = SKAction.animate(with: crushingFrames, timePerFrame: 0.01)
        let crush = SKAction.run {
            self.physicsBody?.applyForce(CGVector(dx: 0, dy: -8000000000))
        }
        let crushingSequence = SKAction.sequence([crush , crushingAnimated])
        self.run(crushingSequence)
    }
    func trackPlayer(crusherPosition: CGPoint, playerPosition: CGPoint){
        // checks(to see if the co-ordinate systems are working in sync)
        if playerPosition.x > crusherPosition.x{

            
        }
        if playerPosition.x < crusherPosition.x {
        }
        
        
        
    }
    
    //Code was intially used to try and create a timer so that the crusher would repeat this crushing animation every few seconds, provided limited functionality and could not be repeated through use of skaction.repeat() which lead to issues replaced by function defined in game scene
    
//    func startTimer() {
//        let queue = DispatchQueue(label: "com.domain.app.timer")
//        timer = DispatchSource.makeTimerSource(queue: queue)
//        timer!.schedule(deadline: .now(), repeating: .seconds(1))
//        timer!.setEventHandler { [weak self] in
//            if self?.crushing == true{
//                print("ww")
//                self?.crushing = false
//                print(self?.name as Any)
//                self!.crushingAnimation()
//            }
//            else{
//
//            }
//
//        }
//        timer!.resume()
//    }
//
//    func stopTimer() {
//        timer?.cancel()
//        timer = nil
//    }
//
//
//
//
//
//
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    }
