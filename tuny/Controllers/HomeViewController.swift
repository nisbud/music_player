//
//  HomeViewController.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 15/07/25.
//

import UIKit

final class HomeViewController: UIViewController, UISearchBarDelegate {
	
	private let songListViewModel: SongListViewModel
	private let playerViewModel: PlayerViewModel
	private let searchBar = UISearchBar()
	private let tableView: SongTableView
	private var musicControllerView: MusicControllerView
	
	init(songListViewModel: SongListViewModel, playerViewModel: PlayerViewModel) {
		self.songListViewModel = songListViewModel
		self.playerViewModel = playerViewModel
		self.tableView = SongTableView(viewModel: songListViewModel)
		self.musicControllerView = MusicControllerView(viewModel: playerViewModel)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		title = "Tuny Player"
		
		setupViewModel()
		setupSearchBar()
		setupTableView()
		setupMusicController()
		setupStackLayout()
	}
	
	private func setupViewModel() {
		
		songListViewModel.onDoneQuery = { [weak self] in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
		
		playerViewModel.onFinished = { [weak self] in
			self?.tableView.onDeselectSong?()
			self?.musicControllerView.isHidden = true
		}
	}
	
	private func setupSearchBar() {
		searchBar.placeholder = "Search"
	}
	
	private func setupTableView() {
		
		tableView.onSelectSong = { [weak self] row in
			self?.musicControllerView.isHidden = false
			self?.playerViewModel.currentSong = self?.songListViewModel.songs[row]
		}
	}
	
	private func setupMusicController() {
		musicControllerView.isHidden = true
	}
	
	private func setupStackLayout() {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 8
		stackView.alignment = .fill
		stackView.distribution = .fill
		
		view.addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
		
		stackView.addArrangedSubview(searchBar)
		stackView.addArrangedSubview(tableView)
		stackView.addArrangedSubview(musicControllerView)
	}
}

