import SpriteKit

class LevelOne: SKScene, SKPhysicsContactDelegate{
    let map = SKSpriteNode(imageNamed: "levelone2")
    let hero = Hero()
    let hud  = HudLayout(imageNamed:"levelone2")
    var joint: SKPhysicsJoint!
    var timercount = 0
    let totalcount = 6000
    var grade = 0
    
    //pop out result panel
    var show_result = ResultPanel();
    
    enum ColliderType:UInt32{
        case Hero = 1
        case Block = 2
        case Tool = 4
        case Star = 8
    }
    
    override func  didMoveToView(view: SKView) {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        self.physicsWorld.contactDelegate   = self
        self.physicsWorld.gravity = CGVectorMake(0, -3)
        map.position = CGPointMake(CGRectGetMidX(self.frame)-150,CGRectGetMidY(self.frame))
        hud.position = CGPointMake(CGRectGetMidX(self.frame)-150,CGRectGetMidY(self.frame))
        let offsetX = map.frame.size.width * map.anchorPoint.x;
        let offsetY = map.frame.size.height * map.anchorPoint.y;
        // bolock1
        let block1 = SKSpriteNode()
        var path1 = CGPathCreateMutable()
        CGPathMoveToPoint(path1, nil, 7 - offsetX, 554 - offsetY);
        CGPathAddLineToPoint(path1, nil, 476 - offsetX, 554 - offsetY);
        CGPathAddLineToPoint(path1, nil, 472 - offsetX, 14 - offsetY);
        CGPathAddLineToPoint(path1, nil, 7 - offsetX, 2 - offsetY);
        CGPathCloseSubpath(path1)
        block1.physicsBody = SKPhysicsBody(polygonFromPath: path1)
        setPhysicalForBlock(block1)
        //block2
        let block2 = SKSpriteNode()
        var path2 = CGPathCreateMutable()
        CGPathMoveToPoint(path2, nil, 800 - offsetX, 545 - offsetY);
        CGPathAddLineToPoint(path2, nil, 800 - offsetX, 434 - offsetY);
        CGPathAddLineToPoint(path2, nil, 1000 - offsetX, 434 - offsetY);
        CGPathAddLineToPoint(path2, nil, 1000 - offsetX, 11 - offsetY);
        CGPathAddLineToPoint(path2, nil, 1151 - offsetX, 11 - offsetY);
        CGPathAddLineToPoint(path2, nil, 1151 - offsetX, 545 - offsetY);
        CGPathCloseSubpath(path2)
        block2.physicsBody = SKPhysicsBody(polygonFromPath: path2)
        setPhysicalForBlock(block2)
        //block3
        let block3 = SKSpriteNode()
        var path3 = CGPathCreateMutable()
        CGPathMoveToPoint(path3, nil, 1634 - offsetX, 770 - offsetY);
        CGPathAddLineToPoint(path3, nil, 1634 - offsetX, 5 - offsetY);
        CGPathAddLineToPoint(path3, nil, 1454 - offsetX, 5 - offsetY);
        CGPathAddLineToPoint(path3, nil, 1454 - offsetX, 770 - offsetY);
        CGPathCloseSubpath(path3)
        block3.physicsBody = SKPhysicsBody(polygonFromPath: path3)
        setPhysicalForBlock(block3)
        //block4
        let block4 = SKSpriteNode()
        var path4 = CGPathCreateMutable()
        CGPathMoveToPoint(path4, nil, 1630 - offsetX, 645 - offsetY);
        CGPathAddLineToPoint(path4, nil, 1630 - offsetX, 1 - offsetY);
        CGPathAddLineToPoint(path4, nil, 2042 - offsetX, 1 - offsetY);
        CGPathAddLineToPoint(path4, nil, 2042 - offsetX, 645 - offsetY);
        CGPathCloseSubpath(path4)
        block4.physicsBody = SKPhysicsBody(polygonFromPath: path4)
        setPhysicalForBlock(block4)
        //star
        let star = Star(imageNamed:"star")
        star.position = CGPointMake(700, 500)
        let star2 = Star(imageNamed: "star")
        star2.position = CGPointMake(300, 227)
        let star3 = Star(imageNamed: "star")
        star3.position = CGPointMake(-400, -127)
        map.addChild(star)
        map.addChild(star2)
        map.addChild(star3)
        //hero
        hero.position = CGPointMake(300 - offsetX, 560 - offsetY)
        //hero.setScale(2)
        map.addChild(hero)
        map.addChild(block1)
        map.addChild(block2)
        map.addChild(block3)
        map.addChild(block4)
        //fail
        //fail button
        //show_result.addNodeToMap(map);
        self.addChild(hud)
        self.addChild(map)
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self.hud)
            if hud.rightMoveButton.containsPoint(location) {
                //self.hero.physicsBody?.applyImpulse(CGVectorMake(60, 0))
                self.hero.physicsBody?.velocity.dx = 150
                hero.startAnimation("right")
                hud.rightMoveButton.texture = SKTexture(imageNamed: "rightArrow1")
            }
            if hud.leftMoveButton.containsPoint(location) {
               // self.hero.physicsBody?.applyImpulse(CGVectorMake(-60, 0))
                self.hero.physicsBody?.velocity.dx = -150
                hud.leftMoveButton.texture = SKTexture(imageNamed: "leftArrow1")
                hero.startAnimation("left")
            }
            if hud.jumpButton.containsPoint(location) {
                hud.jumpButton.texture = SKTexture(imageNamed: "jumpArrow1")
                if self.hero.physicsBody?.velocity.dy <= 0.2 && self.hero.physicsBody?.velocity.dy >= -0.2 {
                   // self.hero.physicsBody?.applyImpulse(CGVectorMake(0, 250))
                    self.hero.physicsBody?.velocity.dy = 400
                    hero.startAnimation("jump")
                    println("jump tapped!")
                }
               
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
            
            if hud.returnButton.containsPoint(location) {
                rebeginscene()
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self.hud)
            if hud.rightMoveButton.containsPoint(location) {
                hud.rightMoveButton.texture = SKTexture(imageNamed: "rightArrow2")
            }
            if hud.leftMoveButton.containsPoint(location) {
                hud.leftMoveButton.texture = SKTexture(imageNamed: "leftArrow2")
            }
            if hud.jumpButton.containsPoint(location) {
                hud.jumpButton.texture = SKTexture(imageNamed: "jumpArrow2")
            }
        }

    }
    
    func setPhysicalForBlock(block : SKSpriteNode) {
        block.physicsBody!.dynamic          = false
        block.physicsBody!.categoryBitMask  = ColliderType.Block.rawValue
        // block.physicsBody!.contactTestBitMask = ColliderType.Hero.rawValue | ColliderType.Tool.rawValue
        block.physicsBody!.collisionBitMask = ColliderType.Hero.rawValue | ColliderType.Tool.rawValue
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        if self.hero.physicsBody?.velocity.dx == 0 && self.hero.physicsBody?.velocity.dy == 0 {
            self.hero.startAnimation("stop")
        }
        //fail
        if self.hero.position.y < -550 {
             successOrFail(0)
        }
        //sucess
        if self.hero.position.x > 880 {
            successOrFail(1)
        }
        if self.hud.myLabel.text.toInt() == 5 {
             shakeCamera()
        }
        //fail
        if self.hud.myLabel.text.toInt() == 0{
            successOrFail(0)
            
        }
        timercount+=1
        var timeLeft = totalcount - timercount
        self.hud.myLabel.text = toString(timeLeft/100)
    }
    
    func rebeginscene(){
        self.hud.removeAllChildren()
        var scene                           = LevelOne(size: self.size)
        let skView                          = self.view as SKView!
        skView?.ignoresSiblingOrder         = true
        scene.scaleMode                     = .AspectFill
        //scene.size                          = skView.bounds.size
        skView.presentScene(scene)
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
        s.position = CGPointMake(1090,  80 - n * 60)
        map.addChild(s)
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
    
    func successOrFail(result: Int32)
    {
        if result == 0 {
            hud.myLabel.hidden = true
            show_result.setFail(false)
            self.hud.myLabel.text = toString(100)
        }
        else if result == 1{
            hero.hidden = true
            show_result.setSuccess(false)
            hud.myLabel.hidden = true
            self.hud.myLabel.text = toString(100)

        }
    }
    
    
}