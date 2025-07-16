//
//  LoadingView.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 17/07/25.
//

import UIKit

final class LoadingView {
	static let shared = LoadingView()

	private var overlayView: UIView = UIView()
	private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)

	private init() {
		overlayView.backgroundColor = UIColor(white: 0, alpha: 0.4)
		overlayView.isUserInteractionEnabled = true

		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		overlayView.addSubview(activityIndicator)

		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor)
		])
	}

	func show(over view: UIView) {
		guard overlayView.superview == nil else {
			return
		}

		overlayView.frame = view.bounds
		overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		view.addSubview(overlayView)

		activityIndicator.startAnimating()
	}

	func hide() {
		activityIndicator.stopAnimating()
		overlayView.removeFromSuperview()
	}
}
