//
//  MockAudioPlayer.swift
//  tunyTests
//
//  Created by Anisa Budi Arthati on 17/07/25.
//

import AVFoundation
@testable import tuny

final class MockAudioPlayer: AudioPlayable {
	
	var onTimeUpdate: ((Double, Double) -> Void)?
	var onFinished: (() -> Void)?
	
	var isPlayingFlag = false
	var loadedURL: URL?
	var didPause = false
	var didPlay = false
	var didSeekTo: Double?

	func isPlaying() -> Bool {
		return isPlayingFlag
	}

	func pause() {
		didPause = true
		isPlayingFlag = false
	}

	func play() {
		didPlay = true
		isPlayingFlag = true
	}

	func seek(to seconds: Double) {
		didSeekTo = seconds
	}

	func load(url: URL) {
		loadedURL = url
	}
}
