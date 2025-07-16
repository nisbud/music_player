//
//  SongListViewModel.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 15/07/25.
//

final class SongListViewModel {
	
	var isFetching: Bool = true
	var onDoneFetch: (() -> Void)?
	var onDoneQuery: (() -> Void)?
	
	private(set) var songs: [Song] = []
	private let service: SongService
	
	init(service: SongService = SongService.shared) {
		self.service = service
		
		fetchSongs()
	}
	
	private func fetchSongs() {
		isFetching = true
		
		service.fetchSong(id: 816302) { [weak self] result in
			
			switch result {
			case .success(let sound):
				let song = Song(from: sound)
				self?.songs.append(song)
				
			case .failure(let error):
				print("Error loading sound: \(error)")
			}
			
			self?.isFetching = false
			self?.onDoneFetch?()
		}
	}
}
