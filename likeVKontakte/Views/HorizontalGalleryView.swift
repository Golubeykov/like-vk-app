//
//  HorizontalGalleryView.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 30.06.2022.
//

import UIKit

@IBDesignable class HorizontalGalleryView: UIView {
    @IBInspectable var inactiveIndicatorColor: UIColor = UIColor.lightGray
    @IBInspectable var activeIndicatorColor: UIColor = UIColor.black
    
    private var horizontalGalleryView: UIView!
    
    private var interactiveAnimator: UIViewPropertyAnimator!
    
    private var mainImageView = UIImageView()
    private var secondaryImageView = UIImageView()
    private var images = [UIImage]()
    private var isLeftSwipe = false
    private var isRightSwipe = false
    private var chooseFlag = false
    private var currentIndex = 0
    private var customPageView = UIPageControl()
    
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
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        self.addGestureRecognizer(recognizer)
        
        mainImageView.backgroundColor = UIColor.systemYellow
        mainImageView.frame = self.bounds
        addSubview(mainImageView)
        
        secondaryImageView.backgroundColor = UIColor.systemGreen
        secondaryImageView.frame = self.bounds
        secondaryImageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        addSubview(secondaryImageView)
        
        //листалка внизу вьюхи
        customPageView.backgroundColor = UIColor.clear
        customPageView.frame = CGRect(x: 1, y: 1, width: 150, height: 50)
        customPageView.layer.zPosition = 100
        customPageView.numberOfPages = 1
        customPageView.currentPage = 0
        customPageView.pageIndicatorTintColor = self.inactiveIndicatorColor
        customPageView.currentPageIndicatorTintColor = self.activeIndicatorColor
        addSubview(customPageView)
        
        customPageView.translatesAutoresizingMaskIntoConstraints = false
        customPageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        customPageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.bounds.height / 15).isActive = true
        
    }
    @objc func onPan(_ recognizer: UIPanGestureRecognizer) {
        
    }
}
