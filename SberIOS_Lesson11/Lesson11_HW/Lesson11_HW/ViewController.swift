//
//  ViewController.swift
//  Lesson11_HW
//
//  Created by Svetlana Fomina on 23.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // Изображения
    var imageView = UIImageView()
    var menuArray = ["First doggo", "Second doggo"]
    let imageArray = [UIImage(named: "doggo1"),
                      UIImage(named: "doggo2")]
    
    // Кнопка share
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.tintColor = .white
        button.sizeToFit()
        button.setTitle("❤️Tap to share❤️", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // Segmented Control
    lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: menuArray)
        segmentControl.addTarget(self, action: #selector(selectedValue(target:)), for: .valueChanged)
        return segmentControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(shareButton)
        imageView.image = imageArray[0]
        view.addSubview(imageView)
        view.addSubview(segmentControl)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentControl.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            segmentControl.widthAnchor.constraint(equalToConstant: 200),
            segmentControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareButton.centerYAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 100),
            shareButton.widthAnchor.constraint(equalToConstant: 200),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func shareButtonTapped() {
        let myCustomActivity = MyActivity()
        let shareController = UIActivityViewController(activityItems: [imageView.image as Any ], applicationActivities: [myCustomActivity])
        
        // Исключить PostToFlickr, PostToVimeo, SaveToCameraRoll
        shareController.excludedActivityTypes = [.postToTwitter, .postToVimeo, .saveToCameraRoll]
        shareController.popoverPresentationController?.sourceView = self.view
        // Обработка выполнения остальных Activity Types
        shareController.completionWithItemsHandler = { (activity, completed, items, error) in
            print("Activity: \(String(describing: activity)) Success: \(completed) Items: \(String(describing: items)) Error: \(String(describing: error))")
        }
        self.present(shareController, animated: true, completion: nil)
        
    }
    
    @objc func selectedValue(target: UISegmentedControl) {
        if target == segmentControl {
            let segmentIndex = target.selectedSegmentIndex
            imageView.image = imageArray[segmentIndex]
        }
    }
}

