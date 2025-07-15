//
//  SongListViewModel.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 15/07/25.
//

final class SongListViewModel {
	private(set) var songs: [Song] = []
	
	init() {
		fetchSongs()
	}
	
	private func fetchSongs() {
		self.songs = [
			Song(id: "id1", title: "title1", artist: "artist1", album: "album1"),
			Song(id: "id2", title: "title2", artist: "artist2", album: "album2"),
			Song(id: "id3", title: "title3", artist: "artist3", album: "album3"),
			Song(id: "id4", title: "title4", artist: "artist4", album: "album4"),
			Song(id: "id5", title: "title5", artist: "artist5", album: "album5")
		]
	}
}
