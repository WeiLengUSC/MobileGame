//
//  GameScene.swift
//  GoTrojan
//
//  Created by wangbo on 1/24/15.
//  Copyright (c) 2015 wangbo. All rights reserved.
//  scene for the game start

import SpriteKit


class GameScene: SKScene {
    let playButton = SKSpriteNode(imageNamed: "play")
    
    override func didMoveToView(view: SKView) {
        self.playButton.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        self.addChild(playButton)
        self.backgroundColor = SKColor.whiteColor()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if self.nodeAtPoint(location) == self.playButton{
                var scene = LevelOne(size: self.size)
                let skView = self.view as SKView!
                skView?.ignoresSiblingOrder = true
                scene.scaleMode = .AspectFill
                scene.size = skView.bounds.size
                skView.presentScene(scene)
                
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
