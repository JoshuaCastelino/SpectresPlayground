//
//  HUD.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 07/12/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//

import Foundation
import SpriteKit

class HUD: SKNode {
    var textureAtlas = SKTextureAtlas(named: "hud")
    var environmentTextureAtlas = SKTextureAtlas(named: "env")
    var heart: [SKSpriteNode] = []
    let diamondText = SKLabelNode(text: "")
    let diamond = SKSpriteNode()
    let levelText = SKLabelNode(text: "")
    
    func collectedDiamond(screenSize: CGSize){
        let cameraOrigin = CGPoint(x: screenSize.width / 2 , y: screenSize.height / 2)
        let diamondImage = environmentTextureAtlas.textureNamed("Diamond")
        diamond.texture = diamondImage
        diamond.position = CGPoint(x:cameraOrigin.x - 850, y: cameraOrigin.y - 30)
        diamond.size = CGSize(width: 32, height: 32)
        diamondText.fontName = "Verdana-Bold"
        diamondText.fontSize = 12
        diamondText.position = CGPoint(x: cameraOrigin.x - 800, y: cameraOrigin.y - 30)
        diamondText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        diamondText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.addChild(diamondText)
        self.addChild(diamond)
        
}
    func createHearts(screenSize: CGSize){
        let cameraOrigin = CGPoint(x: screenSize.width / 2 , y: screenSize.height / 2)
        for i in 0..<3{
            let heartNode = SKSpriteNode()
            let HeartTexture = environmentTextureAtlas.textureNamed("Heart")
            heartNode.texture = HeartTexture
            heartNode.position = CGPoint(x: cameraOrigin.x - CGFloat(i*20)  - 50, y: cameraOrigin.y - 20)
            heartNode.size = CGSize(width: 30, height: 30)
            heart.append(heartNode)
            self.addChild(heartNode)
        }
       

    }
    func removeHeart(){
        heart[0].removeFromParent()
        heart.remove(at: 0)
        
    }
    
    
    func setDiamondCountDisplay(Diamonds: Int) {
 
        let formatter = NumberFormatter()
        let number = NSNumber(value: Diamonds)
        formatter.minimumIntegerDigits = 1
        if let diamonds = formatter.string(from: number) {
                     diamondText.text = diamonds
        }
    }
     func displayLevel(screenSize: CGSize){
            let cameraOrigin = CGPoint(x: screenSize.width / 2 , y: screenSize.height / 2)
            levelText.fontName = "Verdana-Bold"
            levelText.fontSize = 16
            levelText.position = CGPoint(x: cameraOrigin.x - 855, y: cameraOrigin.y - 60)
            levelText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            levelText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            self.addChild(levelText)
            
    }
    
    func setLevel(level:Int){
        let formatter = NumberFormatter()
        let number = NSNumber(value: level )
        formatter.minimumIntegerDigits = 1
        if let level = formatter.string(from: number) {
                     levelText.text = level
        }
    }

    
}
