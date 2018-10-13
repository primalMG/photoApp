//
//  SelectPhotoView.swift
//  photoApp
//
//  Created by user136368 on 10/13/18.
//  Copyright © 2018 user136368. All rights reserved.
//

import UIKit

class SelectPhotoView: UIView {
    
    var lineColour: UIColor!
    var lineWidth: CGFloat!
    var path: UIBezierPath!
    var touchPoint: CGPoint!
    var startingPoint: CGPoint!
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = true
        
        lineColour = UIColor.black
        lineWidth = 5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startingPoint = touch?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        touchPoint = touch?.location(in: self)
        
        path = UIBezierPath()
        path?.move(to: startingPoint)
        path?.addLine(to: touchPoint)
        startingPoint = touchPoint
        
        DrawShape()
    }
    
    func DrawShape(){
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = lineColour.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = lineWidth
        self.layer.addSublayer(shape)
        self.setNeedsDisplay()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
