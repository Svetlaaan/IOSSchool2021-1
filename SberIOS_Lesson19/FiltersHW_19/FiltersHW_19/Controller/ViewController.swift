//
//  ViewController.swift
//  FiltersHW_19
//
//  Created by Svetlana Fomina on 19.06.2021.
//

import UIKit

class ViewController: UIViewController {

	private let filterService: FilterService
	private var selectedIntensity: CGFloat = 0.5
	private var selectedImage = UIImage(named: "dog")
	private var selectedFilter = String()
	private var imagesWithFilter = ImagesWithFilters()
	private let filters = Filters()

	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.isUserInteractionEnabled = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.backgroundColor = .clear
		imageView.contentMode = .scaleAspectFit
		imageView.image = selectedImage
		imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
		return imageView
	}()

	private lazy var settingButton: UIButton = {
		let settings = UIButton(type: .system)
		settings.setImage(UIImage(systemName: "gearshape"), for: .normal)
		settings.tintColor = .black
		settings.addTarget(self, action: #selector(tapSettingButton) , for: .touchUpInside)
		return settings
	}()

	private lazy var saveButton: UIButton = {
		let settings = UIButton(type: .system)
		settings.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
		settings.tintColor = .black
		settings.addTarget(self, action: #selector(tapSaveButton) , for: .touchUpInside)
		return settings
	}()

	lazy var imagePicker: UIImagePickerController = {
		let imagePicker = UIImagePickerController()

		imagePicker.delegate = self
		imagePicker.allowsEditing = true
		imagePicker.sourceType = .photoLibrary

		return imagePicker
	}()

	private lazy var filtersCollectionView: UICollectionView = {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.scrollDirection = .horizontal
		flowLayout.itemSize = CGSize(width: 150, height: 150)
		flowLayout.minimumLineSpacing = 10

		let filtersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		filtersCollectionView.translatesAutoresizingMaskIntoConstraints = false
		filtersCollectionView.backgroundColor = .white
		filtersCollectionView.showsHorizontalScrollIndicator = false
		filtersCollectionView.register(FiltersCollectionViewCell.self, forCellWithReuseIdentifier: FiltersCollectionViewCell.cellReuseId)
		filtersCollectionView.delegate = self
		filtersCollectionView.dataSource = self
		return filtersCollectionView
	}()

	init(filterService: FilterService) {
		self.filterService = filterService
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white

		let settings = UIBarButtonItem(customView: settingButton)
		let save = UIBarButtonItem(customView: saveButton)
		navigationItem.setRightBarButtonItems([save, settings], animated: true)

		view.addSubview(imageView)
		view.addSubview(filtersCollectionView)
		setConstraints()
		setFiltersToImagesInCollectionView(currentImage: selectedImage!)
	}

	func setConstraints() {

		let imageViewConstraints = ([
			imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
		])

		let filtersCollectionViewConstraints = ([
			filtersCollectionView.heightAnchor.constraint(equalToConstant: 150),
			filtersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
			filtersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
			filtersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
		])

		NSLayoutConstraint.activate(imageViewConstraints)
		NSLayoutConstraint.activate(filtersCollectionViewConstraints)
	}

	private func setFiltersToImagesInCollectionView(currentImage: UIImage) {
		imagesWithFilter.images = filters.filters.map({ [self] item in
			filterService.doFilter(image: selectedImage!, filterName: item, intensity: 0.5)
		})
	}

	@objc func tapSettingButton() {
		let settingsViewController = SettingsViewController()
		navigationController?.pushViewController(settingsViewController, animated: true)
	}

	@objc func tapSaveButton() {
		guard let image = imageView.image else { return }
		UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
	}

	@objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
		if let error = error {
			print("ERROR: \(error)")
		}
		else {
			let alert = UIAlertController(title: "Saved!", message: "Your image has been saved to Photo Library", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default))
			present(alert, animated: true)
		}
	}

	@objc func imageTapped() {
		guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
		present(imagePicker, animated: true, completion: nil)
	}
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.editedImage] as? UIImage else { return }

		selectedImage = image
		imageView.image = selectedImage

		filtersCollectionView.reloadData()
		setFiltersToImagesInCollectionView(currentImage: selectedImage!)

		dismiss(animated: true, completion: nil)
	}
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return filters.filters.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiltersCollectionViewCell.cellReuseId, for: indexPath) as? FiltersCollectionViewCell
		else { preconditionFailure("Failed to load collection view cell") }

		if imagesWithFilter.images.count > 0 {
			cell.setImage(imagesWithFilter.images[indexPath.item])
			cell.setLabel(filters.filters[indexPath.item])
		}
		
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectedFilter = filters.filters[indexPath.item]
		navigationItem.title = "Filter: \(filters.filters[indexPath.item])"
		imageView.image = filterService.doFilter(image: selectedImage!, filterName: selectedFilter, intensity: selectedIntensity)
	}
}
