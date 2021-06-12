//
//  ViewController.swift
//  HWLesson_20
//
//  Created by Svetlana Fomina on 12.06.2021.
//

import UIKit
import MyFramework

class ViewController: MyViewController {

	var colors: [UIColor] = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)]
	var currentIndex = 0

	override func viewDidLoad() {
		super.viewDidLoad()

		changeBackground(withColor: colors[currentIndex])
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
		view.addSubview(label)
	}

	@objc func handleTap() {
		currentIndex += 1

		if !colors.indices.contains(currentIndex) {
			currentIndex = 0
		}
		changeBackground(withColor: colors[currentIndex])
	}

}
