//
//  TextViewWithHashtag.swift
//  AppMyDelight
//
//  Created by vincent portier on 28/04/2018.
//  Copyright © 2018 vincent portier. All rights reserved.
//

import UIKit

class TextViewWithHashtag: UITextView {

    var nsString: NSString?
    var attributedString: NSMutableAttributedString?
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        backgroundColor = .clear
        isEditable = false
        isSelectable = false
        isScrollEnabled = false
    }
    
    func setText(text: String) {
        self.attributedString = NSMutableAttributedString(string: text)
        self.nsString = NSString(string: text)
        
        let range = NSRange(location: 0, length: (self.nsString?.length)!)
        self.attributedString?.addAttributes([.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 16)], range: range)
        let words = text.components(separatedBy: [" ", "\n"])
        for word in words.filter({$0.hasPrefix("#")}) {
            let wordRange = nsString!.range(of: word)
            attributedString?.addAttributes([.foregroundColor: UIColor.blue], range: wordRange)
            attributedString?.addAttribute(NSAttributedStringKey(rawValue: "Hashtag"), value: 1, range: wordRange)
            attributedString?.addAttribute(NSAttributedStringKey(rawValue: "Clickable"), value: 1, range: wordRange)
        }
        
        attributedText = attributedString
    }

}
