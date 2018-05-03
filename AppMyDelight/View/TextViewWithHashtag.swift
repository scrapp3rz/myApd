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
    var hashtagColor = UIColor(red: 70 / 255, green: 130 / 255, blue: 190 / 255, alpha: 1)
    
    
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
    
    func setText(text: String, date: Double?) {
        self.attributedString = NSMutableAttributedString(string: text)
        if date != nil {
        self.attributedString?.append(NSAttributedString(string: "\n" + date!.xTimeAgo(), attributes: [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.darkGray]))
        }
        self.nsString = NSString(string: text)
        
        let range = NSRange(location: 0, length: (self.nsString?.length)!)
        self.attributedString?.addAttributes([.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 16)], range: range)
        let words = text.components(separatedBy: [" ", "\n"])
        for word in words.filter({$0.hasPrefix("#")}) {
            let wordRange = nsString!.range(of: word)
            attributedString?.addAttributes([.foregroundColor: hashtagColor], range: wordRange)
            attributedString?.addAttribute(NSAttributedStringKey(rawValue: "Hashtag"), value: 1, range: wordRange)
            attributedString?.addAttribute(NSAttributedStringKey(rawValue: "Clickable"), value: 1, range: wordRange)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(hashtagTap(tapGesture:)))
        addGestureRecognizer(tap)
        
        attributedText = attributedString
    }

    
    @objc func hashtagTap(tapGesture: UITapGestureRecognizer) {
        guard let letterTap = closestPosition(to: tapGesture.location(in: self)) else { return }
        guard let letterRange = tokenizer.rangeEnclosingPosition(letterTap, with: .character, inDirection: 1) else { return }
        let position = offset(from: beginningOfDocument, to: letterRange.start)
        let lenght = offset(from: letterRange.start, to: letterRange.end)
        let attributedRange = NSMakeRange(position, lenght)
        let letter = attributedText.attributedSubstring(from: attributedRange)
        
        guard letter.string != "" else { return }
        let isItHashtag = letter.attribute(NSAttributedStringKey("Hashtag"), at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, letter.length))
        
        guard let wordChoosen = tokenizer.rangeEnclosingPosition(letterTap, with: .word, inDirection: 1) else { return }
        let wordPosition = offset(from: beginningOfDocument, to: wordChoosen.start)
        let wordLenght = offset(from: wordChoosen.start, to: wordChoosen.end)
        let wordRange = NSMakeRange(wordPosition, wordLenght)
        let myWord = attributedText.attributedSubstring(from: wordRange)
        let myWordString = myWord.string
        
        guard isItHashtag != nil else { return }
        
        
        
    }
    
    
}
