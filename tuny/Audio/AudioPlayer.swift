//
//  AudioPlayer.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 17/07/25.
//

import AVFoundation

final class AudioPlayer {
	static let shared = AudioPlayer()
	
	private var player: AVPlayer?
	private var timeObserverToken: Any?
	
	var onTimeUpdate: ((Double, Double) -> Void)?
	var onFinished: (() -> Void)?

	func load(url: URL) {
		let playerItem = AVPlayerItem(url: url)
		player = AVPlayer(playerItem: playerItem)
		player?.play()

		observeTime()
		observeEnd()
	}
	
	func play() {
		player?.play()
	}
	
	func pause() {
		player?.pause()
	}
	
	func isPlaying() -> Bool {
		return player?.rate ?? 0 > 0
	}

	func seek(to seconds: Double) {
		let time = CMTime(seconds: seconds, preferredTimescale: 600)
		player?.seek(to: time)
	}

	func currentTime() -> Double {
		return player?.currentTime().seconds ?? 0
	}

	func duration() -> Double {
		return player?.currentItem?.asset.duration.seconds ?? 0
	}

	private func observeTime() {
		timeObserverToken = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 2),
															 queue: .main) { [weak self] time in
			guard let duration = self?.duration(), duration > 0 else { return }
			self?.onTimeUpdate?(time.seconds, duration)
		}
	}

	private func observeEnd() {
		NotificationCenter.default.addObserver(
			forName: .AVPlayerItemDidPlayToEndTime,
			object: player?.currentItem,
			queue: .main
		) { [weak self] _ in
			self?.onFinished?()
		}
	}

	deinit {
		if let token = timeObserverToken {
			player?.removeTimeObserver(token)
		}
		NotificationCenter.default.removeObserver(self)
	}
}
