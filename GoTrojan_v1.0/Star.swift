//
//  Star.swift
//  GoTrojan_v1.0
//
//  Created by simon sun on 3/4/15.
//  Copyright (c) 2015 University of Southern California. All rights reserved.
//

import Foundation
import SpriteKit
class Star : SKSpriteNode {
    
    enum ColliderType:UInt32{
        case Hero = 1
        case Block = 2
        case Tool = 4
        case Star = 8
    }
    init(imageNamed: String) {
        let toolTexture = SKTexture(imageNamed: imageNamed)
        super.init(texture: toolTexture, color: nil, size: toolTexture.size())
        self.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        //self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.allowsRotation = false
        self.physicsBody?.dynamic=false
        self.physicsBody!.categoryBitMask = ColliderType.Star.rawValue
        self.physicsBody!.contactTestBitMask =  ColliderType.Hero.rawValue
        self.physicsBody!.collisionBitMask = ColliderType.Hero.rawValue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}