//
//  PlayerViewModel.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 17/07/25.
//

import Foundation

final class PlayerViewModel {
	
	var onProgressUpdate: ((Double, Double) -> Void)?
	var onPlay: ((Bool) -> Void)?
	var onFinished: (() -> Void)?

	var currentSong: Song? {
		didSet {
			load()
		}
	}
	
	var isPlaying: Bool {
		return player.isPlaying()
	}

	private let player: AudioPlayer
	
	init(player: AudioPlayer = AudioPlayer.shared) {
		self.player = player
		
		bindAudioEvents()
	}

	func togglePlayback() {
		if player.isPlaying() {
			player.pause()
			onPlay?(false)
		} else {
			player.play()
			onPlay?(true)
		}
	}
	
	func seek(to seconds: Double) {
		player.seek(to: seconds)
	}
	
	private func bindAudioEvents() {
		player.onTimeUpdate = { [weak self] current, duration in
			self?.onProgressUpdate?(current, duration)
		}
		
		player.onFinished = { [weak self] in
			self?.currentSong = nil
			self?.onFinished?()
		}
	}
	
	private func load() {
		guard let song = currentSong, let url = song.track else {
			return
		}
		
		player.load(url: url)
		onPlay?(true)
	}
}
