//
//  GameScene.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 30/11/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit


enum PhysicsCategory: UInt32  {
    case nili = 0
    case player = 1
    case damagedPlayer = 2
    case powerCrystal = 4
    case diamond = 8
    case ground = 16
    case bullet = 32
    case marvin = 64
    case leonard = 128
    case reggie = 356
    case invincible = 712
    case crusher = 1424
}
extension UserDefaults{
          
  func setDiamonds(value: Int) {
      set(value, forKey: "Diamonds")
  }
  
  func getDiamonds() -> Int {
      return integer(forKey: "Diamonds")
  }
  func setExperience(value: Int) {
        set(value, forKey: "xp")
    }
    
  func getExperience() -> Int {
        return integer(forKey: "xp")
    }
    
  func getLevel() -> Int {
        return integer(forKey: "level")
    }
    
    
    
  }

let degreesToRadians = CGFloat.pi / 180
let radiansToDegrees = 180 / CGFloat.pi
let shotDetectionRadius: CGFloat = 150


class GameScene: SKScene , SKPhysicsContactDelegate {
    let ground = Ground()
    let player = Player()
    let cam = SKCameraNode()
    let initialPlayerPosition = CGPoint(x:150 , y:150)
    var playerProgress = CGFloat()
    let screenCentreY = CGPoint()
    let screenCentreX = CGPoint()
    let diamond = Diamond()
    var screenCenterY:CGFloat = 0
    let marvin = Marvin()
    let leonard = Leonard()
    let reggie = Reggie()
    let encounterManager = EncounterManager()
    var nextEncounterSpawnPosition = CGFloat(150)
    let bullet = Bullet()
    var nodePosition =  CGPoint()
    var bulletFired = false
    var bullets:[SKSpriteNode] = [ ]
    var reggieHealth = 3
    var marvinHealth = 2
    var LeonardHealth = 1
    var tagged = false
    var mask : UInt32 = 0
    var hitEnemy = true
    var i = Int()
    var place = false
    let hud = HUD()
    let IP = InvincibilityPower()
    let displaySize: CGRect = UIScreen.main.bounds
    let fireButton = SKSpriteNode()
    let groundPound = SKSpriteNode()
    var diamondsCollected = 0
    var CounterForExperience = 0
    func aPatientlyWaitingFunction(){
    }
    var shootTwice = 0
    
    struct defaultsKeys {
        static let keyOne = "name"
        static let keyTwo = "xp"
        static let keyThree = "Diamonds"
        static let keyFour = "level"
    }
    
    let defaults = UserDefaults.standard
    let pastDiamonds = UserDefaults.standard.getDiamonds()
    let pastExperience = UserDefaults.standard.getExperience()
    let scoreMultiplier = 1
    let experience = Experience()
    var experienceGained = 0
    let crusher = Crusher()
    let crushers:[SKNode] = []
    var enemyBullets:[SKNode] = []
    
    

    
        
    

    
    override func didMove(to view: SKView) {
        let hudAtlas = SKTextureAtlas(named: "hud")
        let cameraOrigin = CGPoint(x: self.size.width / 2 , y: self.size.height / 2)
        fireButton.size = CGSize(width:175 , height:96)
        fireButton.texture = hudAtlas.textureNamed("Fire")
        fireButton.name = "FIRE"
        fireButton.alpha = 1
        groundPound.size = CGSize(width:175 , height:96)
        groundPound.texture = hudAtlas.textureNamed("Fire")
        groundPound.name = "POUND"
        groundPound.alpha = 1
        
        
        screenCenterY = self.size.height / 2
        ground.position = CGPoint(x: -self.size.width, y:  0 )
        ground.size = CGSize(width: 2 * self.size.width , height: 0)
        ground.createGround()
        self.addChild(ground)
        
        player.position = initialPlayerPosition
        self.addChild(player)
   //     player.physicsBody?.applyImpulse(CGVector(dx: -300 ,dy:-200 ))
        self.camera = cam
        //self.background()
        self.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.4, alpha: 0)
        
        diamond.position = CGPoint(x: 200, y: 320)
       // self.addChild(diamond)
        
        //self.addChild(marvin)
        
        //self.addChild(leonard)
        
       // self.addChild(reggie)
        
        
        
        encounterManager.addEncountersToScene(gameScene: self) 
        encounterManager.encounters[0].position = CGPoint(x: 400 , y :330)
        
        
        self.physicsWorld.contactDelegate = self
      
