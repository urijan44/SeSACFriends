//
//  WelcomView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/23.
//

import UIKit
import SnapKit
import SeSACFriendsUIKit

protocol WelcomeViewControllerDelegate: AnyObject {
  func startonBoardingButton()
}

final class WelcomeViewController: NiblessViewController {

  //viewModel
  //viewModel output->Button
  let viewModel: WelcomeViewModel
  lazy var rootView = WelcomeRootView(viewModel: viewModel)
  weak var delegate: WelcomeViewControllerDelegate?

  init(viewModel: WelcomeViewModel, delegate: WelcomeViewControllerDelegate) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init()
  }

  override func loadView() {
    view = rootView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
  }

  private func bind() {
    rootView.startButton.addAction(UIAction() { [weak self] _ in
      self?.delegate?.startonBoardingButton()
    }, for: .touchUpInside)
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
