//
//  Song.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 15/07/25.
//

import Foundation

struct Song {
	let id: String
	let title: String
	let artist: String
	let album: String
	let duration: Double
	let artworkURL: URL?
	
	init(id: String, title: String, artist: String, album: String, duration: Double, artworkURL: URL? = nil) {
		self.id = id
		self.title = title
		self.artist = artist
		self.album = album
		self.duration = duration
		self.artworkURL = artworkURL
	}
	
	init(from sound: FreesoundResponse) {
		self.id = String(sound.id)
		self.title = sound.name
		self.artist = sound.username
		self.album = sound.description
		self.duration = sound.duration
		self.artworkURL = URL(string: sound.images.waveformMedium ?? "")
	}
}
