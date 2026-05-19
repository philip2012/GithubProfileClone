//
//  ViewController.swift
//  GithubProfileClone
//
//  Created by Nguyễn Vạn An Phúc on 18/5/26.
//

import UIKit

class ViewController: UIViewController {
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    private let noiseLayer: CALayer = CALayer()
    
    private func generateNoiseImage() -> UIImage? {
        let size = CGSize(width: 128, height: 128)
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        for x in 0..<Int(size.width) {
            for y in 0..<Int(size.height) {
                let gray = CGFloat.random(in: 0...1)
                context.setFillColor(UIColor(white: gray, alpha: 0.1).cgColor)
                context.fill(CGRect(x: x, y: y, width: 1, height: 1))
            }
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.05, alpha: 1)
        
        gradientLayer.type = .radial
        gradientLayer.colors = [
            UIColor.systemBlue.withAlphaComponent(0.2).cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.2)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        noiseLayer.opacity = 0.03
        if let noiseImage = generateNoiseImage() {
            noiseLayer.backgroundColor = UIColor(patternImage: noiseImage).cgColor
        }
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.layer.insertSublayer(noiseLayer, above: gradientLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
        noiseLayer.frame = view.bounds
    }
}

