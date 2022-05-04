//
//  Experience.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 18/02/2020.
//  Copyright © 2020 Reborn. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class Experience{
    func gainExperienceFromKill(scoreMultiplier:Int, xp:Int) -> Int{
          return (scoreMultiplier * xp)
    }
    
    func createLevels(level:Int) -> Array<Int>{
        var levels:[Int] = []
        for i in 0...50{
            levels.append(Int(floor(Double(i) * 1.5) * 100))
        }
            print(levels)
            return levels

    }
    
    func levelAssigner(levels: Array<Int> , currentXP: Int) -> Int {
        var i = 0
        while i < (levels.count)-1 && currentXP > levels[i]{
            i += 1
        }
        
        return (i)
        
        
    }
    
}
