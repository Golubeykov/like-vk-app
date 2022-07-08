//
//  LikeButtonView.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 28.06.2022.
//

import UIKit

@IBDesignable class LikeButtonView: UIView {

    var likeButtonView: UIView!
    var counter = 0
    var isPressed = false
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    @IBAction func likeButton(_ sender: UIButton) {
        isPressed = !isPressed
        heartState(isFilled: isPressed)
        if isPressed {
            self.counter += 1
        } else {
            self.counter -= 1
        }
        self.counterLabel.text = String(self.counter)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func loadLikeButtonFromXIB() -> UIView {
        let bundle = Bundle(for:type(of: self))
        let likeButtonXib = UINib(nibName: "LikeButtonView", bundle: bundle)
        
        guard let likeView = likeButtonXib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
        return likeView
    }
    
    func setup() {
        self.likeButtonView = loadLikeButtonFromXIB()
        self.likeButtonView.frame = self.bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.likeButtonView.layer.cornerRadius = 10
        self.addSubview(self.likeButtonView)
        self.bringSubviewToFront(likeButtonView)
        
        self.counterLabel.text = String(counter)
    }
    
    func heartState(isFilled: Bool) {
        var heartImage = UIImage(systemName: "heart")
        if isFilled {
            heartImage = UIImage(systemName: "heart.fill")
        }
        self.heartImage.image = heartImage
    }
}
