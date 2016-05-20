//
//  CountdownViewController.swift
//  test_home
//
//  Created by Yuma Yamamoto on 2016/02/12.
//  Copyright © 2016年 Yuma Yamamoto. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    var count: Int = 3
    var timer: NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector: #selector(CountdownViewController.onUpdate), userInfo:nil,repeats:true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onUpdate() {
        
        count = count - 1
        
        if count == 0 {
            self.performSegueWithIdentifier("toNext", sender: nil)
        }
        
        
        //countが０になったら次の画面に
        
        
        label.text = String(format: "%d",count)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
