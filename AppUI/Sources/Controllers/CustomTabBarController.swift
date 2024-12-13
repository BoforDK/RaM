//
//  CustomTabBarController.swift
//  RaM
//
//  Created by Alexander Grigorov on 10.12.2024.
//

import UIKit

public class CustomTabBarController: UITabBarController {

    let barIcons: [UIImage]
    let tabbarView = UIView()
    let tabbarItemBackgroundView = UIView()
    let barBottomOffset: CGFloat = 30
    let barHeight: CGFloat = 70
    let iconSize = 50

    var buttons: [UIButton] = []
    var isBarAnimationFinished: Bool = true

    public init(barIcons: [UIImage]) {
        self.barIcons = barIcons

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    override public func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        guard
            tabbarView.isHidden != hidden,
            isBarAnimationFinished
        else { return }

        isBarAnimationFinished = false
        let frame = self.tabbarView.frame
        let offsetY = (frame.height + self.barBottomOffset) * (hidden ? 1 : -1)
        let duration: TimeInterval = animated ? 0.1 : 0

        if !hidden {
            self.tabbarView.isHidden = hidden
        }

        UIView.animate(withDuration: duration) {
            self.tabbarView.frame = self.tabbarView.frame.offsetBy(dx: 0, dy: offsetY)
        } completion: { _ in
            self.tabbarView.isHidden = hidden
            self.isBarAnimationFinished = true
        }
    }

    private func setView(){
        generateControllers()
        view.addSubview(tabbarView)
        tabbarView.translatesAutoresizingMaskIntoConstraints = false
        tabbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -barBottomOffset).isActive = true
        tabbarView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        tabbarView.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        tabbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tabbarView.layer.cornerRadius = 30
        tabbarView.backgroundColor = .listItem

        tabbarView.layer.shadowColor = UIColor.black.cgColor
        tabbarView.layer.shadowOpacity = 0.4
        tabbarView.layer.shadowOffset = .zero
        tabbarView.layer.shadowRadius = 10
        tabbarView.layer.masksToBounds = false

        tabbarView.addSubview(tabbarItemBackgroundView)
        tabbarItemBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        tabbarItemBackgroundView.widthAnchor.constraint(equalTo: tabbarView.widthAnchor, multiplier: 1/CGFloat(buttons.count), constant: -10).isActive = true
        tabbarItemBackgroundView.heightAnchor.constraint(equalTo: tabbarView.heightAnchor, constant: -10).isActive = true
        tabbarItemBackgroundView.centerYAnchor.constraint(equalTo: tabbarView.centerYAnchor).isActive = true
        tabbarItemBackgroundView.layer.cornerRadius = 25

        for x in 0..<buttons.count {
            let button = buttons[x]
            button.translatesAutoresizingMaskIntoConstraints = false
            tabbarView.addSubview(button)
            button.tag = x

            button.centerYAnchor.constraint(equalTo: tabbarView.centerYAnchor).isActive = true
            button.widthAnchor.constraint(equalTo: tabbarView.widthAnchor, multiplier: 1 / CGFloat(buttons.count)).isActive = true
            button.heightAnchor.constraint(equalTo: tabbarView.heightAnchor).isActive = true

            if x == 0 {
                button.leftAnchor.constraint(equalTo: tabbarView.leftAnchor).isActive = true
                button.tintColor = .blue
            } else {
                button.leftAnchor.constraint(equalTo: buttons[x - 1].rightAnchor).isActive = true
                button.tintColor = .accent
            }

            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }

    public func generateControllers() {
        viewControllers = barIcons.map {
            generateViewControllers(image: $0, vc: UIViewController())
        }
    }

    private func generateViewControllers(image: UIImage, vc: UIViewController) -> UIViewController {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .selectedAccent
        let image = image.resize(
            targetSize: CGSize(
                width: iconSize,
                height: iconSize
            )
        ).withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        buttons.append(button)
        return vc
    }

    @objc private func buttonTapped(sender: UIButton) {
        selectedIndex = sender.tag

        for button in buttons {
            button.tintColor = .accent
        }

        self.buttons[sender.tag].tintColor = .blue
    }
}
