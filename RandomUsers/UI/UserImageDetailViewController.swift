//
//  UserImageDetailViewController.swift
//  RandomUsers
//
//  Created by Min-Su Kim on 2022/08/18.
//

import UIKit

class UserImageDetailViewController: UIViewController {

  lazy var imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  var image: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setView()
    setConstraint()
    imageView.image = image
  }
  
}

extension UserImageDetailViewController {
  private func setView() {
    view.backgroundColor = .black
    
    view.addSubview(imageView)
  }
  
  private func setConstraint() {
    imageView.snp.makeConstraints { make in
      make.leading.trailing.top.bottom.equalToSuperview()
    }
  }
}
