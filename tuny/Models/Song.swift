//
//  Song.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 15/07/25.
//

import Foundation

struct Song {
	let id: String
	let track: URL?
	let title: String
	let artist: String
	let album: String
	let duration: Double
	let artworkURL: URL?
	
	init(id: String, track: URL? = nil, title: String, artist: String, album: String, duration: Double, artworkURL: URL? = nil) {
		self.id = id
		self.track = track
		self.title = title
		self.artist = artist
		self.album = album
		self.duration = duration
		self.artworkURL = artworkURL
	}
	
	init(from sound: FreesoundSoundResponse) {
		self.id = String(sound.id)
		self.track = URL(string: sound.previews.previewLqMp3 ?? "")
		self.title = sound.name
		self.artist = sound.username
		self.album = sound.duration.asTime()
		self.duration = sound.duration
		self.artworkURL = URL(string: sound.images.waveformMedium ?? "")
	}
}
