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
    
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var LaunchButton: UIButton!
    @IBOutlet weak var WinButton: UIButton!
    @IBOutlet weak var LoseButton: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "MatchReadyForPlay:",
            name: "PropellerSDKCompletedWithMatch",
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "SdkCompletedWithExit:",
            name: "PropellerSDKCompletedWithExit",
            object: nil)
        
        instanceOfPropellerDelegate = PropellerListener()
        
        
        var _psdk = PropellerSDK.instance
        _psdk()!.syncChallengeCounts()
        
        
        LaunchButton.enabled = true;
        WinButton.enabled = false;
        LoseButton.enabled = false;

    }
    @objc func MatchReadyForPlay(notification: NSNotification)
    {
        StatusLabel.text = "Match Data Ready - Win or Lose"
        
        LaunchButton.enabled = false;
        WinButton.enabled = true;
        LoseButton.enabled = true;
    }
    @objc func SdkCompletedWithExit(notification: NSNotification)
    {
        StatusLabel.text = "SDK Clean Exit"
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
        
        StatusLabel.text = "Win Set"
        
        var _psdk = PropellerSDK.instance
        _psdk()!.launch(instanceOfPropellerDelegate)
        
        LaunchButton.enabled = true;
        WinButton.enabled = false;
        LoseButton.enabled = false;
    }
    
    @IBAction func SetLose(sender: AnyObject)
    {
        let randomScoreadd = Int(arc4random_uniform(500))
        instanceOfPropellerDelegate?.submitMatchResult(500 + randomScoreadd)
        
        StatusLabel.text = "Lose Set"
        
        var _psdk = PropellerSDK.instance
        _psdk()!.launch(instanceOfPropellerDelegate)
        
        LaunchButton.enabled = true;
        WinButton.enabled = false;
        LoseButton.enabled = false;
    }
    
}




