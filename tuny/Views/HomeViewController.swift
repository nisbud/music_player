//
//  HomeViewController.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 15/07/25.
//

import UIKit

final class HomeViewController: UIViewController, UISearchBarDelegate {
	
	private let viewModel: SongListViewModel
	private let searchBar = UISearchBar()
	private let tableView: SongTableView
	private var musicControllerView = MusicControllerView()
	private var musicControllerBottomConstraint: NSLayoutConstraint!
	
	init(viewModel: SongListViewModel) {
		self.viewModel = viewModel
		self.tableView = SongTableView(viewModel: viewModel)
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
	}
	
	private func setupViewModel() {
		
		viewModel.onDoneQuery = { [weak self] in
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
	}
	
	private func setupSearchBar() {
		searchBar.placeholder = "Search"
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(searchBar)
		
		NSLayoutConstraint.activate([
			searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	private func setupTableView() {
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func setupMusicController() {
		musicControllerView.translatesAutoresizingMaskIntoConstraints = false
		musicControllerView.isHidden = false
		view.addSubview(musicControllerView)
		
		musicControllerBottomConstraint = musicControllerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		
		NSLayoutConstraint.activate([
			musicControllerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			musicControllerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			musicControllerBottomConstraint,
			musicControllerView.heightAnchor.constraint(equalToConstant: 150)
		])
	}
}

