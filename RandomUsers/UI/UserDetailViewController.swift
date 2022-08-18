//
//  UserDetailViewController.swift
//  RandomUsers
//
//  Created by Min-Su Kim on 2022/08/18.
//

import Foundation
import UIKit
import Combine
import Kingfisher

final class UserDetailViewController: UIViewController {
  
  lazy var stackView = UIStackView().then {
    $0.axis = .vertical
    $0.distribution = .fill
    $0.alignment = .center
  }
  
  lazy var userImageView = UserBigImageView(image: nil).then {
    $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userImageViewTapped)))
  }
  
  lazy var usernameLabel = UILabel().then {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 20, weight: .heavy)
  }
  
  lazy var userEmailLabel = UILabel().then {
    $0.textColor = .secondaryLabel
  }

  var viewModel: UserDetailViewModel!
  var subscriptions = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setView()
    setConstraint()
    bind()
  }
  
  private func bind() {
    viewModel.$user
      .sink { user in
        let imageUrl = URL(string: user.picture.large)
        
        self.userImageView.kf.setImage(
          with: imageUrl,
          placeholder: UIImage(named: "user")?.withRenderingMode(.alwaysTemplate))
        self.usernameLabel.text = user.getUsername()
        self.userEmailLabel.text = user.email
        self.title = user.location.city
      }
      .store(in: &subscriptions)
  }
}

extension UserDetailViewController {
  private func setView() {
    self.navigationController?.navigationBar.tintColor = .white
    
    view.backgroundColor = .black
    
    view.addSubview(stackView)
    
    stackView.addArrangedSubview(userImageView)
    stackView.addArrangedSubview(UIView.makeEmptyView(width: 24, height: 24))
    stackView.addArrangedSubview(usernameLabel)
    stackView.addArrangedSubview(UIView.makeEmptyView(width: 8, height: 8))
    stackView.addArrangedSubview(userEmailLabel)
  }
  
  private func setConstraint() {
    stackView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(24)
    }
  }
}

extension UserDetailViewController {
  @objc func userImageViewTapped() {
    let vc = UserImageDetailViewController()
    vc.image = userImageView.image
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
