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

    var instanceOfPropellerHandler: PropellerHandler? = nil
    
    @IBOutlet weak var StatusLabel: UILabel!
    @IBOutlet weak var LaunchButton: UIButton!
    @IBOutlet weak var WinButton: UIButton!
    @IBOutlet weak var LoseButton: UIButton!
    @IBOutlet weak var ChallengeCount: UILabel!
    
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
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "ReceivedChallengeCount:",
            name: "PropellerSDKReceivedChallengeCount",
            object: nil)

        
        instanceOfPropellerHandler = PropellerHandler()
        
        
        var _psdk = PropellerSDK.instance
        _psdk()!.syncChallengeCounts()
        
        
        LaunchButton.enabled = true;
        WinButton.enabled = false;
        LoseButton.enabled = false;

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

    @objc func MatchReadyForPlay(notification: NSNotification)
    {
        StatusLabel.text = "Match Data Ready"
        
        LaunchButton.enabled = false;
        WinButton.enabled = true;
        LoseButton.enabled = true;
    }
    
    @objc func SdkCompletedWithExit(notification: NSNotification)
    {
        StatusLabel.text = "SDK Clean Exit"
    }
    
    @objc func ReceivedChallengeCount(notification: NSNotification)
    {
        StatusLabel.text = "Recieved CC"
        
        let _count = notification.object as! NSNumber
        ChallengeCount.text = _count.stringValue
    }

    
    @IBAction func LaunchButton(sender: UIButton)
    {
        var _psdk = PropellerSDK.instance
        _psdk()!.launch(instanceOfPropellerHandler)
    }

    @IBAction func SetWin(sender: AnyObject)
    {
        let randomScoreadd = Int(arc4random_uniform(10000))
        instanceOfPropellerHandler?.submitMatchResult(10000 + randomScoreadd)
        
        StatusLabel.text = "Win Set"
        
        var _psdk = PropellerSDK.instance
        _psdk()!.launch(instanceOfPropellerHandler)
        
        LaunchButton.enabled = true;
        WinButton.enabled = false;
        LoseButton.enabled = false;
    }
    
    @IBAction func SetLose(sender: AnyObject)
    {
        let randomScoreadd = Int(arc4random_uniform(500))
        instanceOfPropellerHandler?.submitMatchResult(500 + randomScoreadd)
        
        StatusLabel.text = "Lose Set"
        
        var _psdk = PropellerSDK.instance
        _psdk()!.launch(instanceOfPropellerHandler)
        
        LaunchButton.enabled = true;
        WinButton.enabled = false;
        LoseButton.enabled = false;
    }
    
}




