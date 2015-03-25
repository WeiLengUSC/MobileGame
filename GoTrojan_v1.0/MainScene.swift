//
//  MainScene.swift
//  ZombieConga
//
//  Created by wei leng on 2/23/15.
//  Copyright (c) 2015 wei leng. All rights reserved.
//

import Foundation
import SpriteKit
class MainScene: SKScene {
    //let trojan: SKSpriteNode = SKSpriteNode(imageNamed: "trojan2")
    let play: SKSpriteNode = SKSpriteNode(imageNamed: "play")
    let score: SKSpriteNode = SKSpriteNode(imageNamed: "score")
    let music: SKSpriteNode = SKSpriteNode(imageNamed: "music")
    let sound: SKSpriteNode = SKSpriteNode(imageNamed: "sound")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        let background = SKSpriteNode(imageNamed: "trojan")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        addChild(background)
        
        let mySize = background.size
        println("Size: \(mySize)")
        
        play.position = CGPoint(x: 1850, y: 1200)
        addChild(play)
        
        score.position = CGPoint(x: 1850, y: 900)
        addChild(score)
        
        music.position = CGPoint(x: 1775, y: 600)
        addChild(music)
        
        sound.position = CGPoint(x: 1950, y: 600)
        addChild(sound)
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if self.nodeAtPoint(location) == self.play{
                var scene = SelectScene(size:CGSize(width: 2048, height: 1536))
                let skView = self.view as SKView!
                skView?.ignoresSiblingOrder = true
                scene.scaleMode = .AspectFill
                skView.presentScene(scene)
            }
        }
    }
    
}

