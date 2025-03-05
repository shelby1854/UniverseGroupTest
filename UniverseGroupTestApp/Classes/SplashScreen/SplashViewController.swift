//
//  SplashViewController.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 25.01.2025.
//

import UIKit
import SnapKit
import RxSwift

final class SplashViewController: UIViewController {
  // MARK: - Properties
  private let viewModel: SplashViewModel
  private let disposeBag = DisposeBag()
  
  // MARK: - UI
  private let activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.color = AppColor.Splash.indicatorColor
    indicator.hidesWhenStopped = true
    return indicator
  }()
  
  private let loadingLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.italicSystemFont(ofSize: 24)
    label.numberOfLines = 1
    return label
  }()
  
  // MARK: - Init
  init(viewModel: SplashViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = AppColor.Common.mainBG
    setupUI()
    setupBindings()
    activityIndicator.startAnimating()
  }
  
  // MARK: - Setup
  private func setupUI() {
    view.addSubview(activityIndicator)
    view.addSubview(loadingLabel)
    
    activityIndicator.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    loadingLabel.snp.makeConstraints { make in
      make.top.equalTo(activityIndicator.snp.bottom).offset(8)
      make.centerX.equalToSuperview()
    }
  }
  
  private func setupBindings() {
    viewModel.output.loadingText
      .bind(to: loadingLabel.rx.text)
      .disposed(by: disposeBag)
  }
}
