//
//  Sprite.swift
//  JehueaProject
//
//  Created by Joshua Castelino on 13/12/2019.
//  Copyright © 2019 Reborn. All rights reserved.
//

import Foundation
import SpriteKit

protocol sprite {
    var textureAtlas: SKTextureAtlas { get set }
    var initialSize: CGSize { get set }
    var health : Int { get }

}

