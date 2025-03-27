//
//  ViewController.swift
//  CircularProgressView
//
//  Created by MacMini6 on 12/03/25.
//

import UIKit
class CircularProgressView: UIView {
    private var shapeLayer = CAShapeLayer()
    private var gradientLayer = CAGradientLayer()
    private var backgroundLayer = CAShapeLayer()
    private var progress: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
//    private func setupView() {
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2),
//                                      radius: bounds.width / 4, // Slightly larger radius
//                                      startAngle: -CGFloat.pi / 2,
//                                      endAngle: 3 * CGFloat.pi / 2,
//                                      clockwise: true)
//        
//        // Background Circle
//        backgroundLayer.path = circlePath.cgPath
//        backgroundLayer.strokeColor = UIColor.systemGray5.cgColor
//        backgroundLayer.fillColor = UIColor.clear.cgColor
//        backgroundLayer.lineWidth = 10 // Increased width
//        backgroundLayer.strokeEnd = 1
//        layer.addSublayer(backgroundLayer)
//        
//        // Progress Circle
//        shapeLayer.path = circlePath.cgPath
//        shapeLayer.strokeColor = UIColor.white.cgColor
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        shapeLayer.lineWidth = 10 // Increased width
//        shapeLayer.strokeEnd = 0 // Initially empty
//        
//        gradientLayer.frame = bounds
//        gradientLayer.colors = [UIColor(red: 64/255, green: 242/255, blue: 199/255, alpha: 1).cgColor,
//                                       UIColor(red: 187/255, green: 242/255, blue: 70/255, alpha: 1).cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
//        gradientLayer.mask = shapeLayer
//        
//        layer.addSublayer(gradientLayer)
//    }
    
    private func setupView() {
        let radius = min(bounds.width, bounds.height) / 2  // Make it fit the full view
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius - 5, // Adjust for stroke width
                                      startAngle: -CGFloat.pi / 2,
                                      endAngle: 3 * CGFloat.pi / 2,
                                      clockwise: true)

        // Background Circle
        backgroundLayer.path = circlePath.cgPath
        backgroundLayer.strokeColor = UIColor.systemGray5.cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = 10
        backgroundLayer.strokeEnd = 1
        layer.addSublayer(backgroundLayer)

        // Progress Circle
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        
        // Gradient Layer
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor(red: 64/255, green: 242/255, blue: 199/255, alpha: 1).cgColor,
                                UIColor(red: 187/255, green: 242/255, blue: 70/255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = radius
        gradientLayer.mask = shapeLayer
        
        layer.addSublayer(gradientLayer)
    }

    
    
    func setProgress(to value: CGFloat, animated: Bool) {
        let clampedValue = min(max(value / 100, 0), 1)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = shapeLayer.strokeEnd
        animation.toValue = clampedValue
        animation.duration = animated ? 0.7 : 0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        shapeLayer.strokeEnd = clampedValue
        shapeLayer.add(animation, forKey: "progress")
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var progressView: CircularProgressView!
    
    @IBOutlet weak var progressTxtField: UITextField!
    
    private var progress: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.setProgress(to: 0, animated: false) // Ensure it starts empty
        setupKeyboardDismissGesture()
    }

    @IBAction func btnClicked(_ sender: UIButton) {                          
        if let text = progressTxtField.text, let doubleValue = Double(text) {
                let value = CGFloat(doubleValue)
                progressView.setProgress(to: value, animated: true)
            }
         }
    
    
    @IBAction func navigateBtnTapped(_ sender: UIButton) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let nextVC = storyboard.instantiateViewController(withIdentifier: "CompletionVC") as? CompletionVC {
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
    }
    
    
    
    private func setupKeyboardDismissGesture() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
        }
        
        @objc private func dismissKeyboard() {
            view.endEditing(true)
        }
    
    }
    


