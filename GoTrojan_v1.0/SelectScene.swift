//
//  SelectScene.swift
//  ZombieConga
//
//  Created by wei leng on 2/16/15.
//  Copyright (c) 2015 wei leng. All rights reserved.
//

import SpriteKit

class SelectScene: SKScene{
    
    let backg = SKSpriteNode(imageNamed: "bg")
    let btnReturn = SKSpriteNode(imageNamed: "return")
    var games:[SKSpriteNode] = []
    
    let playableRect: CGRect
    
    override init(size: CGSize) {
        let maxAspectRatio:CGFloat = 16.0/9.0 // 1
        let playableHeight = size.width / maxAspectRatio // 2
        let playableMargin = (size.height-playableHeight)/2.0 // 3
        playableRect = CGRect(x: 0, y: playableMargin,
            width: size.width,
            height: playableHeight) // 4
        super.init(size: size) // 5
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // 6
    }
    
    override func didMoveToView(view: SKView) {
        backg.zPosition = -1
        addChild(backg)
        backg.position = CGPoint(x: CGRectGetMidX(playableRect) , y: CGRectGetMidY(playableRect))
        
        btnReturn.zPosition = 0
        addChild(btnReturn)
        btnReturn.position = CGPoint(x: CGRectGetMaxX(playableRect) - CGFloat(200) , y: CGRectGetMinY(playableRect) + CGFloat(200))
        
        for var i = 0 ; i < 7; i++ {
            var temp = SKSpriteNode(imageNamed: "frame");
            var row = i / 3;
            var col = i % 3;
            
            temp.position = CGPoint(x: CGRectGetMinX(playableRect) + CGFloat(500 + col*500), y: CGRectGetMaxY(playableRect) - CGFloat(200 + row * 300))
            temp.setScale(0.5)
            addChild(temp)
            games.append(temp)
            }
        
        }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // Loop over all the touches in this event
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            let zoomIn = SKAction.scaleTo(0.8, duration: 0.5)
            let zoomOut = SKAction.scaleTo(0.5, duration: 0.5)
            for temp in games{
                if temp.containsPoint(location){
                    if temp.zPosition == 1{
                        var scene                           = LevelOne(size: self.size)
                        let skView                          = self.view as SKView!
                        skView?.ignoresSiblingOrder         = true
                        scene.scaleMode                     = .AspectFill
                        //scene.size                          = skView.bounds.size
                        skView.presentScene(scene)

                    }
                    else{
                    temp.zPosition = 1
                    temp.runAction(zoomIn)
                    }
                }
                else{
                    if temp.zPosition == 1{
                        temp.zPosition = 0
                        temp.runAction(zoomOut)
                    }
                }
            }
            
            if btnReturn.containsPoint(location)
            {
                let scene = MainScene(size:CGSize(width: 2048, height: 1536))
                // Configure the view.
                let skView = self.view as SKView!
                skView.showsFPS = true
                skView.showsNodeCount = true
                
                //skView.userInteractionEnabled = false
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .AspectFill
                
                skView.presentScene(scene)
            }
            
        }
    }

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            let zoomOut = SKAction.scaleTo(0.5, duration: 0.5)
//            for temp in games{
//                if temp.containsPoint(location){
//                    temp.zPosition = 0
//                    temp.runAction(zoomOut)
//                }
//            }
        }

    }
    
}

