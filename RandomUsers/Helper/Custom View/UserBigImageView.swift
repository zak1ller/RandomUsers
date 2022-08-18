//
//  UserBigImageView.swift
//  RandomUsers
//
//  Created by Min-Su Kim on 2022/08/18.
//

import UIKit

final class UserBigImageView: UIImageView {
  override init(image: UIImage?) {
    super.init(image: image)
    setView()
    setConstraint()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setView()
    setConstraint()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setView()
    setConstraint()
  }
}

extension UserBigImageView {
  private func setView() {
    self.isUserInteractionEnabled = true
    self.tintColor = .darkGray
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 75
    self.clipsToBounds = true
  }
  
  private func setConstraint() {
    self.snp.makeConstraints { make in
      make.width.height.equalTo(150)
    }
  }
}
