//
//  ViewController.swift
//  DownloadImagesDemo
//
//  Created by HeYilei on 6/09/2015.
//  Copyright (c) 2015 HeYilei. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    @IBOutlet weak var imageView1:UIImageView!
    @IBOutlet weak var imageView2:UIImageView!
    @IBOutlet weak var imageView3:UIImageView!
    @IBOutlet weak var imageView4:UIImageView!
    @IBOutlet weak var imageView5:UIImageView!
    @IBOutlet weak var imageView6:UIImageView!
    
    let urlStrings = [
        "https://farm1.staticflickr.com/649/20718255592_b9ae2c78a3_b.jpg",
        "https://farm1.staticflickr.com/741/20730241532_2cbacb377c_b.jpg",
        "https://farm6.staticflickr.com/5730/20735277275_06179836e2_b.jpg",
        "https://farm6.staticflickr.com/5775/20747091191_df05888526_b.jpg",
        "https://farm1.staticflickr.com/708/20730188882_700d004af1_b.jpg",
        "https://farm1.staticflickr.com/709/20734995351_45e5e80b9f_b.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = false
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func downloadIamge1(button:UIButton){
        /* Grand Central Dispatch */
    
        /* Update Button UI */
        let originalTitle = button.titleLabel!.text
        button.setTitle("Downloading...", forState: UIControlState.Normal)
        button.enabled = false
        
        /* Prepare URL */
        let url = NSURL(string: self.urlStrings[0])!
        
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            /* download */
            let data = NSData(contentsOfURL: url)
            
            /* validation */
            if data == nil { return }
            
            /* fetch image */
            if let image = UIImage(data: data!) {
                dispatch_async(dispatch_get_main_queue()){
                    /* update UI */
                    self.imageView1.image = image
                    button.setTitle(originalTitle, forState: .Normal)
                    button.enabled = true
                }
            }
            
        }
        
    }
    
    @IBAction func downloadIamge2(button:UIButton){
        /* NSURLConnection */
        /* Deprecated in iOS 9.0. */
        
        /* Update Button UI */
        let originalTitle = button.titleLabel!.text
        button.setTitle("Downloading...", forState: UIControlState.Normal)
        button.enabled = false

        /* Prepare URL */
        let url = NSURL(string: self.urlStrings[1])!
        
        /* Prepare Request */
        let request = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 10.0)
        
        /* Download */
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response, data, error) -> Void in
            /* Validation */
            if data == nil {
                print("Download failed with error\(error.localizedDescription)")
                return
            }
            
            /* Update UI */
            if let image = UIImage(data: data) {
                self.imageView2.image = image
                button.setTitle(originalTitle, forState: .Normal)
                button.enabled = true
            }
            
        }
    }
    
    @IBAction func downloadIamge3(button:UIButton){
        /* NSURLSession */
        /* This can be a replacement of NSURLConnection */
        
        /* Update Button UI */
        let originalTitle = button.titleLabel!.text
        button.setTitle("Downloading...", forState: UIControlState.Normal)
        button.enabled = false
        
        let url = NSURL(string: self.urlStrings[2])!
        var request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        /* configure request */
        request.HTTPMethod = "POST"
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) -> Void in
            print("Response: \(response)")
            
            /* Validation */
            if data == nil {
                print("Download failed with error\(error.localizedDescription)")
                return
            }
            
            /* Update UI */
                
            if let image = UIImage(data: data) {
                dispatch_async(dispatch_get_main_queue()){
                    self.imageView3.image = image
                    button.setTitle(originalTitle, forState: .Normal)
                    button.enabled = true
                }
            }
        })
        
        task.resume()
    }
    
    @IBAction func downloadIamge4(button:UIButton){
        /* NSURLSession: download to file system */
        
        /* Update Button UI */
        let originalTitle = button.titleLabel!.text
        button.setTitle("Downloading...", forState: UIControlState.Normal)
        button.enabled = false
        
        let url = NSURL(string: self.urlStrings[3])!
        let session = NSURLSession.sharedSession()
        let task = session.downloadTaskWithURL(url, completionHandler: {
            (url, response, error) -> Void in
            print("Response: \(response)")
            
            let data = NSData(contentsOfURL: url)
            /* Validation */
            if data == nil {
                print("Download failed with error\(error.localizedDescription)")
                return
            }
            
            /* Update UI */
            if let image = UIImage(data: data!) {
                dispatch_async(dispatch_get_main_queue()){
                    self.imageView4.image = image
                    button.setTitle(originalTitle, forState: .Normal)
                    button.enabled = true
                }
            }
            
            /* save file */
            let destinationString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] 
            let destinationPathString = destinationString.stringByAppendingPathComponent("image.jpg")
            let destinationURL = NSURL(fileURLWithPath: destinationPathString)
            var error:NSError?
            do {
                try NSFileManager.defaultManager().moveItemAtURL(url, toURL: destinationURL)
            } catch var error1 as NSError {
                error = error1
                print(error?.localizedDescription)
            } catch {
                fatalError()
            }
            
        })
        
        task.resume()
    }
    
    @IBAction func downloadIamge5(button:UIButton){
        /* AFNetworking */
        let url = NSURL(string: urlStrings[4])!
        imageView5.setImageWithURL(url, placeholderImage: nil)
    }
    
    @IBAction func downloadIamge6(button:UIButton){
        
    }

}

