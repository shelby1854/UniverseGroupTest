//
//  FavoritesViewController.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

//import UIKit
//import RxSwift
//import RxCocoa
//import SnapKit
//
//final class FavoritesViewController: UIViewController {
//  // MARK: - Properties
//  private let viewModel: FavoritesViewModel
//  private let disposeBag = DisposeBag()
//  
//  // MARK: - UI
//  private lazy var tableView: UITableView = {
//    let table = UITableView()
//    table.register(FilmsTableViewCell.self, forCellReuseIdentifier: FilmsTableViewCell.reuseIdentifier)
//    return table
//  }()
//  
//  private lazy var placeholderView: UIView = {
//    let view = UIView()
//    let imageView = UIImageView(image: AppImage.FavFilms.placeholderImage)
//    imageView.contentMode = .scaleAspectFit
//    imageView.tintColor = AppColor.FavFilms.placeholderColor
//    
//    let label = UILabel()
//    label.text = viewModel.placeholderText
//    label.textColor = AppColor.FavFilms.placeholderColor
//    label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//    label.textAlignment = .center
//    label.numberOfLines = 0
//    
//    view.addSubview(imageView)
//    view.addSubview(label)
//    
//    imageView.snp.makeConstraints { make in
//      make.centerX.equalToSuperview()
//      make.centerY.equalToSuperview().offset(-40)
//      make.width.height.equalTo(80)
//    }
//    
//    label.snp.makeConstraints { make in
//      make.top.equalTo(imageView.snp.bottom).offset(16)
//      make.left.right.equalToSuperview().inset(16)
//    }
//    return view
//  }()
//  
//  private lazy var removeSelectedButton: UIBarButtonItem = {
//    let button = UIBarButtonItem(
//      image: AppImage.FavFilms.trashButton,
//      style: .plain,
//      target: self,
//      action: #selector(removeSelectedTapped)
//    )
//    return button
//  }()
//  
//  // MARK: - Init
//  init(viewModel: FavoritesViewModel) {
//    self.viewModel = viewModel
//    super.init(nibName: nil, bundle: nil)
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  // MARK: - Lifecycle
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = AppColor.Common.mainBG
//    
//    setupUI()
//    setupBindings()
//  }
//  
//  // MARK: - Setup
//  private func setupUI() {
//    view.addSubview(tableView)
//    view.addSubview(placeholderView)
//    
//    tableView.snp.makeConstraints { make in
//      make.edges.equalToSuperview()
//    }
//    
//    placeholderView.snp.makeConstraints { make in
//      make.edges.equalToSuperview()
//    }
//  }
//  
//  private func setupBindings() {
//    viewModel.filmsService.favoriteFilms
//      .bind(to: tableView.rx.items(
//        cellIdentifier: FilmsTableViewCell.reuseIdentifier,
//        cellType: FilmsTableViewCell.self
//      )) { [weak self] _, film, cell in
//        guard let self else { return }
//        cell.configure(with: film)
//        cell.contentView.backgroundColor = self.viewModel.isSelected(film) ? AppColor.FilmCell.selectedCell : .clear
//      }
//      .disposed(by: disposeBag)
//    
//    viewModel.isPlaceholderHidden
//      .observe(on: MainScheduler.instance)
//      .subscribe(onNext: { [weak self] isPlaceholderHidden in
//        guard let self else { return }
//        self.placeholderView.isHidden = isPlaceholderHidden
//        self.tableView.isHidden = !isPlaceholderHidden
//      })
//      .disposed(by: disposeBag)
//    
//    viewModel.selectedFilms
//      .subscribe(onNext: { [weak self] selectedFilms in
//        guard let self else { return }
//        self.navigationItem.rightBarButtonItem = selectedFilms.isEmpty ? nil : self.removeSelectedButton
//      })
//      .disposed(by: disposeBag)
//    
//    tableView.rx.modelSelected(FilmBO.self)
//      .subscribe(onNext: { [weak self] film in
//        self?.viewModel.toggleSelection(for: film)
//        self?.tableView.reloadData()
//      })
//      .disposed(by: disposeBag)
//    
//    tableView.rx.itemDeleted
//      .withLatestFrom(viewModel.filmsService.favoriteFilms) { (indexPath, items) -> FilmBO? in
//        guard indexPath.row < items.count else { return nil }
//        return items[indexPath.row]
//      }
//      .subscribe(onNext: { [weak self] film in
//        guard let film else { return }
//        self?.viewModel.removeFromFavorites(film: film)
//      })
//      .disposed(by: disposeBag)
//  }
//  
//  // MARK: - Actions
//  @objc private func removeSelectedTapped() {
//    let alertTexts = viewModel.removeAllAlertTexts
//    
//    let alert = UIAlertController(
//      title: alertTexts.title,
//      message: alertTexts.message,
//      preferredStyle: .alert
//    )
//    
//    alert.addAction(UIAlertAction(title: alertTexts.confirm, style: .destructive, handler: { [weak self] _ in
//      guard let self else { return }
//      self.viewModel.removeSelectedFromFavorites()
//      self.tableView.reloadData()
//    }))
//    
//    alert.addAction(UIAlertAction(title: alertTexts.cancel, style: .cancel, handler: nil))
//    self.present(alert, animated: true, completion: nil)
//  }
//}
