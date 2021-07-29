//
//  ButtonView.swift
//  UIKitLesson2
//
//  Created by Svetlana Fomina on 21.05.2021.
//

import UIKit

final class ButtonView: UIButton {
    private var diameter: CGFloat
    
    init(diameter: CGFloat) {
        self.diameter = diameter
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        let radius = diameter / 2
        // расстояние от точки касания экрана до центра окружности (кнопки)
        let dist = sqrt(pow(bounds.midX - point.x, 2) + pow(bounds.midY - point.y, 2))
        
        if dist <= radius {
            return view
        } else {
            return nil
        }
    }
}
