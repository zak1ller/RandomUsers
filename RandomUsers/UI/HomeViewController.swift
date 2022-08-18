//
//  ViewController.swift
//  RandomUsers
//
//  Created by Min-Su Kim on 2022/08/17.
//

import UIKit
import Combine
import Kingfisher
import NVActivityIndicatorView

class HomeViewController: UIViewController {
  
  lazy var loadingView = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin)
  
  lazy var stackView = UIStackView().then {
    $0.axis = .vertical
    $0.alignment = .center
  }
  
  lazy var userImageView = UIImageView().then {
    $0.tintColor = .darkGray
    $0.layer.borderColor = UIColor.white.cgColor
    $0.layer.borderWidth = 1
    $0.layer.cornerRadius = 75
    $0.clipsToBounds = true
  }
  
  lazy var usernameLabel = UILabel().then {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 20, weight: .heavy)
  }
  
  private let viewModel = HomeViewModel()
  private var subscriptions = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setView()
    setConstraint()
    bind()
    
    viewModel.fetchUser()
  }
  
  private func bind() {
    viewModel.$showingLoading
      .sink { showingLoading in
        if showingLoading {
          self.loadingView.startAnimating()
        } else {
          self.loadingView.stopAnimating()
        }
      }
      .store(in: &subscriptions)
    
    viewModel.$errorMessage
      .compactMap { $0 }
      .sink { errorMessage in
        let alert = UIAlertController(
          title: "Error",
          message: errorMessage,
          preferredStyle: .alert
        )
        alert.addAction(
          UIAlertAction(
            title: "Confirm",
            style: .cancel
          )
        )
        self.present(alert, animated: true)
      }
      .store(in: &subscriptions)
    
    viewModel.$user
      .sink { user in
        if let user = user {
          let imageUrl = URL(string: user.picture.large)
          self.userImageView.isHidden = false
          self.userImageView.kf.setImage(with: imageUrl, placeholder: UIImage(named: "user")?.withRenderingMode(.alwaysTemplate))
          self.usernameLabel.text = user.getUsername()
        } else {
          self.userImageView.isHidden = true
          self.usernameLabel.text = nil
        }
      }
      .store(in: &subscriptions)
  }
}

extension HomeViewController {
  private func setView() {
    view.addSubview(stackView)
    
    stackView.addArrangedSubview(userImageView)
    stackView.addArrangedSubview(UIView.makeEmptyView(width: 16, height: 16))
    stackView.addArrangedSubview(usernameLabel)
    
    view.addSubview(loadingView)
  }
  
  private func setConstraint() {
    stackView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.centerY.equalToSuperview()
    }
    
    userImageView.snp.makeConstraints { make in
      make.width.height.equalTo(150)
    }
    
    loadingView.snp.makeConstraints { make in
      make.width.height.equalTo(32)
      make.centerX.centerY.equalToSuperview()
    }
  }
}

extension HomeViewController {
  @objc func userImageTapped() {
    guard let user = viewModel.user else { return }
    
  }
}
