//
//  TabContentView.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/25.
//

import SwiftUI

struct TabContentView: View {

  weak var coordinator: Coordinator?

    var body: some View {
        HomeViewTest(coordinator: coordinator)
    }

  init(coordinator: Coordinator) {
    self.coordinator = coordinator
  }
}
