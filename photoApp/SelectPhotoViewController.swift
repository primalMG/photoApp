//
//  SelectPhotoViewController.swift
//  photoApp
//
//  Created by user136368 on 10/11/18.
//  Copyright © 2018 user136368. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController {

    var selectedImage: Urls?
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            guard let url = selectedImage?.regular else { return }
            
            imageView.loadingImgWithCache(url)
        }
    }
    
    @IBAction func photoShare(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(activityVC, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
