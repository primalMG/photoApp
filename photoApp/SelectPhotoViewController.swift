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
    var lineColour = UIColor.black
    var lineWidth: CGFloat = 5.0
    var endPoint = CGPoint.zero
    var swipe = false
    var opacity: CGFloat = 1.0
    
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            guard let url = selectedImage?.regular else { return }
            
            imageView.loadingImgWithCache(url)
        }
    }
    
    @IBOutlet weak var drawImageView: UIImageView!
    
    @IBAction func photoShare(_ sender: Any) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        guard let image = imageView.image else { return }
        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func btnReset(_ sender: Any) {
        drawImageView.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        endPoint = touch.location(in: view)
        swipe = false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        swipe = true
        let currentPoint = touch.location(in: view)
        DrawShape(from: endPoint, to: currentPoint)
        endPoint = currentPoint
    }
    
    func DrawShape(from startPoint: CGPoint, to endPoint: CGPoint){
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        imageView.image?.draw(in: view.bounds)
        
        context.move(to: startPoint)
        context.addLine(to: endPoint)
        context.setLineCap(.square)
        context.setBlendMode(.normal)
        context.setLineWidth(lineWidth)
        context.setStrokeColor(colourWheel().cgColor)
        
        context.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        imageView.alpha = opacity
        
        UIGraphicsEndImageContext()
    }
    
    
    func random () -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    func colourWheel () -> UIColor {
        return UIColor(red: self.random(), green: self.random(), blue: self.random(), alpha: 1.0)
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
