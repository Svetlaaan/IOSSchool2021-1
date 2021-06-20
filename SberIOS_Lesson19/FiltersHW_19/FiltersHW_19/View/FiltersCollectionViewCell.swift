//
//  FiltersCollectionViewCell.swift
//  FiltersHW_19
//
//  Created by Svetlana Fomina on 19.06.2021.
//

import UIKit

final class FiltersCollectionViewCell: UICollectionViewCell {

	public static let cellReuseId = "cellReuseId"

	lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	lazy var filterNameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .boldSystemFont(ofSize: 15)
		label.textColor = .white
		label.textAlignment = .center
		label.backgroundColor = .darkGray
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(imageView)
		imageView.addSubview(filterNameLabel)

		setConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setConstraints() {
		let imageViewConstraints = ([
			imageView.topAnchor.constraint(equalTo: topAnchor),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])

		let filterNameLabelConstraints = ([
			filterNameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
			filterNameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
			filterNameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
		])

		NSLayoutConstraint.activate(imageViewConstraints)
		NSLayoutConstraint.activate(filterNameLabelConstraints)
	}

	public func setImage(_ imageWithFilter: UIImage) {
		imageView.image = imageWithFilter
	}
	
	public func setLabel(_ labelText: String) {
		filterNameLabel.text = labelText
	}

}
