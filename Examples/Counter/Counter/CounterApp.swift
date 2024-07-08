//
//  CounterApp.swift
//  Counter
//
//  Created by Ethen on 7/5/24.
//

import SwiftUI

@main
struct CounterApp: App {
  var body: some Scene {
    WindowGroup {
      let reactor = CounterViewReactor()
      CounterView(reactor: reactor)
    }
  }
}
