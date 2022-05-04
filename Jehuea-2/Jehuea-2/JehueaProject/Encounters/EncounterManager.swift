//
//  EncounterManager.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 05/12/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//
import SpriteKit
import GameplayKit
import UIKit

var currentEncounterIndex: Int? = 0
let player = Player()

class EncounterManager {
    var previousEncounterIndex: Int?
	

    let encounterNames:[String] = [
        "EncounterA",
        "EncounterB",
        "EncounterC",
        "EncounterD",
        "EncounterE"
       
    ]
    var encounters: [SKNode] = []
	var marvins: [[String:CGPoint]] = [[:]]
	var multiplier = 0


	
 
    init() {
        for encounterFileName in encounterNames {
            let encounterNode = SKNode()
 
            if let encounterScene = SKScene(fileNamed:encounterFileName) {
                for child in encounterScene.children {
                    print(child.name ?? "nil")
                    let copyOfNode = type(of: child).init()
                    copyOfNode.position = child.position
                   
                    copyOfNode.name = child.name
                    encounterNode.addChild(copyOfNode)
					
                    
                   
                    
                }
            }
            encounters.append(encounterNode)
            saveSpritePositions(node: encounterNode)
           
            }
            
        }
    func convertPoint(toView point:CGPoint) -> CGPoint{
        return point
    }
 
   
    func addEncountersToScene(gameScene:SKNode) {
		// adds encounter to main view
        var encounterPosY = 1000
        for encounterNode in encounters {
            encounterNode.position = CGPoint(x: -2000,y: encounterPosY)
            gameScene.addChild(encounterNode)
            encounterPosY *= 2
        }
    }
	

	
    
    func saveSpritePositions(node: SKNode) {
		// Sets the sprite positions to the initial positions within the encounter scene
        for sprite in node.children {
            if let spriteNode = sprite as? SKSpriteNode {
                let initialPositionValue = NSValue.init(cgPoint:sprite.position)
                spriteNode.userData = ["initialPosition":initialPositionValue]

                saveSpritePositions(node: spriteNode)
				
            }
        }
    }
     
    func resetSpritePositions(node: SKNode) {
		//resests sprite positions to original positions
        for sprite in node.children {
            if let spriteNode = sprite as? SKSpriteNode {
                spriteNode.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
                spriteNode.physicsBody?.angularVelocity = 0
                spriteNode.zRotation = 0
                if let initialPositionVal =
                    spriteNode.userData?.value(forKey:"initialPosition") as? NSValue {
                    spriteNode.position = initialPositionVal.cgPointValue
				

			                }
                resetSpritePositions(node: spriteNode)
            }
			
        }
    }
    
    
    func placeNextEncounter(currentXPos: CGFloat)  {
		//Places the encounter within the view and randomly selects an encounter
		let encounterCount = UInt32(encounters.count)
        if encounterCount > 3 {
        var nextEncounterIndex: Int?
        var trulyNew: Bool?

        while trulyNew == false || trulyNew == nil {
            nextEncounterIndex =
                Int(arc4random_uniform(encounterCount))
            trulyNew = true
            if let currentIndex = currentEncounterIndex {
                if (nextEncounterIndex == currentIndex) {
                    trulyNew = false
                }
            }
            if let previousIndex = previousEncounterIndex {
                if (nextEncounterIndex == previousIndex) {
                    trulyNew = false
                }
            }
        }
     
        previousEncounterIndex = currentEncounterIndex
        currentEncounterIndex = nextEncounterIndex
     
        let encounter = encounters[currentEncounterIndex!]
        encounter.position = CGPoint(x: currentXPos + 1000, y: 300)
        resetSpritePositions(node: encounter)
        
        }
	}
	
	//Function to get the node position from the encounters array
	func getNodePos(nodeName: String) -> CGPoint{
		var nodePosition = CGPoint()
		for i in 0...(encounters.count-1){
			//checks every childnode from encounter
			for node in encounters[i].children{
				//Checks if the name of the child node is the same as the node being searched for
				if node.name == nodeName{
					//Adds the relative position of the node within the SKScene to the position
					//of the encounter within game to find exact position of sprite node.
					nodePosition.x = (node.position.x + encounters[i].position.x)
					nodePosition.y = (node.position.y + encounters[i].position.y)
								
						}
					}
						
				}
			//Returns the position of the node within the game scene
			return nodePosition
			}
	
    
      

}
	
	

    


