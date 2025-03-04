//
//  FilmsViewController.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class FilmsViewController: UIViewController {
  // MARK: - Properties
  private let viewModel: FilmsViewModel
  private let disposeBag = DisposeBag()
  
  // MARK: - UI
  private lazy var tableView: UITableView = {
    let table = UITableView()
    table.register(FilmsTableViewCell.self, forCellReuseIdentifier: FilmsTableViewCell.reuseIdentifier)
    table.rowHeight = UITableView.automaticDimension
    table.estimatedRowHeight = 100
    return table
  }()
  
  private lazy var addSelectedButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      image: AppImage.Films.addToFavStar,
      style: .done,
      target: self,
      action: #selector(addSelectedTapped)
    )
    return button
  }()
  
  // MARK: - Init
  init(viewModel: FilmsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBindings()
  }
  
  // MARK: - Setup
  private func setupUI() {
    view.backgroundColor = AppColor.Common.mainBG
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    navigationItem.rightBarButtonItem = nil
    tableView.delegate = self
  }
  
  private func setupBindings() {
    viewModel.filmsService.films
      .bind(to: tableView.rx.items(
        cellIdentifier: FilmsTableViewCell.reuseIdentifier,
        cellType: FilmsTableViewCell.self
      )) { [weak self] index, film, cell in
        guard let self else { return }
        cell.configure(with: film, showFavoriteIcon: true)
        cell.contentView.backgroundColor = self.viewModel.isSelected(film) ? AppColor.FilmCell.selectedCell : .clear
      }
      .disposed(by: disposeBag)
    
    tableView.rx.modelSelected(FilmBO.self)
      .subscribe(onNext: { [weak self] film in
        guard let self else { return }
        
        if film.isFavorite {
          self.showRemoveFavoriteAlert(for: film)
        } else {
          self.viewModel.toggleSelection(for: film)
          self.tableView.reloadData()
        }
      })
      .disposed(by: disposeBag)
    
    viewModel.selectedFilms
      .subscribe(onNext: { [weak self] selectedFilms in
        guard let self else { return }
        self.navigationItem.rightBarButtonItem = selectedFilms.isEmpty ? nil : self.addSelectedButton
      })
      .disposed(by: disposeBag)
  }
  
  // MARK: - Actions
  @objc private func addSelectedTapped() {
    viewModel.addSelectedToFavorites()
  }
  
  // MARK: - Helpers
  
  private func showRemoveFavoriteAlert(for film: FilmBO) {
    let alertTexts = viewModel.alertTexts(for: film)
    let alert = UIAlertController(
      title: alertTexts.title,
      message: alertTexts.message,
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(title: alertTexts.confirm, style: .destructive, handler: { [weak self] _ in
      self?.viewModel.toggleFavorite(for: film)
    }))
    alert.addAction(UIAlertAction(title: alertTexts.cancel, style: .cancel, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

// MARK: - UITableViewDelegate (Swipe Actions)
extension FilmsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
  ) -> UISwipeActionsConfiguration? {
    let film = viewModel.filmsService.filmsValue[indexPath.row]
    
    let action = UIContextualAction(style: .normal, title: film.trailingActionTitle) { [weak self] _, _, _ in
      self?.viewModel.toggleFavorite(for: film)
    }
    
    action.backgroundColor = film.trailingActionBackgroundColor
    
    let config = UISwipeActionsConfiguration(actions: [action])
    return config
  }
}
