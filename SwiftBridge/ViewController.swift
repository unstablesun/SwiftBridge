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

}

