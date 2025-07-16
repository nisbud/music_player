//
//  PlayerViewModelTests.swift
//  tunyTests
//
//  Created by Anisa Budi Arthati on 17/07/25.
//

import XCTest
@testable import tuny

final class PlayerViewModelTests: XCTestCase {
	
	func testTogglePlayback_pausesAndPlaysCorrectly() {
		let mockPlayer = MockAudioPlayer()
		let viewModel = PlayerViewModel(player: mockPlayer)
		
		var playStates: [Bool] = []
		
		viewModel.onPlay = { isPlaying in
			playStates.append(isPlaying)
		}
		
		viewModel.togglePlayback()
		XCTAssertTrue(mockPlayer.didPlay)
		XCTAssertEqual(playStates.last, true)
		
		viewModel.togglePlayback()
		XCTAssertTrue(mockPlayer.didPause)
		XCTAssertEqual(playStates.last, false)
	}
	
	func testSeek_callsPlayerSeek() {
		let mockPlayer = MockAudioPlayer()
		let viewModel = PlayerViewModel(player: mockPlayer)
		
		viewModel.seek(to: 42.0)
		
		XCTAssertEqual(mockPlayer.didSeekTo, 42.0)
	}
	
	func testSetCurrentSong_loadsURLAndTriggersPlay() {
		let mockPlayer = MockAudioPlayer()
		let viewModel = PlayerViewModel(player: mockPlayer)
		
		let song = Song(id: "1", track: URL(string: "https://test.com/audio.mp3"), title: "Test", artist: "Artist", album: "Album", duration: 0.0, artworkURL: nil)
		
		var didPlay = false
		viewModel.onPlay = { isPlaying in
			didPlay = isPlaying
		}
		
		viewModel.currentSong = song
		
		XCTAssertEqual(mockPlayer.loadedURL, song.track)
		XCTAssertTrue(didPlay)
	}
	
	func testOnFinishedResetsCurrentSongAndTriggersCallback() {
		let mockPlayer = MockAudioPlayer()
		let viewModel = PlayerViewModel(player: mockPlayer)
		
		let song = Song(id: "1", track: URL(string: "https://test.com/audio.mp3"), title: "Test", artist: "Artist", album: "Album", duration: 0.0, artworkURL: nil)
		
		viewModel.currentSong = song
		
		var didCallFinished = false
		viewModel.onFinished = {
			didCallFinished = true
		}
		
		mockPlayer.onFinished?()
		
		XCTAssertNil(viewModel.currentSong)
		XCTAssertTrue(didCallFinished)
	}
	
	func testProgressCallbackIsPropagated() {
		let mockPlayer = MockAudioPlayer()
		let viewModel = PlayerViewModel(player: mockPlayer)
		
		var reportedCurrent: Double = 0
		var reportedDuration: Double = 0
		
		viewModel.onProgressUpdate = { current, duration in
			reportedCurrent = current
			reportedDuration = duration
		}
		
		mockPlayer.onTimeUpdate?(12.5, 120)
		
		XCTAssertEqual(reportedCurrent, 12.5)
		XCTAssertEqual(reportedDuration, 120)
	}
}
