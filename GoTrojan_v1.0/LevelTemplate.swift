//
//  LevelTemplate.swift
//  GoTrojan_v1.0
//
//  Created by simon sun on 3/4/15.
//  Copyright (c) 2015 University of Southern California. All rights reserved.
//
import SpriteKit

class LevelTemplate : SKScene, SKPhysicsContactDelegate{
    
    // map parameters
    var offsetX:CGFloat = 0.0
    var offsetY:CGFloat = 0.0
    let map:SKSpriteNode
    var image:NSString
    // hero
    let hero = Hero()
    // button
    let leftMoveButton = SKSpriteNode(imageNamed: "leftArrow1")
    let rightMoveButton = SKSpriteNode(imageNamed: "rightArrow1")
    let jumpButton = SKSpriteNode(imageNamed: "jumpArrow1")
    let returnButton = SKSpriteNode(imageNamed: "return")
    
    //pop up menu as result panel
    var show_result = ResultPanel()
    
    // label
    var myLabel = SKLabelNode()
    var timercount = 0
    let totalcount = 6000
    let hudWidth:CGFloat = 150.0
    // box number
    var num_left_right_box = 0
    var num_down_up_box = 0
    var grade = 0
    
    enum ColliderType:UInt32{
        case Hero = 1
        case Block = 2
        case Tool = 4
        case Star = 8
    }
    init(size: CGSize, image: NSString, num_left_right_box:Int, num_down_up_box:Int ) {
        self.image = image
        self.num_left_right_box = num_left_right_box
        self.num_down_up_box = num_down_up_box
        map = SKSpriteNode(imageNamed:image)
        super.init(size : size)
        //init map
        map.position = CGPointMake(CGRectGetMidX(self.frame)-hudWidth,CGRectGetMidY(self.frame))
        offsetX = map.frame.size.width * map.anchorPoint.x;
        offsetY = map.frame.size.height * map.anchorPoint.y;
        self.addChild(map)
        
        //physical word
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: self.frame.width - hudWidth, height: self.frame.height))
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, -3)
        
        //function button position
        self.leftMoveButton.position = CGPointMake(CGRectGetMinX(map.frame)+240,CGRectGetMinY(map.frame)+150)
        self.rightMoveButton.position = CGPointMake(CGRectGetMinX(map.frame)+420,CGRectGetMinY(map.frame)+150)
        self.jumpButton.position = CGPointMake(CGRectGetMinX(map.frame)+1800,CGRectGetMinY(map.frame)+150)
        self.returnButton.position = CGPointMake(CGRectGetMaxX(map.frame)+hudWidth/2,CGRectGetMaxY(map.frame)-50)
        
        //label
        myLabel = SKLabelNode(fontNamed: "Arial")
        myLabel.text = "time"
        myLabel.fontSize = 20
        myLabel.position = CGPointMake(CGRectGetMaxX(map.frame) + hudWidth/2, CGRectGetMaxY(map.frame)-150)
        
        // boxes
        for t in 0...num_left_right_box {
            let leftToRightBox = Tools(imageNamed: "left_right_box", type:0)
            leftToRightBox.position = CGPointMake(CGRectGetMaxX(map.frame) + hudWidth/2, CGRectGetMaxY(map.frame)-250)
            self.addChild(leftToRightBox)
        }
        for t in 0...num_down_up_box {
            let downToUpBox = Tools(imageNamed: "up_down_box", type:1)
            downToUpBox.position = CGPointMake(CGRectGetMaxX(map.frame) + hudWidth/2, CGRectGetMaxY(map.frame)-450)
            self.addChild(downToUpBox)
        }
        
        self.addChild(leftMoveButton)
        self.addChild(rightMoveButton)
        self.addChild(jumpButton)
        self.addChild(returnButton)
        self.addChild(myLabel)
        
        // add menu to Scene
        show_result.addNodeToMap(self)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if rightMoveButton.containsPoint(location) {
                self.hero.physicsBody?.velocity.dx = 120
                hero.startAnimation("right")
                rightMoveButton.texture = SKTexture(imageNamed: "rightArrow1")
            }
            if leftMoveButton.containsPoint(location) {
                self.hero.physicsBody?.velocity.dx = -120
                leftMoveButton.texture = SKTexture(imageNamed: "leftArrow1")
                hero.startAnimation("left")
            }
            if jumpButton.containsPoint(location) {
                jumpButton.texture = SKTexture(imageNamed: "jumpArrow1")
                if self.hero.physicsBody?.velocity.dy <= 0.2 && self.hero.physicsBody?.velocity.dy >= -0.2 {
                    self.hero.physicsBody?.velocity.dy = 300
                    hero.startAnimation("jump")
                }
                
            }
            if returnButton.containsPoint(location) {
                rebeginscene()
            }
            var clickAction = show_result.isClickButton(location)
            if clickAction == "menu" {
                //点击返回选择菜单
                var scene = SelectScene(size:CGSize(width: 2048, height: 1536))
                let skView = self.view as SKView!
                skView?.ignoresSiblingOrder = true
                scene.scaleMode = .AspectFill
                skView.presentScene(scene)
                
            }
            if clickAction == "again"{
                rebeginscene()
            }
            if clickAction == "next"{
                //next
            }
            
            if clickAction == "repeat" {
                rebeginscene()
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if rightMoveButton.containsPoint(location) {
                rightMoveButton.texture = SKTexture(imageNamed: "rightArrow2")
            }
            if leftMoveButton.containsPoint(location) {
                leftMoveButton.texture = SKTexture(imageNamed: "leftArrow2")
            }
            if jumpButton.containsPoint(location) {
                jumpButton.texture = SKTexture(imageNamed: "jumpArrow2")
            }
        }
        
    }
    
    func setPhysicalForBlock(block : SKSpriteNode) {
        block.physicsBody!.dynamic          = false
        block.physicsBody!.categoryBitMask  = ColliderType.Block.rawValue
        block.physicsBody!.collisionBitMask = ColliderType.Hero.rawValue | ColliderType.Tool.rawValue
    }
    
    override func update(currentTime: NSTimeInterval) {
        if self.hero.physicsBody?.velocity.dx == 0 && self.hero.physicsBody?.velocity.dy == 0 {
            self.hero.startAnimation("stop")
        }
        //game over
        if self.hero.position.y < -550 {
            //rebeginscene()
            successOrFail(0)
        }
        //game success:change to reach a bear
        //println(self.hero.position.x)
        if self.hero.position.x > 850 {
            //rebeginscene()
            successOrFail(1)
            show_result.showStarts(grade)
        }
        if self.myLabel.text.toInt() == 5 {
            shakeCamera()
        }
        //time out
        if self.myLabel.text.toInt() == 0{
            //rebeginscene()
            successOrFail(0)
        }
        timercount+=1
        var timeLeft = totalcount - timercount
        self.myLabel.text = toString(timeLeft/100)
    }
    
    func rebeginscene(){
        //self.hud.removeAllChildren()
        var scene = LevelTwo(size: self.size, image:image, num_left_right_box:num_left_right_box,num_down_up_box:num_down_up_box)
        let skView = self.view as SKView!
        skView?.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        //scene.size = skView.bounds.size
        skView.presentScene(scene)
    }
    
    func shakeCamera() {
        let numberOfShakes = 20;
        var actionsArray:[SKAction] = [];
        for index in 1...Int(numberOfShakes) {
            // build a new random shake and add it to the list
            let moveX = CGFloat(Float(arc4random()) / Float(UINT32_MAX));
            let moveY =  CGFloat(Float(arc4random()) / Float(UINT32_MAX));
            let maintain: NSTimeInterval = 0.1;
            let shakeAction = SKAction.moveByX(moveX*2, y: moveY*2, duration: maintain);
            shakeAction.timingMode = SKActionTimingMode.EaseOut;
            actionsArray.append(shakeAction);
            actionsArray.append(shakeAction.reversedAction());
        }
        let actionSeq = SKAction.sequence(actionsArray);
        self.map.runAction(actionSeq);
    }
    func didBeginContact(contact:SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        var temp: SKSpriteNode!
        if collision == ColliderType.Hero.rawValue | ColliderType.Star.rawValue {
            if contact.bodyA.categoryBitMask == ColliderType.Hero.rawValue {
                temp = contact.bodyB.node as SKSpriteNode
            }else {
                temp = contact.bodyA.node as SKSpriteNode
            }
            //when hero encouncer the star
            temp.removeFromParent()
            grade++;
            addStar(CGFloat(grade))
        }
    }
    func addStar(n :CGFloat) {
        let s = SKSpriteNode(imageNamed: "star")
        s.position = CGPointMake(2125-offsetX,  350 - offsetY - n * 60)
        map.addChild(s)
    }
    
    func successOrFail(result: Int32)
    {
        if result == 0 {
            myLabel.hidden = true
            show_result.setFail(false)
            myLabel.text = toString(100)
        }
        else if result == 1{
            hero.hidden = true
            show_result.setSuccess(false)
            myLabel.hidden = true
            myLabel.text = toString(100)
            
        }
    }


}