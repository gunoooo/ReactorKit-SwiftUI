//
//  Reactor+ObservableObject.swift
//  SwiftUIReactorKit
//
//  Created by Ethen on 7/2/24.
//

import Combine

import ReactorKit
import WeakMapTable

/// Reactor for an observable object
/// Sets the state using the initialState and state stream received from the original reactor,
/// and makes it an observable object by adopting `ObservableObject`.
public final class ObservableReactor<Reactor: ReactorKit.Reactor>: ObservableObject {
  private let disposeBag = DisposeBag()
  
  @Published public private(set) var state: Reactor.State
  public let action: ActionSubject<Reactor.Action>
  
  public init(initialState: Reactor.State, state: Observable<Reactor.State>, action: ActionSubject<Reactor.Action>) {
    self.state = initialState
    self.action = action
    state
      .subscribe(onNext: { [weak self] state in
        self?.state = state
      })
      .disposed(by: disposeBag)
  }
  
  public func pulse<Result>(_ transformToPulse: @escaping (Reactor.State) -> Pulse<Result>) -> AnyPublisher<Result, Never> {
    _state.projectedValue.map(transformToPulse).removeDuplicates(by: { $0.valueUpdatedCount == $1.valueUpdatedCount }).dropFirst().map(\.value).eraseToAnyPublisher()
  }
}


// MARK: - Map Tables

private typealias AnyReactor = AnyObject
private enum MapTables {
  static let observableObject = WeakMapTable<AnyReactor, AnyObject>()
}


// MARK: - Default Implementations

extension Reactor {
  public typealias ObservableObject = ObservableReactor<Self>
  
  public var observableObject: ObservableObject {
    MapTables.observableObject.forceCastedValue(forKey: self, default: ObservableObject(initialState: initialState, state: state, action: action))
  }
}
