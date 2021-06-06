//
//  BaseViewController.swift
//  SberIOS_Lesson17
//
//  Created by Svetlana Fomina on 06.06.2021.
//

import UIKit

class BaseViewController: UIViewController {

	private let spinner = SpinnerViewController()

	var isLoading = false {
		didSet {
			guard oldValue != isLoading else { return }
			showSpinner(isShown: isLoading)
		}
	}

	private func showSpinner(isShown: Bool) {
		if isShown {
			addChild(spinner)
			spinner.view.frame = view.frame
			view.addSubview(spinner.view)
			spinner.didMove(toParent: self)
		} else {
			spinner.willMove(toParent: nil)
			spinner.view.removeFromSuperview()
			spinner.removeFromParent()
		}
	}
}

