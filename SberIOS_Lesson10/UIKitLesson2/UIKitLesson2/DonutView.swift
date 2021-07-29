//
//  DonutView.swift
//  UIKitLesson2
//
//  Created by Svetlana Fomina on 18.05.2021.
//

import UIKit

final class DonutView: UIImageView {
    
    private var diameter: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(diameter: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        self.diameter = diameter
        layer.cornerRadius = diameter / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
