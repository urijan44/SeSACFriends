//
//  GenderRootView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/01/31.
//

import UIKit
import SeSACFriendsUIKit
import RxSwift
import RxRelay

protocol GenderRootViewDelegate: AnyObject {
  func genderCheck()
  func cancelGenderCheck()
  func nicknameFailure()
}

final class GenderRootView: RepresentableView {

  let viewModel: GenderViewModel
  let bag = DisposeBag()

  lazy var leftBarButtonItem = UIBarButtonItem(image: Images.arrow.image, style: .plain, target: self, action: nil)

  lazy var titleLabel = UILabel(typoStyle: .display1).then {
    $0.text = "성별을 선택해 주세요"
  }

  lazy var infolabel = UILabel(typoStyle: .title2).then {
    $0.textColor = .seSACGray7
    $0.textAlignment = .center
    $0.text = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
  }

  let genderPicker = SeSACGenderPicker()

  let nextButton = SeSACButton(style: .fill).then {
    $0.title = "다음"
    $0.isDisabled = true
  }

  weak var delegate: GenderRootViewDelegate?

  init(frame: CGRect = .zero,
       viewModel: GenderViewModel,
       delegate: GenderRootViewDelegate?) {
    self.viewModel = viewModel
    self.delegate = delegate
    super.init(frame: frame)
    backgroundColor = .white
  }

  override func createView() {
    addSubview(titleLabel)
    addSubview(infolabel)
    addSubview(genderPicker)
    addSubview(nextButton)
  }

  override func layoutConfigure() {
    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(169)
    }

    infolabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
    }

    genderPicker.snp.makeConstraints { make in
      make.height.equalTo(120)
      make.top.equalTo(infolabel.snp.bottom).offset(32)
      make.centerX.equalToSuperview()
      make.leading.trailing.equalToSuperview().inset(12)
    }

    nextButton.snp.makeConstraints { make in
      make.top.equalTo(snp.top).offset(429)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.equalTo(44)
    }
  }

  override func bind() {
    let input = GenderViewModel.Input(
      genderInput: genderPicker.gender.asObservable(),
      nextButton: nextButton.rx.tap.asObservable())

    let output = viewModel.transform(input)

    output.nextButtonDisabled.asDriver()
      .drive(nextButton.rx.isDisabled)
      .disposed(by: bag)

    output.present.subscribe(onNext: { [weak self] _ in
      self?.delegate?.genderCheck()
    }).disposed(by: bag)

    output.nicknameFailure.subscribe(onNext: { [weak self] _ in
      self?.delegate?.nicknameFailure()
    }).disposed(by: bag)

    leftBarButtonItem.rx.tap.subscribe(onNext: { [weak self] _ in
      self?.delegate?.cancelGenderCheck()
    }).disposed(by: bag)
  }

}
