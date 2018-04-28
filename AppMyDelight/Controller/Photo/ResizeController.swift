//
//  ResizeController.swift
//  AppMyDelight
//
//  Created by vincent portier on 23/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//
  /*
import UIKit

class ResizeController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var Fond_ImageView: UIImageView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var width_Constraint: NSLayoutConstraint!
    @IBOutlet weak var height_Constraints: NSLayoutConstraint!
    
    var image: UIImage!
    var nextButton: UIBarButtonItem?
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   imageToCut(image: image)
     //   nextButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(nextOne))
     //   navigationItem.rightBarButtonItem = nextButton

    }

    
  
    @objc func nextOne () {
        let scale = 1 / ScrollView.zoomScale
        let x: CGFloat = ScrollView.contentOffset.x * scale
        let y: CGFloat = ScrollView.contentOffset.y * scale
        let width: CGFloat = ScrollView.frame.size.width * scale
        let height: CGFloat = ScrollView.frame.size.height * scale
        let rect: CGRect = CGRect(x: x, y: y, width: width, height: height)
        if let cgCutedImage = ImageView.image?.cgImage?.cropping(to: rect) {
            let cutedImage = UIImage(cgImage: cgCutedImage, scale: image.scale, orientation: image.imageOrientation)
            let controller = EffectController()
            controller.image = cutedImage
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func imageToCut(image: UIImage) {
        Fond_ImageView.image = image
        ImageView.image = image
        width_Constraint.constant = image.size.width
        height_Constraints.constant = image.size.height
        let scaleWidth = ScrollView.frame.size.width / image.size.width
        let scaleHeight = ScrollView.frame.size.height / image.size.height
        ScrollView.minimumZoomScale = max(scaleWidth, scaleHeight)
        ScrollView.zoomScale = max(scaleWidth, scaleHeight)
        
    }

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ImageView
    }
 
}

 
 
 
  */
