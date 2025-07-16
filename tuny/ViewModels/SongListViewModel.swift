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
		
		querySongs()
	}
	
//	func fetchSong(id: Int) {
//		isFetching = true
//		
//		service.fetchSong(id: id) { [weak self] result in
//			
//			switch result {
//			case .success(let sound):
//				let song = Song(from: sound)
//				self?.songs.append(song)
//				
//			case .failure(let error):
//				print("Error loading sound: \(error)")
//			}
//			
//			self?.isFetching = false
//			self?.onDoneFetch?()
//		}
//	}
	
	func querySongs() {
		isFetching = true
		
		service.querySongs(query: "piano") { [weak self] result in
			
			switch result {
			case .success(let soundList):
				soundList.results.forEach { sound in
					let song = Song(from: sound)
					self?.songs.append(song)
				}
				
			case .failure(let error):
				print("Error loading sound: \(error)")
			}
			
			self?.isFetching = false
			self?.onDoneQuery?()
		}
	}
}
