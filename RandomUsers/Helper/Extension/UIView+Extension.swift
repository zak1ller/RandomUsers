//
//  UIView+Extension.swift
//  RandomUsers
//
//  Created by Min-Su Kim on 2022/08/17.
//

import Foundation
import UIKit

extension UIView {
  static func makeEmptyView(width: CGFloat, height: CGFloat) -> UIView {
    let view = UIView()
    view.snp.makeConstraints { make in
      make.width.equalTo(width)
      make.height.equalTo(height)
    }
    return view
  }
}
