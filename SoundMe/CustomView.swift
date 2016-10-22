//
//  CustomView.swift
//  SoundMe
//
//  Created by dror gal on 10/09/2016.
//  Copyright © 2016 dror gal. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var list_song: UIImageView!
    
    @IBOutlet weak var addProfile: UIImageView!
    
    @IBOutlet weak var iconUser: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
        self.iconUser.layer.cornerRadius = self.iconUser.frame.size.width / 2;
        self.iconUser.clipsToBounds = true;
        self.iconUser.layer.borderWidth = 3.0
        self.iconUser.layer.borderColor = UIColor.white.cgColor
    }


    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view);
    }

}
