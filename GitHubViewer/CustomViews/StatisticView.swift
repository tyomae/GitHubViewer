//
//  StatisticView.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 17/01/2020.
//  Copyright © 2020 Artem Emelianov. All rights reserved.
//

import UIKit

class StatisticView: UIView {

    var view: UIView!
    
    @IBOutlet var shrekView: UIView! {
        didSet {
            shrekView.layer.cornerRadius = shrekView.frame.size.height / 2
            shrekView.clipsToBounds = true
        }
    }
    @IBOutlet var miuView: UIView! {
        didSet {
            miuView.layer.cornerRadius = miuView.frame.size.height / 2
            miuView.clipsToBounds = true
        }
    }
    @IBOutlet var kekView: UIView! {
       didSet {
            kekView.layer.cornerRadius = kekView.frame.size.height / 2
            kekView.clipsToBounds = true
        }
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
         UIView.AutoresizingMask.flexibleWidth,
         UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.view = view
    }

}


