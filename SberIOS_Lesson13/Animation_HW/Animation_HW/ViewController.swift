//
//  ViewController.swift
//  Animation_HW
//
//  Created by Svetlana Fomina on 26.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // фон небо
    lazy var sky: GradientView = {
        let sky = GradientView()
        sky.startColor = UIColor(red: 0.1, green: 0.25, blue: 0.5, alpha: 1)
        sky.endColor = UIColor(red: 0.75, green: 0.8, blue: 0.9, alpha: 1)
        sky.translatesAutoresizingMaskIntoConstraints = false
        return sky
    }()
    
    // поле где вырастут цветы
    lazy var fieldImageView: UIImageView = {
        let field = UIImageView()
        field.image = UIImage(named: "field")
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    // кнопка старта анимации
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.addTarget(self, action: #selector(pressStart), for: .touchUpInside)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // облака
    lazy var cloud1ImageView: UIImageView = {
        let cloud = UIImageView()
        cloud.image = UIImage(named: "cloud")
        cloud.alpha = 0.0
        cloud.translatesAutoresizingMaskIntoConstraints = false
        return cloud
    }()
    
    lazy var cloud2ImageView: UIImageView = {
        let cloud = UIImageView()
        cloud.image = UIImage(named: "cloud")
        cloud.alpha = 0.0
        cloud.translatesAutoresizingMaskIntoConstraints = false
        return cloud
    }()
    
    // капли дождя
    lazy var rainImageView: UIImageView = {
        let rain = UIImageView()
        rain.image = UIImage(named: "rain")
        rain.alpha = 0.0
        rain.translatesAutoresizingMaskIntoConstraints = false
        return rain
    }()
    
    // солнце
    lazy var sunImageView: UIImageView = {
        let sun = UIImageView()
        sun.image = UIImage(named: "sun")
        sun.isHidden = true
        sun.translatesAutoresizingMaskIntoConstraints = false
        return sun
    }()
    
    // цветы
    lazy var flower1ImageView: UIImageView = {
        let flower = UIImageView()
        flower.image = UIImage(named: "flower")
        flower.isHidden = true
        flower.translatesAutoresizingMaskIntoConstraints = false
        return flower
    }()
    
    lazy var flower2ImageView: UIImageView = {
        let flower = UIImageView()
        flower.image = UIImage(named: "flower2")
        flower.isHidden = true
        flower.translatesAutoresizingMaskIntoConstraints = false
        return flower
    }()
    
    lazy var flower3ImageView: UIImageView = {
        let flower = UIImageView()
        flower.image = UIImage(named: "flower3")
        flower.isHidden = true
        flower.translatesAutoresizingMaskIntoConstraints = false
        return flower
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(sky)
        view.addSubview(fieldImageView)
        view.addSubview(startButton)
        
        setAutoLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.addSubview(cloud1ImageView)
        view.addSubview(cloud2ImageView)
        view.addSubview(flower1ImageView)
        view.addSubview(flower2ImageView)
        view.addSubview(flower3ImageView)
        view.addSubview(rainImageView)
        view.addSubview(sunImageView)
        
        setCloudsLayout()
        setRainLayout()
        setSunLayout()
        setFlowersLayout()
    }
    
    private func setAutoLayout() {
        NSLayoutConstraint.activate([
            sky.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sky.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sky.topAnchor.constraint(equalTo: view.topAnchor),
            sky.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            fieldImageView.bottomAnchor.constraint(equalTo: sky.bottomAnchor),
            fieldImageView.leadingAnchor.constraint(equalTo: sky.leadingAnchor),
            fieldImageView.trailingAnchor.constraint(equalTo: sky.trailingAnchor)
        ])
        
        startButton.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: sky.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: sky.centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setSunLayout() {
        NSLayoutConstraint.activate([
            sunImageView.centerXAnchor.constraint(equalTo: sky.centerXAnchor),
            sunImageView.topAnchor.constraint(equalTo: sky.topAnchor, constant: 50)
        ])
    }
    
    private func setRainLayout() {
        NSLayoutConstraint.activate([
            rainImageView.centerXAnchor.constraint(equalTo: sky.centerXAnchor),
            rainImageView.topAnchor.constraint(equalTo: sky.topAnchor, constant: cloud2ImageView.frame.size.height)
        ])
    }
    
    private func setCloudsLayout() {
        NSLayoutConstraint.activate([
            cloud1ImageView.centerXAnchor.constraint(equalTo: sky.centerXAnchor, constant: 90),
            cloud1ImageView.topAnchor.constraint(equalTo: sky.topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            cloud2ImageView.centerXAnchor.constraint(equalTo: sky.centerXAnchor, constant: -70),
            cloud2ImageView.topAnchor.constraint(equalTo: sky.topAnchor, constant: 20)
        ])
    }
    
    private func setFlowersLayout() {
        NSLayoutConstraint.activate([
            flower1ImageView.centerXAnchor.constraint(equalTo: fieldImageView.centerXAnchor),
            flower1ImageView.centerYAnchor.constraint(equalTo: fieldImageView.centerYAnchor, constant: 90)
        ])
        
        NSLayoutConstraint.activate([
            flower2ImageView.centerYAnchor.constraint(equalTo: fieldImageView.centerYAnchor, constant: 90),
            flower2ImageView.centerXAnchor.constraint(equalTo: fieldImageView.centerXAnchor, constant: 100)
        ])
        
        NSLayoutConstraint.activate([
            flower3ImageView.centerYAnchor.constraint(equalTo: fieldImageView.centerYAnchor, constant: 50),
            flower3ImageView.leadingAnchor.constraint(equalTo: fieldImageView.leadingAnchor, constant: 50)
        ])
    }
    
    // скрывает/отображает вьюхи
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 1, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    @objc func pressStart() {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
                        self.startButton.alpha = 0.0
                       })
        
        rainfallPartAnimation()
    }
    
    private func rainfallPartAnimation() {
        cloud1ImageView.layer.removeAllAnimations()
        cloud2ImageView.layer.removeAllAnimations()
        
        let options: UIView.AnimationOptions = [.curveEaseInOut,
                                                .autoreverse]
        let animationCloudsDuration = 2.0
        
        cloud1ImageView.alpha = 1.0
        UIView.animate(withDuration: animationCloudsDuration,
                       delay: 0,
                       options: options,
                       animations: { [weak self] in
                        self?.cloud1ImageView.frame.size.height *= 1.2
                        self?.cloud1ImageView.frame.size.width *= 1.2
                       }, completion: nil)
        
        cloud2ImageView.alpha = 1.0
        UIView.animate(withDuration: animationCloudsDuration,
                       delay: 0.2,
                       options: options,
                       animations: { [weak self] in
                        self?.cloud2ImageView.frame.size.height *= 1.2
                        self?.cloud2ImageView.frame.size.width *= 1.2
                       }, completion: nil)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(animationCloudsDuration * 2.2), target: self, selector: #selector(animateRain), userInfo: nil, repeats: false)
        
    }
    
    @objc func animateRain() {
        rainImageView.layer.removeAllAnimations()
        
        let rainfallAnimation1 = CAKeyframeAnimation(keyPath: "position")
        
        rainImageView.alpha = 1.0
        let pathArray1 = [[sky.frame.width / 2, cloud2ImageView.frame.maxY + 50], [sky.frame.width / 2, (sky.frame.height / 4) * 3]]
        rainfallAnimation1.values = pathArray1
        rainfallAnimation1.duration = 2.0
        rainfallAnimation1.repeatCount = 2
        rainImageView.layer.add(rainfallAnimation1, forKey: "rainPosition")
        
        Timer.scheduledTimer(timeInterval: TimeInterval(4.0), target: self, selector: #selector(hideClouds), userInfo: nil, repeats: false)
    }
    
    @objc func hideClouds() {
        setView(view: cloud1ImageView, hidden: true)
        setView(view: cloud2ImageView, hidden: true)
        setView(view: rainImageView, hidden: true)
        Timer.scheduledTimer(timeInterval: TimeInterval(0.5), target: self, selector: #selector(sunPartAnimation), userInfo: nil, repeats: false)
    }
    
    @objc func sunPartAnimation() {
        sunImageView.layer.removeAllAnimations()
        
        let sunOpacity = CABasicAnimation(keyPath: "opacity")
        
        sunOpacity.fromValue = 0.0
        sunOpacity.toValue = 1.0
        sunOpacity.duration = 4.0
        sunOpacity.repeatCount = 1
        sunImageView.layer.add(sunOpacity, forKey: "sunOpacity")
        setView(view: sunImageView, hidden: false)
        UIView.animate(withDuration: 3.0, animations: { [self] () -> Void in
            self.sunImageView.transform = CGAffineTransform(rotationAngle: CGFloat(90))
        })
        growFlowers()
    }
    
    private func growFlowers() {
        flower1ImageView.layer.removeAllAnimations()
        flower2ImageView.layer.removeAllAnimations()
        flower3ImageView.layer.removeAllAnimations()
        
        let options: UIView.AnimationOptions = [.curveEaseInOut]
        let animationCloudsDuration = 3.0
        
        setView(view: flower1ImageView, hidden: false)
        UIView.animate(withDuration: animationCloudsDuration,
                       delay: 0,
                       options: options,
                       animations: { [weak self] in
                        self?.flower1ImageView.frame.size.height *= 1.2
                        self?.flower1ImageView.frame.size.width *= 1.2
                       }, completion: nil)
        
        setView(view: flower2ImageView, hidden: false)
        UIView.animate(withDuration: animationCloudsDuration,
                       delay: 0,
                       options: options,
                       animations: { [weak self] in
                        self?.flower2ImageView.frame.size.height *= 1.5
                        self?.flower2ImageView.frame.size.width *= 1.5
                       }, completion: nil)
        
        setView(view: flower3ImageView, hidden: false)
        UIView.animate(withDuration: animationCloudsDuration,
                       delay: 0,
                       options: options,
                       animations: { [weak self] in
                        self?.flower3ImageView.frame.size.height *= 1.2
                        self?.flower3ImageView.frame.size.width *= 1.2
                       }, completion: nil)
        
    }
    
}
