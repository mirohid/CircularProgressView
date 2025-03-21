//
//  CompletionVC.swift
//  CircularProgressView
//
//  Created by MacMini6 on 12/03/25.
//

import UIKit
import Lottie
class CompletionVC: UIViewController {
   
    @IBOutlet weak var animationView: UIView!
    private var lottieAnimation: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLottieAnimation()
    }
    
    private func setupLottieAnimation() {
           lottieAnimation = LottieAnimationView(name: "highFiveAnimation")
           lottieAnimation.contentMode = .scaleAspectFill
           lottieAnimation.loopMode = .loop
           lottieAnimation.play()

           animationView.addSubview(lottieAnimation)

           // Make the animation view fit inside animationView (since constraints are set in Storyboard)
           lottieAnimation.frame = animationView.bounds
           lottieAnimation.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       }
}
