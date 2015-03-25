//
//  GameViewController.swift
//  ZombieConga
//
//  Created by wei leng on 1/26/15.
//  Copyright (c) 2015 wei leng. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var scene = LevelTwo(size:CGSize(width: 2048, height: 1536), image:"levelone2", num_left_right_box:2, num_down_up_box:1)
        let skView = self.view as SKView!
        skView?.ignoresSiblingOrder = true
        //skView.showsFPS = true
        //skView.showsNodeCount = true
        skView.showsPhysics = true
        scene.scaleMode                     = .AspectFill
        //scene.size                          = skView.bounds.size
        skView.presentScene(scene)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
