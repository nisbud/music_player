//
//  SongTableView.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 15/07/25.
//

import UIKit

final class SongTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
	
	enum Reason {
		case finished
		case next
		case prev
	}
	
	var onSelectSong: ((Int) -> Void)?
	
	private let viewModel: SongListViewModel
	
	init(viewModel: SongListViewModel) {
		self.viewModel = viewModel
		
		super.init(frame: .zero, style: .plain)
		setupTableView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupTableView() {
		translatesAutoresizingMaskIntoConstraints = false
		
		dataSource = self
		delegate = self
		register(SongTableViewCell.self, forCellReuseIdentifier: "SongCell")
	}
	
	private func selectSong(by indexPath: IndexPath) {
		guard indexPath.row < viewModel.songs.count, let cell = cellForRow(at: indexPath) as? SongTableViewCell else {
			return
		}
		
		cell.showPlayingIndicator()
		onSelectSong?(indexPath.row)
	}
	
	func updateSelectedRow(reason: Reason) {
		guard
			let selectedIndexPath = indexPathForSelectedRow,
			selectedIndexPath.row < viewModel.songs.count,
			let cell = cellForRow(at: selectedIndexPath) as? SongTableViewCell else
		{
			return
		}
		
		switch reason {
		case .finished:
			deselectRow(at: selectedIndexPath, animated: true)
			cell.hidePlayingIndicator()
		case .next:
			deselectRow(at: selectedIndexPath, animated: true)
			cell.hidePlayingIndicator()
			
			let newIndexPath = IndexPath(row: selectedIndexPath.row+1, section: 0)
			selectRow(at: newIndexPath, animated: true, scrollPosition: .middle)
			selectSong(by: newIndexPath)
		case .prev:
			deselectRow(at: selectedIndexPath, animated: true)
			cell.hidePlayingIndicator()
			
			let newIndexPath = IndexPath(row: selectedIndexPath.row-1, section: 0)
			selectRow(at: newIndexPath, animated: true, scrollPosition: .middle)
			selectSong(by: newIndexPath)
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.songs.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard indexPath.row < viewModel.songs.count, let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongTableViewCell else {
			return UITableViewCell()
		}
		
		cell.configure(with: viewModel.songs[indexPath.row])
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectSong(by: indexPath)
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		guard indexPath.row < viewModel.songs.count, let cell = tableView.cellForRow(at: indexPath) as? SongTableViewCell else {
			return
		}
		
		cell.hidePlayingIndicator()
	}
}
