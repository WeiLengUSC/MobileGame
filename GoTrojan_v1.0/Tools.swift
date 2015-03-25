//
//  Tools.swift
//  GoTrojan
//
//  Created by simon sun on 1/25/15.
//  Copyright (c) 2015 wangbo. All rights reserved.
//

import Foundation
import SpriteKit

class Tools : SKSpriteNode {
    
    let type:Int
    var actionArray :[SKAction]
    enum ColliderType:UInt32{
        case Hero = 1
        case Block = 2
        case Tool = 4
    }
    var originPosition: CGPoint!
    init(imageNamed: String, type:Int) {
        let toolTexture = SKTexture(imageNamed: imageNamed)
        self.type = type
        self.actionArray = []
        super.init(texture: toolTexture, color: nil, size: toolTexture.size())
        self.position = CGPointMake(0, 0)
        //self.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.allowsRotation = false
        self.physicsBody?.dynamic=true
        self.physicsBody?.mass=1000000
        self.physicsBody!.friction=0.5
        self.physicsBody!.categoryBitMask = ColliderType.Tool.rawValue
        self.physicsBody!.contactTestBitMask = ColliderType.Block.rawValue | ColliderType.Hero.rawValue
        self.physicsBody!.collisionBitMask = ColliderType.Block.rawValue | ColliderType.Hero.rawValue


        userInteractionEnabled = true
        initActionSequence()
    }
    
    func initActionSequence() {
        //左右action
        let actionMoveX = SKAction.moveByX( 200, y:0, duration: 3.0)
        let sequenceX = SKAction.sequence([actionMoveX,actionMoveX.reversedAction()])
        self.actionArray.append(sequenceX)
        //上下action
        let actionMoveY = SKAction.moveByX( 0, y:200, duration: 3.0)
        let sequenceY = SKAction.sequence([ actionMoveY,actionMoveY.reversedAction()])
        self.actionArray.append(sequenceY)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            // not overlap
            zPosition = 15
            //zoom out a litte bit
            if actionForKey("moving") == nil {
                originPosition = self.position
                let liftUp = SKAction.scaleTo(0.8, duration: 0.1)
                self.physicsBody!.categoryBitMask = 0
                runAction(liftUp, withKey: "pickup")
                println("began")
            }
           
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            zPosition = 0
            //move the box
            if actionForKey("moving") == nil  {
                //restore normal size
                let map = self.parent
                let dropDown = SKAction.scaleTo(1.0, duration: 0.1)
                runAction(dropDown, withKey: "drop")
                println(self.position.x)
                if self.position.x < 1898{
                    runAction(SKAction.repeatActionForever(actionArray[type]), withKey: "moving")
                }else {
                    self.position = originPosition
                }
                self.physicsBody!.categoryBitMask = ColliderType.Tool.rawValue
                println("end")
            }
            
            

        }
    }
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            if actionForKey("moving") == nil {
                let location = touch.locationInNode(self.parent)
                let touchedNode = nodeAtPoint(location)
                touchedNode.position = location
                println("move");

            }
                        
        }
    }

}