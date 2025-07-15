//
//  SongTableView.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 15/07/25.
//

import UIKit

final class SongTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
	
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
		// Play music
		// Show playing icon
	}
}
