//
//  CodeStatisticView.swift
//  GitHubViewer
//
//  Created by Артем  Емельянов  on 22/01/2020.
//  Copyright © 2020 Artem Emelianov. All rights reserved.
//

import UIKit

class CodeStatisticView: UIView {

    let stackView = UIStackView()
    var numberLabels = [UILabel]()
    var infoLabels = [UILabel]()
        
    func commonInit() {
        backgroundColor = #colorLiteral(red: 0.7721720934, green: 0.7721720934, blue: 0.7721720934, alpha: 1)
        layer.cornerRadius = 15
        layer.masksToBounds = true
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        for _ in 0...2 {
            let subStackView = UIStackView()
            subStackView.axis = .vertical
            subStackView.alignment = .fill
            subStackView.distribution = .fill
            subStackView.spacing = 15
            subStackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(subStackView)
            
            let numberLabel = UILabel()
            numberLabel.text = "12"
            numberLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            numberLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            numberLabel.layer.cornerRadius = 26
            numberLabel.layer.masksToBounds = true
            numberLabel.textAlignment = .center
            numberLabels.append(numberLabel)
            subStackView.addArrangedSubview(numberLabel)
            
            let infoLabel = UILabel()
            infoLabel.text = "shrek"
            infoLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            infoLabel.textAlignment = .center
            
            infoLabels.append(infoLabel)
            subStackView.addArrangedSubview(infoLabel)
        }
        
        
        setupLayout()
    }
    
    private func setupLayout() {
      NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: topAnchor),
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
      ])
        
        for numberLabel in numberLabels {
            NSLayoutConstraint.activate([
                numberLabel.heightAnchor.constraint(equalToConstant: 52),
                numberLabel.widthAnchor.constraint(equalToConstant: 52)
            ])
        }
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
}
