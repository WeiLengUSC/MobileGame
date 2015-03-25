import SpriteKit

class LevelTwo: LevelTemplate{
    
    override func didMoveToView(view: SKView) {
        //map
        map.texture = SKTexture(imageNamed: "levelone2")
        //hero
        hero.position = CGPointMake(300 - offsetX, 560 - offsetY)
        // path
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
        
        //add to the map
        map.addChild(hero)
        map.addChild(block1)
        map.addChild(block2)
        map.addChild(block3)
        map.addChild(block4)
        map.addChild(star)
        map.addChild(star2)
        map.addChild(star3)
        
        //add pop up menu
        //show_result.addNodeToMap(map)
    }
    
}