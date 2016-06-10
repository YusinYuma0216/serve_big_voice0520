//
//  homeViewController.swift
//  test_home
//
//  Created by Yuma Yamamoto on 2016/02/12.
//  Copyright © 2016年 Yuma Yamamoto. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {    //追加してね
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    @IBAction func StartRecord() {
        self.performSegueWithIdentifier("StartRecord", sender: nil)
    }
    
    func setImage(image: UIImage) {
        let targetSB = UIStoryboard(name: "Main", bundle: nil)
        let targetVC: RecordingViewController = targetSB.instantiateInitialViewController() as! RecordingViewController 
        targetVC.bgImage = image
        
        
        
    }
    
    func pickImageFromLibrary() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {    //追記
            
            //写真ライブラリ(カメラロール)表示用のViewControllerを宣言しているという理解
            let controller = UIImagePickerController()
            
            //おまじないという認識で今は良いと思う
            controller.delegate = self
            
            //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
            //以下はカメラロールの例
            //.Cameraを指定した場合はカメラを呼び出し(シミュレーター不可)
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            //新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String: AnyObject]) {
        
        //このif条件はおまじないという認識で今は良いと思う
        if didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] != nil {
            
            //didFinishPickingMediaWithInfo通して渡された情報(選択された画像情報が入っている？)をUIImageにCastする
            //そしてそれを宣言済みのimageViewへ放り込む
//            imageFromCameraRoll.image = didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as? UIImage
            //
            
            setImage((didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as? UIImage)!)
        }
        
        //写真選択後にカメラロール表示ViewControllerを引っ込める動作
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func pressCameraRoll(sender: AnyObject) {
        pickImageFromLibrary()  //ライブラリから写真を選択する
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
