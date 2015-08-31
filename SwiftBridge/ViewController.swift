//
//  ViewController.swift
//  SwiftBridge
//
//  Created by Dave Hards on 2015-08-27.
//  Copyright (c) 2015 Dave Hards. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    var instanceOfPropellerDelegate: PropellerListener? = nil

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        instanceOfPropellerDelegate = PropellerListener()
        
        
        
        var _psdk = PropellerSDK.instance
        _psdk()!.syncChallengeCounts()

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func LaunchButton(sender: UIButton)
    {
        var _psdk = PropellerSDK.instance
        _psdk()!.launch(instanceOfPropellerDelegate)
    }

    @IBAction func SetWin(sender: AnyObject)
    {
        let randomScoreadd = Int(arc4random_uniform(10000))
        instanceOfPropellerDelegate?.submitMatchResult(10000 + randomScoreadd)
    }
    
    @IBAction func SetLose(sender: AnyObject)
    {
        let randomScoreadd = Int(arc4random_uniform(500))
        instanceOfPropellerDelegate?.submitMatchResult(500 + randomScoreadd)
    }
    
}




