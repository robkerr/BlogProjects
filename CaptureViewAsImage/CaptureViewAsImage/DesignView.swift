//
//  DesignView.swift
//  CaptureViewAsImage
//
//  Created by Rob Kerr on 1/2/21.
//

import UIKit

class DesignView: UIView {

    var numberOfEllipses = 2 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var color = UIColor.systemPurple {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(1.0)
            color.set()
            
            context.translateBy(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
            let amount = Double.pi * 2 / Double(numberOfEllipses)
            
            for _ in 1...numberOfEllipses {
                context.rotate(by: CGFloat(amount))
                let rect = CGRect(x: -(frame.size.width * 0.25), y: -(frame.size.height / 2.0), width: frame.size.width * 0.5, height: frame.size.height)
                context.addEllipse(in: rect)
                
            }
            context.strokePath()
        }
    }
}
