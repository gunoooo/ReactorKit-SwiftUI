//
//  ReactorView.swift
//  SwiftUIReactorKit
//
//  Created by Ethen on 7/2/24.
//

import ReactorKit

public struct WithReactor<Reactor: ReactorKit.Reactor, Content: SwiftUI.View>: SwiftUI.View {
  private let content: (ObservableReactor<Reactor>) -> Content
  
  @ObservedObject private var reactor: Reactor.ObservableObject
  
  public init(
    _ reactor: Reactor,
    @ViewBuilder content: @escaping (Reactor.ObservableObject) -> Content
  ) {
    self.content = content
    self.reactor = reactor.observableObject
  }
  
  public var body: some SwiftUI.View {
    content(reactor)
  }
}

/// A ReactorView is a SwiftUI View that displays data by binding user inputs to Reactor
/// actions and Reactor states to UI components. This View serves as a bridge between
/// the Reactor and the SwiftUI view hierarchy, ensuring that the view reflects the current
/// state of the Reactor and that user actions are propagated to the Reactor. There's no business
/// logic in a view layer.
///
/// ```swift
/// struct MyView: ReactorView {
///   var reactor: MyReactor
///
///   func body(reactor: MyReactor.ObservableObject) -> some View {
///     // ...
///   }
/// }
/// ```
public protocol ReactorView: SwiftUI.View where Body == WithReactor<Self.Reactor, Self.Content> {
  
  associatedtype Reactor: ReactorKit.Reactor
  
  associatedtype Content: SwiftUI.View
  
  var reactor: Reactor { get set }
  
  func body(reactor: Reactor.ObservableObject) -> Content
}


// MARK: - Default Implementations

public extension ReactorView {
  /// Default implementation of the body property for ReactorView
  /// This wraps the custom body implementation with a `WithReactor`
  var body: Body {
    WithReactor(reactor, content: body)
  }
}
