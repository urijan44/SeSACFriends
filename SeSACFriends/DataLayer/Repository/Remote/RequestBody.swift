//
//  RequestBody.swift
//  SeSACFriends
//
//  Created by hoseung Lee on 2022/02/02.
//

import Foundation

struct RequestBody {

  struct WWWForm {
    let key: String
    let value: String
  }

  private var body: String = ""

  mutating func append(form: WWWForm) {
    if !body.isEmpty {
      body.write("&")
    }
    body.write(form.key)
    body.write("=\(form.value)")
  }

  mutating func append(contentsOf forms: [WWWForm]) {
    forms.forEach { form in
      append(form: form)
    }
  }

  func convertData() -> Data {
    guard let data = body.data(using: .utf8) else { fatalError("data convert must success")}
    return data
  }
}
