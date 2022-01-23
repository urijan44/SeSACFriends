//
//  WelcomView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/23.
//

import UIKit
import SnapKit
import SeSACFriendsUIKit

final class WelcomeViewController: NiblessViewController {

  override func loadView() {
    view = WelcomeRootView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

open class RepresentableViewController: UIViewController {
  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
  )
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
  )
  public required init?(coder aDecoder: NSCoder) {
    fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
  }
}
