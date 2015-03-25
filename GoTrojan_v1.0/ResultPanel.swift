//
//  ResultPanel.swift
//  GoTrojan_v1.0
//
//  Created by wei leng on 3/23/15.
//  Copyright (c) 2015 University of Southern California. All rights reserved.
//

import SpriteKit

class ResultPanel {
    //fail button
    let fail : SKSpriteNode
    let repeat: SKSpriteNode
    let menu : SKSpriteNode
    //success button
    let success1: SKSpriteNode
    let again : SKSpriteNode
    let next : SKSpriteNode
    
    let stars:[SKSpriteNode] = []
    
    init() {
        self.fail = SKSpriteNode(imageNamed:"fail");
        self.repeat = SKSpriteNode(imageNamed:"repeat")
        self.menu = SKSpriteNode(imageNamed:"menu")
        //*** success button
        self.success1 = SKSpriteNode(imageNamed: "success")
        self.again = SKSpriteNode(imageNamed: "again")
        self.next = SKSpriteNode(imageNamed: "next")
        
        for var i = 0 ; i < 3 ; i++ {
            var temp = SKSpriteNode(imageNamed: "stars");
            stars.append(temp)
        }
        
    }
    
    func addNodeToMap(map : SKScene){
        fail.position = CGPoint(x: map.size.width / 2 , y:map.size.height / 2)
        fail.zPosition = 1;
        fail.hidden = true
        map.addChild(fail)
        
        menu.position = CGPoint(x: map.size.width / 2, y:map.size.height / 2 )
        menu.zPosition = 1
        menu.hidden = true
        map.addChild(menu)
        
        repeat.position = CGPoint(x: map.size.width / 2, y:map.size.height / 2 - 150)
        repeat.zPosition = 1
        repeat.hidden = true;
        map.addChild(repeat)
        //success button
        success1.position = CGPoint(x: map.size.width / 2, y:map.size.height / 2)
        success1.zPosition = 1
        success1.hidden = true
        map.addChild(success1)
        
        again.position = CGPoint(x: map.size.width / 2 - 200, y:map.size.height / 2 - 120)
        again.zPosition = 1
        again.hidden = true
        map.addChild(again)
        
        next.position = CGPoint(x: map.size.width / 2 + 200, y:map.size.height / 2 - 120)
        next.zPosition = 1
        next.hidden = true
        map.addChild(next)
        
        
        for var i = 0 ; i < stars.count ; i++ {
            success1.addChild(stars[i]);
            stars[i].zPosition = 1
            stars[i].hidden = true
            stars[i].position = CGPoint(x: 172 + CGFloat(i * 58) , y: 4 )
           
        }
    }
    
    func setFail(flag : Bool){
        fail.hidden = flag
        menu.hidden = flag
        repeat.hidden = flag
    }
    
    func setSuccess(flag : Bool){
        success1.hidden = flag
        again.hidden = flag
        next.hidden = flag
    }
    
    func isClickButton(location : CGPoint) -> String{
        if menu.hidden==false && menu.containsPoint(location){
            //点击返回选择菜单
            return "menu"
        }
        if again.hidden==false && again.containsPoint(location){
            return "again"
        }
        if next.hidden==false && next.containsPoint(location){
            return "next"
        }
        
        if repeat.hidden==false && repeat.containsPoint(location){
            return "repeat"
        }
        
        return "noAction"
    }
    
    func showStarts(grades : Int) {
        for var i = 0 ; i < grades ; i++ {
            stars[i].hidden = false
        }
    }
    
}
