//
//  HubLayout.swift
//  GoTrojan_v1.0
//
//  Created by simon sun on 2/13/15.
//  Copyright (c) 2015 University of Southern California. All rights reserved.
//

import Foundation

import SpriteKit

class HudLayout: SKSpriteNode{
    let leftMoveButton = SKSpriteNode(imageNamed: "leftArrow1")
    let rightMoveButton = SKSpriteNode(imageNamed: "rightArrow1")
    let jumpButton = SKSpriteNode(imageNamed: "jumpArrow1")
    let returnButton = SKSpriteNode(imageNamed: "return")
    var myLabel = SKLabelNode()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: SKColor.whiteColor(), size:texture.size())
        //function button
        self.leftMoveButton.position = CGPointMake(CGRectGetMinX(self.frame)+240,CGRectGetMinY(self.frame)+150)
        self.rightMoveButton.position = CGPointMake(CGRectGetMinX(self.frame)+420,CGRectGetMinY(self.frame)+150)
        self.jumpButton.position = CGPointMake(CGRectGetMinX(self.frame)+1800,CGRectGetMinY(self.frame)+150)
        self.returnButton.position = CGPointMake(CGRectGetMaxX(self.frame)+70,CGRectGetMaxY(self.frame)-50)

        //label
        myLabel = SKLabelNode(fontNamed: "Arial")
        myLabel.text = "time"
        myLabel.fontSize = 20
        myLabel.position = CGPointMake(CGRectGetMaxX(self.frame) + 70, CGRectGetMaxY(self.frame)-150)
        
        // boxes
        for t in 0...1 {
            let leftToRightBox = Tools(imageNamed: "left_right_box", type:0)
            leftToRightBox.position = CGPointMake(CGRectGetMaxX(self.frame) + 70, CGRectGetMaxY(self.frame)-250)
            self.addChild(leftToRightBox)
        }
        var downToUpBox = Tools(imageNamed: "up_down_box", type:1)
        downToUpBox.position = CGPointMake(CGRectGetMaxX(self.frame) + 70, CGRectGetMaxY(self.frame)-450)
        
        self.addChild(leftMoveButton)
        self.addChild(rightMoveButton)
        self.addChild(jumpButton)
        self.addChild(returnButton)
        self.addChild(myLabel)
        self.addChild(downToUpBox)

    }
    


}

