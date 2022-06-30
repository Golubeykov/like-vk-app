//
//  HorizontalGalleryView.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 30.06.2022.
//

import UIKit

@IBDesignable class HorizontalGalleryView: UIView {
    var horizontalGalleryView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func loadHorizontalGalleryFromXIB() -> UIView {
        let bundle = Bundle(for:type(of: self))
        let HorizontalGalleryXib = UINib(nibName: "HorizontalGalleryView", bundle: bundle)
        
        guard let HorizontalGalleryView = HorizontalGalleryXib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
        return HorizontalGalleryView
    }
    func setup() {
        self.horizontalGalleryView = loadHorizontalGalleryFromXIB()
        self.horizontalGalleryView.frame = self.bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(self.horizontalGalleryView)
        self.bringSubviewToFront(horizontalGalleryView)
    }
}
