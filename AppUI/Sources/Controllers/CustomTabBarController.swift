//
//  CustomTabBarController.swift
//  RaM
//
//  Created by Alexander Grigorov on 10.12.2024.
//

import UIKit

public class CustomTabBarController: UITabBarController {

    let tabbarView = UIView()
    let barBottomOffset: CGFloat = 30
    let tabbarItemBackgroundView = UIView()
    let iconSize = 50

    var centerConstraint: NSLayoutConstraint?
    var buttons: [UIButton] = []

    override public func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }

    override public func setTabBarHidden(_ hidden: Bool, animated: Bool) {
        guard tabbarView.isHidden != hidden else { return }

        let frame = tabbarView.frame
        let offsetY = (frame.height + barBottomOffset) * (hidden ? 1 : -1)
        let duration: TimeInterval = animated ? 0.3 : 0

        if !hidden {
            self.tabbarView.isHidden = hidden
        }

        UIView.animate(withDuration: duration) {
            self.tabbarView.frame = frame.offsetBy(dx: 0, dy: offsetY)
        } completion: { _ in
            self.tabbarView.isHidden = hidden
        }
    }

    private func setView(){
        generateControllers()
        view.addSubview(tabbarView)
        tabbarView.translatesAutoresizingMaskIntoConstraints = false
        tabbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -barBottomOffset).isActive = true
        tabbarView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        tabbarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
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

            // Constraints
            button.centerYAnchor.constraint(equalTo: tabbarView.centerYAnchor).isActive = true
            button.widthAnchor.constraint(equalTo: tabbarView.widthAnchor, multiplier: 1 / CGFloat(buttons.count)).isActive = true
            button.heightAnchor.constraint(equalTo: tabbarView.heightAnchor).isActive = true

            // Left alignment
            if x == 0 {
                button.leftAnchor.constraint(equalTo: tabbarView.leftAnchor).isActive = true
                button.tintColor = .blue
            } else {
                button.leftAnchor.constraint(equalTo: buttons[x - 1].rightAnchor).isActive = true
                button.tintColor = .accent
            }

            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }

        // Activate center constraint for the first button (default selected state)
        centerConstraint = tabbarItemBackgroundView.centerXAnchor.constraint(equalTo: buttons[0].centerXAnchor)
        centerConstraint?.isActive = true
    }

    private func generateControllers(){
        let characters = generateViewControllers(image: .rick, vc: UIViewController())
        let favorite = generateViewControllers(image: .favorite, vc: UIViewController())

        viewControllers = [
            characters,
            favorite,
        ]
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
