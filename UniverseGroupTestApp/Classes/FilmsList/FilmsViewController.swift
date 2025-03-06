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
import RxDataSources

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
      action: nil
    )
    return button
  }()
  
  private lazy var sortButton: UIBarButtonItem = {
    let button = UIBarButtonItem(
      title: "Sort",
      style: .plain,
      target: nil,
      action: nil
    )
    return button
  }()
  
  private var dataSource: RxTableViewSectionedAnimatedDataSource<FilmSection> {
    let dataSource = RxTableViewSectionedAnimatedDataSource<FilmSection>(
      configureCell: { [weak self] _, tableView, indexPath, film in
        guard let self else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(
          withIdentifier: FilmsTableViewCell.reuseIdentifier,
          for: indexPath
        ) as! FilmsTableViewCell
        
        cell.configure(
          with: film,
          isSelected: viewModel.isSelected(film),
          showFavoriteIcon: true
        )
        return cell
      }, titleForHeaderInSection: { dataSource, sectionIndex in
        dataSource.sectionModels[sectionIndex].identity
      }
    )
    return dataSource
  }
  
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
    title = "Films"
    view.backgroundColor = AppColor.Common.mainBG
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    navigationItem.rightBarButtonItems = [sortButton]
  }
  
  private func setupBindings() {
    viewModel.output.sections
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)

    tableView.rx.modelSelected(FilmBO.self)
      .subscribe(onNext: { [weak self] film in
        guard let self else { return }
        
        if film.isFavorite {
          self.showRemoveFavoriteAlert(for: film)
        } else {
          self.viewModel.input.selectFilm.onNext(film)
        }
      })
      .disposed(by: disposeBag)
    
    addSelectedButton.rx.tap
      .bind(to: viewModel.input.addSelected)
      .disposed(by: disposeBag)
    
    sortButton.rx.tap
      .bind(to: viewModel.input.toogleSort)
      .disposed(by: disposeBag)
    
    Observable
      .combineLatest(
        viewModel.output.sections,
        viewModel.output.selectedFilms
      )
      .scan((([], [] as [FilmBO]), ([], [] as [FilmBO]))) { previous, new in
        (previous.1, new)
      }
      .subscribe(onNext: { [weak self] oldState, newState in
        guard let self else { return }
        
        let (_, oldSelected) = oldState
        let (newSections, newSelected) = newState
        
        if newSelected.isEmpty {
          self.navigationItem.rightBarButtonItems = [self.sortButton]
        } else {
          self.navigationItem.rightBarButtonItems = [self.sortButton, self.addSelectedButton]
        }
        
        let oldSelectedIds = Set(oldSelected.map { $0.id })
        let newSelectedIds = Set(newSelected.map { $0.id })
        let changedSelectedIds = oldSelectedIds.symmetricDifference(newSelectedIds)
        
        var indexPathsToReload: [IndexPath] = []
        if let visiblePaths = self.tableView.indexPathsForVisibleRows {
          for indexPath in visiblePaths {
            guard indexPath.section < newSections.count,
                  indexPath.row < newSections[indexPath.section].items.count
            else { continue }
            
            let film = newSections[indexPath.section].items[indexPath.row]
            if changedSelectedIds.contains(film.id) {
              indexPathsToReload.append(indexPath)
            }
          }
        }
        
        if !indexPathsToReload.isEmpty {
          self.tableView.reloadRows(at: indexPathsToReload, with: .automatic)
        }
      })
      .disposed(by: disposeBag)
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
