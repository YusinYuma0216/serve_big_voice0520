//
//  ExpressionViewController.swift
//  serve_big_voice0520
//
//  Created by Yuma Yamamoto on 2016/05/21.
//  Copyright © 2016年 Yuma Yamamoto. All rights reserved.
//

import UIKit



class ExpressionViewController: UIViewController {
   
    @IBOutlet var label :UILabel!

    
    var score:  Int!
    var displayScore:  Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(score)
        
        label.text = String(score+80)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    @IBAction func back () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

     var toResultButton: UIButton!


    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


