//
//  Hero.swift
//  GoTrojan
//
//  Created by simon sun on 1/26/15.
//  Copyright (c) 2015 wangbo. All rights reserved.
//

import Foundation
import SpriteKit
class Hero: SKSpriteNode{
    enum ColliderType:UInt32{
        case Hero = 1
        case Block = 2
        case Tool = 4
    }
    var heroAnimationArray:[SKAction]
    let dictionary = ["right": 0, "left": 1, "jump": 2, "stop":3]
    override init() {
        let heroTexture = SKTexture(imageNamed: "hero")
        heroAnimationArray = []
        super.init(texture: heroTexture, color: nil, size: heroTexture.size())
        self.position = CGPointMake(0,0)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.setScale(2)
        self.physicsBody!.affectedByGravity = true
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.friction=0.2
        self.physicsBody?.dynamic=true
        self.physicsBody?.mass=0.5
        self.physicsBody!.categoryBitMask = ColliderType.Hero.rawValue
        self.physicsBody!.contactTestBitMask = ColliderType.Tool.rawValue
        self.physicsBody!.collisionBitMask = ColliderType.Block.rawValue|ColliderType.Tool.rawValue
       
        initAnimation()
        userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initAnimation() {
        // right
        var rightTextures:[SKTexture] = []
        for i in 1...3 {
            rightTextures.append(SKTexture(imageNamed: "right\(i)"))
        }
        rightTextures.append(rightTextures[2])
        //rightTextures.append(rightTextures[1])
        //left 
        var leftTextures:[SKTexture] = []
        for i in 1...3 {
            leftTextures.append(SKTexture(imageNamed: "left\(i)"))
        }
        leftTextures.append(leftTextures[2])
        //leftTextures.append(leftTextures[1])
        //jump
        var jumpTextures:[SKTexture] = []
        jumpTextures.append(SKTexture(imageNamed: "jump2"))
        //jumpTextures.append(jumpTextures[1])
        //stop
        var stopTextures:[SKTexture] = []
        stopTextures.append(SKTexture(imageNamed: "right1"))

        heroAnimationArray.append(SKAction.repeatActionForever(SKAction.animateWithTextures(rightTextures, timePerFrame: 0.1)))
        heroAnimationArray.append(SKAction.repeatActionForever(SKAction.animateWithTextures(leftTextures, timePerFrame: 0.1)))
        heroAnimationArray.append(SKAction.repeatActionForever(SKAction.animateWithTextures(jumpTextures, timePerFrame: 0.05)))
        heroAnimationArray.append(SKAction.repeatActionForever(SKAction.animateWithTextures(stopTextures, timePerFrame: 0.01)))
    }
    
    func startAnimation(direction :String) {
      
        if actionForKey(direction) == nil {
            removeAllActions()
            runAction(SKAction.repeatActionForever(heroAnimationArray[dictionary[direction]!]),withKey: direction)
        }
    }

    
}