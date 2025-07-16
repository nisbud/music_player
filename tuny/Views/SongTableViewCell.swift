//
//  SongTableViewCell.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 15/07/25.
//

import UIKit

final class SongTableViewCell: UITableViewCell {
	
	private let songImageView = UIImageView()
	private let songNameLabel = UILabel()
	private let artistLabel = UILabel()
	private let albumLabel = UILabel()
	private let playingIndicator = UIImageView()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		hidePlayingIndicator()
	}
	
	func configure(with song: Song) {
		songNameLabel.text = song.title
		artistLabel.text = song.artist
		albumLabel.text = song.album
		
		configureImage(of: song)
	}
	
	func showPlayingIndicator() {
		playingIndicator.isHidden = false
	}
	
	func hidePlayingIndicator() {
		playingIndicator.isHidden = true
	}
	
	private func setupViews() {
		setupCellStyle()
		setupSongImage()
		setupNameLabel()
		setupArtistLabel()
		setupAlbumLabel()
		setupPlayingIndicator()
		setupStackLayout()
	}
	
	private func setupCellStyle() {
		selectionStyle = .none
	}
	
	private func setupSongImage() {
		songImageView.image = UIImage(named: "icon_song")
		songImageView.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupNameLabel() {
		songNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
		songNameLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupArtistLabel() {
		artistLabel.font = UIFont.systemFont(ofSize: 14)
		artistLabel.textColor = .darkGray
		artistLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupAlbumLabel() {
		albumLabel.font = UIFont.systemFont(ofSize: 12)
		albumLabel.textColor = .gray
		albumLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	private func setupPlayingIndicator() {
		playingIndicator.image = UIImage(named: "icon_playing")
		playingIndicator.translatesAutoresizingMaskIntoConstraints = false
		playingIndicator.contentMode = .scaleAspectFit
		playingIndicator.isHidden = true
	}
	
	private func setupStackLayout() {
		let textStack = UIStackView(arrangedSubviews: [songNameLabel, artistLabel, albumLabel])
		textStack.axis = .vertical
		textStack.spacing = 2
		textStack.alignment = .leading
		textStack.distribution = .fillProportionally
		
		let mainStack = UIStackView(arrangedSubviews: [songImageView, textStack, playingIndicator])
		mainStack.axis = .horizontal
		mainStack.spacing = 10
		mainStack.alignment = .center
		mainStack.distribution = .fill
		
		mainStack.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(mainStack)
		
		NSLayoutConstraint.activate([
			mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
			mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
		])
		
		NSLayoutConstraint.activate([
			songImageView.widthAnchor.constraint(equalToConstant: 50),
			songImageView.heightAnchor.constraint(equalToConstant: 50)
		])
		
		NSLayoutConstraint.activate([
			playingIndicator.widthAnchor.constraint(equalToConstant: 48),
			playingIndicator.heightAnchor.constraint(equalToConstant: 48)
		])
	}
	
	private func configureImage(of song: Song) {
		DispatchQueue.global(qos: .userInitiated).async { [weak self] in
			if let url = song.artworkURL, let data = try? Data(contentsOf: url) {
				DispatchQueue.main.async {
					self?.songImageView.image = UIImage(data: data)
				}
			}
		}
	}
}