        IP.position = CGPoint(x: -800 ,y:-800)
        self.addChild(IP)
        
        fireButton.position = CGPoint(x: cameraOrigin.x - 100 , y:cameraOrigin.y - 350)
        groundPound.position = CGPoint(x: cameraOrigin.x - 800 , y:cameraOrigin.y - 350)

        DispatchQueue.main.asyncAfter(deadline:.now() + 6) {
            self.aPatientlyWaitingFunction()
            let fade = SKAction.fadeAlpha(to: 0.01, duration: 0.4)
            self.fireButton.run(fade)
                            
                          }

        self.addChild(camera!)
        self.camera?.zPosition = 50
        self.camera!.addChild(fireButton)
        self.camera?.addChild(groundPound)
        hud.collectedDiamond(screenSize: self.size)
        hud.createHearts(screenSize: self.size)
        hud.displayLevel(screenSize: self.size)
        hud.setLevel(level: defaults.integer(forKey: defaultsKeys.keyFour))

        self.camera!.addChild(hud)

    }
    
    override func didSimulatePhysics() {
        
        self.camera!.position.x = (player.position.x )
        self.camera!.position.y = (player.position.y + 144)
        playerProgress = player.position.x - initialPlayerPosition.x
        ground.checkForReposition(playerProgress : playerProgress)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        var cameraYPos = screenCenterY
        cam.yScale = 1
        cam.xScale = 1

                    if (player.position.y>screenCenterY) {
        cameraYPos = player.position.y
                        let percentOfMaxHeight = (player.position.y -
        screenCenterY) / (player.maxHeight -
        screenCenterY)
                        let newScale = 1 + 0.3 * (percentOfMaxHeight)
        cam.yScale = newScale
        cam.xScale = newScale
                    }

        self.camera!.position = CGPoint(x: player.position.x,y: cameraYPos)
        if player.position.x > nextEncounterSpawnPosition {
            encounterManager.placeNextEncounter(currentXPos: nextEncounterSpawnPosition)
            nextEncounterSpawnPosition += 1200
        }
                }
    
	func rotateBullet(player:CGPoint , enemy:CGPoint){
		let xDelta =  enemy.x - player.x
		let yDelya = enemy.y - player.y
		
		let angle = atan2(yd, <#T##Double#>)
	}
    
    
    func placeStar(){
        i = Int(arc4random_uniform(10000))
        
        if i == 9{
            place = true
            place = false
            let randomYPos = CGFloat(arc4random_uniform(400) + 50)
            IP.position = CGPoint(x: nextEncounterSpawnPosition - 100    , y: randomYPos)
                    
                }else{
        }
        
    }
    
    
  
    func death(node:SKSpriteNode , health: Int){
    
    let health = health - 1
        if health == 0{
         let fade = SKAction.fadeAlpha(to: 0, duration: 0.01)
            self.run(fade)
        
        }
    }
   func Tagged() -> Bool{
              
              return true
          }
    
    
    
    
    let nodeDeath: SKAction = {
               let fade = SKAction.fadeAlpha(to: 0, duration: 0)
               let nodeDeathSequence = SKAction.sequence([fade , SKAction.removeFromParent()])
               return nodeDeathSequence
    }()
    

        


    func removeShot()  {
        self.aPatientlyWaitingFunction()
        self.bullets[0].removeFromParent()
        self.bullets.remove(at: 0)
        
    }
    
    // checks if the player is within the detection radius of the enemy
    func shootPlayer(positionOfEnemy: CGPoint){
        let deltaX = player.position.x - positionOfEnemy.x
        let deltaY = player.position.y - positionOfEnemy.y
        let mag = sqrt((deltaX * deltaX) + (deltaY * deltaY))
        if mag <= shotDetectionRadius{
        }
    }
  

    
    func didBegin(_ contact: SKPhysicsContact) {
     
        hitEnemy = false
        let ballOfDeath = SKShapeNode(circleOfRadius: 20)
        
        ballOfDeath.position = contact.contactPoint
        var otherBody: SKPhysicsBody
        otherBody = contact.bodyA
        let playerMask = PhysicsCategory.player.rawValue
        let bulletMask = PhysicsCategory.bullet.rawValue
        let groundMask = PhysicsCategory.ground.rawValue
        let crusherMask = PhysicsCategory.crusher.rawValue
        print(otherBody.categoryBitMask)
        
        if otherBody.categoryBitMask == bulletMask{
             mask = bulletMask
        }else if otherBody.categoryBitMask == playerMask{
             mask = playerMask
        }else if otherBody.categoryBitMask == crusherMask{
            mask = crusherMask
        }else{
            mask = groundMask
        }
        
        
        
	//checks the category bit masks of contact bodie if both sum to 96 must be marvin
      if ( contact.bodyB.categoryBitMask + mask) == 96 {
			  hitEnemy = true
			  if bullets.count>0{
					  removeShot()

			  }
			  scene?.addChild(ballOfDeath)
			  ballOfDeath.run(nodeDeath)
		  
			  hud.removeHeart()
			  player.damage()
				  

			 
			  if let marvin = contact.bodyB.node as? Marvin{
				  marvin.nodeFade()
				  experienceGained += experience.gainExperienceFromKill(scoreMultiplier: scoreMultiplier, xp: marvin.xp)
				  print("you gained + \(experienceGained)")


		  
		  }
		  
		  }
        
	else if ( contact.bodyB.categoryBitMask + mask) == 160{
                scene?.addChild(ballOfDeath)
                ballOfDeath.run(nodeDeath)
                hitEnemy = true
                if bullets.count>0{
                        removeShot()

                }


               
	if let leonard = contact.bodyB.node as? Leonard{
				leonard.nodeFade()
				experienceGained += experience.gainExperienceFromKill(scoreMultiplier: scoreMultiplier, xp: leonard.xp)
				print("you gained + \(experienceGained)")


                   }
        
         }
     else if ( contact.bodyB.categoryBitMask + mask) == 388 {
                scene?.addChild(ballOfDeath)
                ballOfDeath.run(nodeDeath)
                hitEnemy = true
                if bullets.count>0{
                        removeShot()

                }
	if let reggie = contact.bodyB.node as? Reggie{
				reggie.nodeFade()
                    
				experienceGained += experience.gainExperienceFromKill(scoreMultiplier: scoreMultiplier, xp: reggie.xp)
				print("you gained + \(experienceGained)")

               }
        
           
            }
        
 
    else if let diamond = contact.bodyB.node as? Diamond{
		diamond.collect()
        self.diamondsCollected += diamond.value
        let diamondsBeingAdded = diamondsCollected + pastDiamonds
        defaults.set(diamondsBeingAdded, forKey: defaultsKeys.keyThree )
        print("THESE ARE ALL YOURS: \(defaults.integer(forKey: defaultsKeys.keyThree))")
        hud.setDiamondCountDisplay(Diamonds: self.diamondsCollected )
                                
        }
    
        if otherBody.categoryBitMask == groundMask{
            
            if (contact.bodyB.categoryBitMask) == 32{
                if bullets.count>0{
                        removeShot()
                }
            }
        }
        
        if otherBody.categoryBitMask == playerMask{
            if let reggie = contact.bodyB.node as? Reggie{
                                reggie.nodeFade()
                                  if player.invunerable == false{
                                    player.damage()
                                    hud.removeHeart()

                                          }

                           }
           if let leonard = contact.bodyB.node as? Leonard{
                                leonard.nodeFade()
                                  if player.invunerable == false{
                                    player.damage()
                                    hud.removeHeart()

                                          }
                           }
           if let marvin = contact.bodyB.node as? Marvin{
                                marvin.nodeFade()
            if player.invunerable == false{
                                player.damage()
                                hud.removeHeart()
            }

            
                           }
            
            //checks the category bitmask of the two objects colliding, if player collides with crusher triggets
            if (contact.bodyB.node as? Crusher) != nil{
                    while player.lives > 0{
                    player.damage()
                    hud.removeHeart()
                }
                    
                
                
                player.size = CGSize(width: 40, height: 10)
                player.physicsBody? = SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 10))
                
            }
            
          


                                    
            if let ip = contact.bodyB.node as? InvincibilityPower{
                ip.absorb()
                player.invincible()
    
            }
            
        }
        


    }
    
    override func update(_ currentTime: TimeInterval) {
        if player.flyAble == true{
            if player.lives == 0{
                player.die()
                player.flying = false
                while CounterForExperience == 0{
                    
                    let experienceBeingAdded = experienceGained + defaults.getExperience()
                    defaults.set(experienceBeingAdded, forKey: defaultsKeys.keyTwo)
                    print("totalExperience = \(defaults.getExperience()) ")
                    //Sets the level of the player by creating the array within the same line as it is being called
                    defaults.set(experience.levelAssigner(levels:experience.createLevels(level: defaults.integer(forKey: defaultsKeys.keyFour)) , currentXP: experienceBeingAdded) , forKey: defaultsKeys.keyFour)
                    print("your level is: \(defaults.getLevel())")
                    
                    CounterForExperience += 1

                    }
                
            }else{
				
				
				
				
				//converts point from scene view to game scene co - ordinates
                player.update()
                rotateBullet()
                //finds the position of the "crushers" in the encounter , the position must be converted from the SKScene co-ordinate system to the game scene syste,
                let positionOfCrusher = convert(crusher.position, from: encounterManager.encounters[3])
				//let positionOfLeonard = convert(crusher.position, from: encounterManager.encounters[2])
                //let positionOfReggie = convert(crusher.position, from: encounterManager.encounters[1])

                //finds the modulus of the distance between the player and crusher
                let modulusMagnitudeDistance = abs(positionOfCrusher.x - player.position.x)
                if modulusMagnitudeDistance < 200{
                    //runs the crushing animation when the player is "200m" away from the crusher , dispatch queue is called to make it so each crusher has a delay when falling
                if let crusher = encounterManager.encounters[3].childNode(withName: "Crusher1") as? Crusher{
                        //crusher.trackPlayer(crusherPosition: positionOfCrusher, playerPosition: player.position)
                        crusher.crushingAnimation()
                    }
                if let crusher = encounterManager.encounters[3].childNode(withName: "Crusher2") as? Crusher{
                    DispatchQueue.main.asyncAfter(deadline:.now() + 0.2) {
                        self.aPatientlyWaitingFunction()
                        crusher.crushingAnimation()
                                          }
                    }
                   
                if let crusher = encounterManager.encounters[3].childNode(withName: "Crusher3") as? Crusher{
                        DispatchQueue.main.asyncAfter(deadline:.now() + 0.4) {
                            self.aPatientlyWaitingFunction()
                            crusher.crushingAnimation()
                                }
                    
                    }
                    
                }
				
				
				
                // checks if the distance between the player and marvin is small enough so that the angle between the player and node can be outputted
                let relativeMarvin1 = (encounterManager.getNodePos(nodeName: "Marvin1")).x - player.position.x
                if relativeMarvin1 < 500{
                    if let marvin1 = encounterManager.encounters[0].childNode(withName: "Marvin1") as? Marvin{
                       if shootTwice <= 1{
						DispatchQueue.main.asyncAfter(deadline:.now() + 10) {
                                    self.aPatientlyWaitingFunction()
						}
						//let angleOfRotation = marvin1.trackShot(playerPosition: self.player.position, nodePosition: positionOfMarvin)
						//spawns bullet from marvin
						let marvinsBullet1 = self.bullet.createBullet(node: marvin1, bulletPosition: CGPoint(x:(encounterManager.getNodePos(nodeName: "Marvin1")).x  ,y: (encounterManager.getNodePos(nodeName: "Marvin1")).y ), shooter: "marvin")
						self.addChild(marvinsBullet1)
						marvinsBullet1.physicsBody?.applyForce(CGVector(dx:-1000,dy:0))
						self.enemyBullets.append(marvinsBullet1)
						//marvinsBullet1.zRotation = angleOfRotation
                            
                        
                                    self.shootTwice += 1

                                          }
                        
                    }
                                     
               
              
                
            }
                else{
                    shootTwice = 0
                }
            
        }
        
    }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            if nodeTouched.name == "FIRE"{
                bulletFired = true
                player.fire()
                let bulletNode = bullet.createBullet(node:player , bulletPosition: CGPoint(x: player.position.x + 43 , y: player.position.y ), shooter: "player")
                bullets.append(bulletNode)
                self.addChild(bulletNode)
                bulletNode.physicsBody?.applyForce(CGVector(dx: 1000, dy: 0))
                bulletFired = false
            }
            if nodeTouched.name == "POUND"{
                player.groundSlam()
            }else{
                player.Jump()
                }

                       
            
           
        
     }

        
    }
  
     override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.removeAction(forKey: "FlyAnimated")
        player.fallingAnimation()
        DispatchQueue.main.asyncAfter(deadline:.now() + 6) {
            self.aPatientlyWaitingFunction()
            let fade = SKAction.fadeAlpha(to: 0.01, duration: 0.4)
            self.fireButton.run(fade)
                        
                      }
    }
    
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.flying = false
        player.fallingAnimation()
        player.createAnimations()
        
    }
    

   
    




}

