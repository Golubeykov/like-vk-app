//
//  StarView.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 30.06.2022.
//

import UIKit

@IBDesignable class StarView: UIView {
   
    @IBInspectable var fillColor: UIColor = UIColor.red
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setFillColor(fillColor.cgColor)
        
        let startPosition = CGPoint(x: 40, y: 20)
        let path = UIBezierPath()
        
        path.move(to: startPosition)
        path.addLine(to: CGPoint(x: 45, y: 40))
        path.addLine(to: CGPoint(x: 65, y: 40))
        path.addLine(to: CGPoint(x: 50, y: 50))
        path.addLine(to: CGPoint(x: 60, y: 70))
        path.addLine(to: CGPoint(x: 40, y: 55))
        path.addLine(to: CGPoint(x: 20, y: 70))
        path.addLine(to: CGPoint(x: 30, y: 50))
        path.addLine(to: CGPoint(x: 15, y: 40))
        path.addLine(to: CGPoint(x: 35, y: 40))
        path.close()
        
        context.addPath(path.cgPath)
//        context.fillPath()
        context.strokePath()
        
        
        let heightWidthCircleSquare = 20
        let circle = CAShapeLayer()
        circle.bounds = CGRect(x: 0, y: 0, width: heightWidthCircleSquare, height: heightWidthCircleSquare)
        circle.cornerRadius = CGFloat(heightWidthCircleSquare / 2)
        circle.position = startPosition
        circle.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor
 
        let circleAnimation = CAKeyframeAnimation(keyPath: "position")
        circleAnimation.path = path.cgPath
        circleAnimation.calculationMode = .cubicPaced
        circleAnimation.speed = 0.1
        circleAnimation.repeatCount = 10
        
        
        
        circle.add(circleAnimation, forKey: nil)
        
        self.layer.addSublayer(circle)
        
 
        
    }
 

}
