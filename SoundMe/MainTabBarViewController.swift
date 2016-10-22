//
//  MainTabBarViewController.swift
//  SoundMe
//
//  Created by dror gal on 06/08/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let aTabArray: [UITabBarItem] = tabBar.items!
        self.tabBar.tintColor = UIColor.white

        for item in aTabArray {
            item.image = item.image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(red: CGFloat(1), green: CGFloat(1), blue: CGFloat(1), alpha: CGFloat(1))], for: UIControlState())
         

        }
//        let urlstring = "https://ia601409.us.archive.org/20/items/UsaNationalAnthemFromSilo/silosinging-us-anthem_64kb.mp3"
//        let url = NSURL(string: urlstring)
//        print("the url = \(url!)")
//        downloadFileFromURL(url: url!)
        
    }

//    func downloadFileFromURL(url:NSURL){
//        var downloadTask:URLSessionDownloadTask
//        downloadTask = URLSession.shared.downloadTask(with: url as URL, completionHandler: { (URL, response, error) -> Void in
//            
//            SongManager.Instance.saveURL(url: URL!)
//            //self.play(url: URL!)
//            
//        })
//        
//        downloadTask.resume()
//        
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
