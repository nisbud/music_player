//
//  MusicControllerView.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 16/07/25.
//

import UIKit

final class MusicControllerView: UIView {
	
	var onNextTapped: (() -> Void)?
	var onPrevTapped: (() -> Void)?
	
	private let playButton = UIButton()
	private let nextButton = UIButton()
	private let prevButton = UIButton()
	private let progressSlider = UISlider()
	
	private let viewModel: PlayerViewModel
	
	init(viewModel: PlayerViewModel) {
		self.viewModel = viewModel
		super.init(frame: .zero)
		
		bindViewModel()
		
		setupView()
		setupButtons()
		setupSlider()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
	
	private func setupSlider() {
		progressSlider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
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
	
	private func setPlaying(_ isPlaying: Bool) {
		let imageName = isPlaying ? "icon_pause" : "icon_play"
		playButton.setImage(UIImage(named: imageName), for: .normal)
	}
	
	private func bindViewModel() {
		viewModel.onProgressUpdate = { [weak self] current, duration in
			self?.progressSlider.maximumValue = Float(duration)
			self?.progressSlider.value = Float(current)
		}
		
		viewModel.onPlay = { [weak self] isPlaying in
			self?.setPlaying(isPlaying)
		}
	}
	
	@objc private func playTapped() {
		viewModel.togglePlayback()
	}
	
	@objc private func nextTapped() {
		onNextTapped?()
	}
	
	@objc private func prevTapped() {
		onPrevTapped?()
	}
	
	@objc private func sliderChanged(_ sender: UISlider) {
		viewModel.seek(to: Double(sender.value))
	}
}
