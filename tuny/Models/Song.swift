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
	let artworkURL: URL?
	
	init(id: String, title: String, artist: String, album: String, artworkURL: URL? = nil) {
		self.id = id
		self.title = title
		self.artist = artist
		self.album = album
		self.artworkURL = artworkURL
	}
}
