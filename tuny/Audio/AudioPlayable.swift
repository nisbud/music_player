//
//  AudioPlayable.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 17/07/25.
//

import Foundation

protocol AudioPlayable {
	
	var onTimeUpdate: ((Double, Double) -> Void)? { get set }
	var onFinished: (() -> Void)? { get set }
	
	func load(url: URL)
	func play()
	func pause()
	func isPlaying() -> Bool
	func seek(to seconds: Double)
}
