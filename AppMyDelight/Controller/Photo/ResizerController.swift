//
//  ResizerController.swift
//  AppMyDelight
//
//  Created by vincent portier on 24/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class ResizerController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var ScrollCiew: UIScrollView!
    @IBOutlet weak var FondImageView: UIImageView!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var WidthConstraint: NSLayoutConstraint!
    
    
    var image: UIImage!
    var nextOne: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScrollCiew.delegate = self
        imageToCut(image: image)
        nextOne = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toNextOne))
        navigationItem.rightBarButtonItem = nextOne

    }

    
    @objc func toNextOne() {
            let scale = 1 / ScrollCiew.zoomScale
        let x: CGFloat = ScrollCiew.contentOffset.x * scale
        let y: CGFloat = ScrollCiew.contentOffset.y * scale
        let width: CGFloat = ScrollCiew.frame.size.width
        let heidht: CGFloat = ScrollCiew.frame.size.height
        let rect: CGRect = CGRect(x: x, y: y, width: width, height: heidht)
        if let cgimageCuted = ImageView.image?.cgImage?.cropping(to: rect) {
        let imageCuted = UIImage(cgImage: cgimageCuted, scale: image.scale, orientation: image.imageOrientation)
            let controller = fxController()
            controller.image = imageCuted
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
    
    func imageToCut(image: UIImage) {
        FondImageView.image = image
        ImageView.image = image
        WidthConstraint.constant = image.size.width
        HeightConstraint.constant = image.size.height
        
        let heightScale = ScrollCiew.frame.size.height / image.size.height
        let widthScale = ScrollCiew.frame.size.width / image.size.width
        ScrollCiew.minimumZoomScale = max(widthScale, heightScale)
        ScrollCiew.zoomScale = max(widthScale, heightScale)
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ImageView
    }

}
