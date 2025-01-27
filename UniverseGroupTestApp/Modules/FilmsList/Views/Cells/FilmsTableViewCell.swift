//
//  FilmsTableViewCell.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import UIKit

final class FilmsTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "FilmsTableViewCell"
   
    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = AppColor.FilmCell.title
        label.numberOfLines = 1
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = AppColor.FilmCell.description
        label.numberOfLines = 0
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = AppColor.FilmCell.description
        label.textAlignment = .right
        return label
    }()
    
    private let favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = AppColor.FilmCell.favImage
        return imageView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(favoriteImageView)

        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        favoriteImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(favoriteImageView.snp.leading).offset(-8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-48)
            make.bottom.lessThanOrEqualToSuperview().offset(-8) 
        }
    }

    // MARK: - Configuration
    func configure(with film: FilmBO, showFavoriteIcon: Bool = false) {
        titleLabel.text = film.title
        descriptionLabel.text = film.description
        releaseDateLabel.text = formatDate(film.releaseDate)
        favoriteImageView.isHidden = !showFavoriteIcon
        favoriteImageView.image = film.isFavorite ? AppImage.FilmCell.fillSquare : AppImage.FilmCell.square
        selectionStyle = .none
    }
    
    // MARK: - Helpers
    private func formatDate(_ milliseconds: Int) -> String {
        let date = Date(milisecondsSince1970: milliseconds)
        return date.toString(withFormat: .dayMonthYear)
    }
}
