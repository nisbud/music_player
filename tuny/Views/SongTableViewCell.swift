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
		setupConstraints()
	}
	
	private func setupCellStyle() {
		selectionStyle = .none
	}
	
	private func setupSongImage() {
		songImageView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(songImageView)
	}
	
	private func setupNameLabel() {
		songNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
		songNameLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(songNameLabel)
	}
	
	private func setupArtistLabel() {
		artistLabel.font = UIFont.systemFont(ofSize: 14)
		artistLabel.textColor = .darkGray
		artistLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(artistLabel)
	}
	
	private func setupAlbumLabel() {
		albumLabel.font = UIFont.systemFont(ofSize: 12)
		albumLabel.textColor = .gray
		albumLabel.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(albumLabel)
	}
	
	private func setupPlayingIndicator() {
		playingIndicator.image = UIImage(named: "icon_playing")
		playingIndicator.translatesAutoresizingMaskIntoConstraints = false
		playingIndicator.contentMode = .scaleAspectFit
		playingIndicator.isHidden = true
		contentView.addSubview(playingIndicator)
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			songImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			songImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			songImageView.widthAnchor.constraint(equalToConstant: 50),
			songImageView.heightAnchor.constraint(equalToConstant: 50),
			
			songNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			songNameLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 10),
			songNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -70),
			
			artistLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 2),
			artistLabel.leadingAnchor.constraint(equalTo: songNameLabel.leadingAnchor),
			
			albumLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 2),
			albumLabel.leadingAnchor.constraint(equalTo: songNameLabel.leadingAnchor),
			albumLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
			
			playingIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			playingIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
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
			} else {
				DispatchQueue.main.async {
					self?.songImageView.image = UIImage(named: "icon_song")
				}
			}
		}
	}
}
