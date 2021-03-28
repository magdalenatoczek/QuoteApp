//
//  BlurLabelWithPadding.swift
//  quoteApp
//
//  Created by Magdalena Toczek on 28/03/2021.
//

import UIKit

class BlurLabelWithPadding: UILabel {

    
    let UIEI = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func awakeFromNib() {
        self.layer.cornerRadius = CGFloat(10.0)
    }
  
    override var intrinsicContentSize:CGSize {
        numberOfLines = 0
        var s = super.intrinsicContentSize
        s.height = s.height + UIEI.top + UIEI.bottom
        s.width = s.width + UIEI.left + UIEI.right
        return s
    }

    override func drawText(in rect: CGRect) {
        let r = rect.inset(by: UIEI)
        super.drawText(in: r)
    }
    
    override func textRect(forBounds bounds:CGRect, limitedToNumberOfLines n:Int) -> CGRect {
        let b = bounds
        let tr = b.inset(by: UIEI)
        let ctr = super.textRect(forBounds: tr, limitedToNumberOfLines: 0)
        return ctr
    }
    
    
    
}
