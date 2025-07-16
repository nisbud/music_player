//
//  MusicControllerView.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 16/07/25.
//

import UIKit

final class MusicControllerView: UIView {
	
	private let playButton = UIButton()
	private let nextButton = UIButton()
	private let prevButton = UIButton()
	private let progressSlider = UISlider()
	
	var onPlayTapped: (() -> Void)?
	var onNextTapped: (() -> Void)?
	var onPrevTapped: (() -> Void)?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupView()
		setupButtons()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setPlaying(_ isPlaying: Bool) {
		let imageName = isPlaying ? "icon_play" : "icon_pause"
		playButton.setImage(UIImage(named: imageName), for: .normal)
	}
	
	private func setupView() {
		backgroundColor = .white
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.1
		layer.shadowOffset = .zero
		layer.shadowRadius = 8
	}
	
	private func setupButtons() {
		playButton.setImage(UIImage(named: "icon_play"), for: .normal)
		nextButton.setImage(UIImage(named: "icon_next"), for: .normal)
		prevButton.setImage(UIImage(named: "icon_prev"), for: .normal)
		
		[playButton, nextButton, prevButton, progressSlider].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}
		
		playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
		nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
		prevButton.addTarget(self, action: #selector(prevTapped), for: .touchUpInside)
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			playButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
			playButton.widthAnchor.constraint(equalToConstant: 48),
			playButton.heightAnchor.constraint(equalToConstant: 48),
			
			prevButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -36),
			prevButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
			prevButton.widthAnchor.constraint(equalToConstant: 36),
			prevButton.heightAnchor.constraint(equalToConstant: 36),
			
			nextButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 36),
			nextButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
			nextButton.widthAnchor.constraint(equalToConstant: 36),
			nextButton.heightAnchor.constraint(equalToConstant: 36),
			
			progressSlider.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 8),
			progressSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			progressSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			progressSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
		])
	}
	
	@objc private func playTapped() {
		onPlayTapped?()
	}
	
	@objc private func nextTapped() {
		onNextTapped?()
	}
	
	@objc private func prevTapped() {
		onPrevTapped?()
	}
}
