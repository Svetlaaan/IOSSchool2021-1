//
//  SettingsViewController.swift
//  FiltersHW_19
//
//  Created by Svetlana Fomina on 19.06.2021.
//

import UIKit

final class SettingsViewController: UIViewController {

	public var selectedIntensity = CGFloat()

	private lazy var slider: UISlider = {
		let slider = UISlider()
		slider.translatesAutoresizingMaskIntoConstraints = false
		slider.value = 0.5
		slider.minimumValue = 0
		slider.maximumValue = 1
//		slider.addTarget(self, action: #selector(changeIntensity), for: .valueChanged)
		return slider
	}()

	private lazy var sliderLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Intensity"
		label.textAlignment = .center
		label.font = label.font.withSize(20)
		return label
	}()

	private lazy var applyButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Apply", for: .normal)
		button.layer.cornerRadius = 20
		button.backgroundColor = .gray
		button.setTitleColor(.white, for: .normal)
		button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
		return button
	}()

	private lazy var cancelButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Cancel", for: .normal)
		button.layer.cornerRadius = 20
		button.backgroundColor = .gray
		button.setTitleColor(.white, for: .normal)
		button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white
		view.addSubview(sliderLabel)
		view.addSubview(slider)
		view.addSubview(applyButton)
		view.addSubview(cancelButton)
		setConstraints()
	}

	func setConstraints() {
		let sliderConstraints = ([
			slider.topAnchor.constraint(equalTo: sliderLabel.bottomAnchor, constant: 100),
			slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
		])
		let sliderLabelConstraints = ([
			sliderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
			sliderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			sliderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			sliderLabel.heightAnchor.constraint(equalToConstant: 40)
		])
		let applyButtonConstraints = ([
			applyButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 100),
			applyButton.widthAnchor.constraint(equalToConstant: 100),
			applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
			applyButton.heightAnchor.constraint(equalToConstant: 50)
		])

		let cancelButtonConstraints = ([
			cancelButton.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 100),
			cancelButton.widthAnchor.constraint(equalToConstant: 100),
			cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
			cancelButton.heightAnchor.constraint(equalToConstant: 50)
		])

		NSLayoutConstraint.activate(sliderConstraints)
		NSLayoutConstraint.activate(sliderLabelConstraints)
		NSLayoutConstraint.activate(applyButtonConstraints)
		NSLayoutConstraint.activate(cancelButtonConstraints)
	}

	@objc func applyButtonTapped(){
		selectedIntensity = CGFloat(slider.value)
		navigationController?.popViewController(animated: true)
	}

	@objc func cancelButtonTapped(){
		navigationController?.popViewController(animated: true)
	}
}
