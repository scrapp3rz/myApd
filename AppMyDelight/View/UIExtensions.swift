//
//  UIExtensions.swift
//  AppMyDelight
//
//  Created by vincent portier on 19/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit
import SDWebImage


extension UIViewController {
    
    func keyboard() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
    }


    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }

}



extension UIView {
    
    
    func runXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nameXib = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nameXib, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        addSubview(view)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = .white
        return view
        
    }
    
    func createActivityIndicator() {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blur.frame = bounds
        blur.tag = 11
        addSubview(blur)
        
        
        let activity = UIActivityIndicatorView()
        activity.activityIndicatorViewStyle = .gray
        activity.color = .darkGray
        activity.center = center
        activity.tag = 5
        activity.startAnimating()
        addSubview(activity)
        
    }
    
    
    func removeActivityIndicator() {
        for view in subviews {
            if view.tag == 11 {
                view.removeFromSuperview()
            }
            if view.tag == 5, let activity = view as? UIActivityIndicatorView {
                activity.stopAnimating()
                activity.removeFromSuperview()
            }
        }
    }
    
    
}

extension UIImageView {
    
    func download(imageUrl: String?) {
        image = #imageLiteral(resourceName: "Cat_Rules")
        guard let string = imageUrl, string != "", let url = URL(string: string) else { return }
        sd_setImage(with: url, completed: nil)
    }
    
    
    
}


extension UILabel {
    
    func attributedText(string1: String, string2: String)  {
        let mutable = NSMutableAttributedString(string: string1, attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.black])
        mutable.append(NSAttributedString(string: string2, attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.darkGray]))
        attributedText = mutable
    }
    
    
    
}


















