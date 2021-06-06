//
//  ImageViewController.swift
//  HW_Lesson17
//
//  Created by Svetlana Fomina on 06.06.2021.
//

import UIKit

final class ImageViewController: BaseViewController {

	private let date: String
	private let explanation: String
	private let networkService: NASANetworkServiceProtocol
	private let imageUrl: String

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	lazy var mainTitle: UILabel = {
		let mainLabel = UILabel()
		mainLabel.translatesAutoresizingMaskIntoConstraints = false
		mainLabel.text = "Astronomy Picture of the Day"
		mainLabel.font = UIFont.systemFont(ofSize:30)
		mainLabel.textColor = .white
		return mainLabel
	}()

	lazy var dateLabel: UILabel = {
		let dateLabel = UILabel()
		dateLabel.translatesAutoresizingMaskIntoConstraints = false
		dateLabel.text = "\(date)"
		dateLabel.font = UIFont.systemFont(ofSize:30)
		dateLabel.textColor = .white
		return dateLabel
	}()

	lazy var explanationLabel: UILabel = {
		let explanationLabel = UILabel()
		explanationLabel.translatesAutoresizingMaskIntoConstraints = false
		explanationLabel.text = "\(explanation)"
		explanationLabel.textAlignment = .center
		explanationLabel.font = UIFont.systemFont(ofSize:15)
		explanationLabel.textColor = .white
		explanationLabel.numberOfLines = .min
		return explanationLabel
	}()

	init(networkService: NASANetworkServiceProtocol, imageUrl: String, date: String, explanation: String) {
		self.networkService = networkService
		self.imageUrl = imageUrl
		self.date = date
		self.explanation = explanation
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .black
		setAutoLayout()
		loadData()
	}

	deinit {
		print("ImageViewController deinit")
	}

	private func setAutoLayout() {

		view.addSubview(mainTitle)
		NSLayoutConstraint.activate([
			mainTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
		])

		view.addSubview(dateLabel)
		NSLayoutConstraint.activate([
			dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			dateLabel.topAnchor.constraint(equalTo: mainTitle.topAnchor, constant: 50)
		])

		view.addSubview(imageView)
		NSLayoutConstraint.activate([
			imageView.widthAnchor.constraint(equalToConstant: 300),
			imageView.heightAnchor.constraint(equalToConstant: 300),
			imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			imageView.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: 50)
		])

		view.addSubview(explanationLabel)
		NSLayoutConstraint.activate([
			explanationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			explanationLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			explanationLabel.widthAnchor.constraint(equalTo: view.widthAnchor)
		])
	}

	private func loadData() {
		self.isLoading = true
		networkService.loadImage(imageUrl: imageUrl) { data in
			if let data = data, let image = UIImage(data: data) {
				DispatchQueue.main.async {
					self.imageView.image = image
					self.isLoading = false
				}
			}
		}
	}
}
