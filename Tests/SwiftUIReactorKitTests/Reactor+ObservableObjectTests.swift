import XCTest
import ReactorKit
import Combine
@testable import SwiftUIReactorKit

final class Reactor_ObservableObjectTests: XCTestCase {
  func testObservableObject_actionMemoryAddress() {
    let reactor = TestReactor()
    XCTAssertTrue(reactor.action === reactor.observableObject.action)
  }
  
  func testObservableObject_stateFromInitialState() {
    let reactor = TestReactor()
    XCTAssertEqual(reactor.observableObject.state.alertMessage, nil)
    XCTAssertEqual(reactor.observableObject.state.count, 0)
  }
  
  func testObservableObject_stateFromStateStream() {
    let reactor = TestReactor()
    reactor.isStubEnabled = true
    reactor.stub.state.accept(.init(count: 5))
    XCTAssertEqual(reactor.observableObject.state.alertMessage, nil)
    XCTAssertEqual(reactor.observableObject.state.count, 5)
  }
  
  func testObservableObject_pulse() {
    // given
    let reactor = TestReactor()
    var cancellable = Set<AnyCancellable>()
    var receivedAlertMessages: [String] = []

    reactor.observableObject.pulse(\.$alertMessage)
      .compactMap { $0 }
      .sink { alertMessage in
        receivedAlertMessages.append(alertMessage)
      }
      .store(in: &cancellable)

    // when
    reactor.action.onNext(.showAlert(message: "1")) // alert '1'
    reactor.action.onNext(.increaseCount)           // ignore
    reactor.action.onNext(.showAlert(message: nil)) // ignore
    reactor.action.onNext(.showAlert(message: "2")) // alert '2'
    reactor.action.onNext(.showAlert(message: nil)) // ignore
    reactor.action.onNext(.increaseCount)           // ignore
    reactor.action.onNext(.showAlert(message: nil)) // ignore
    reactor.action.onNext(.showAlert(message: "3")) // alert '3'
    reactor.action.onNext(.showAlert(message: "3")) // alert '3'

    // then
    XCTAssertEqual(receivedAlertMessages, [
      "1",
      "2",
      "3",
      "3",
    ])
    XCTAssertEqual(reactor.currentState.count, 2)
  }
  
  func testDispose() {
    weak var weakReactor: TestReactor?
    weak var weakObservableObject: TestReactor.ObservableObject?
    weak var weakAction: ActionSubject<TestReactor.Action>?
    weak var weakState: Observable<TestReactor.State>?

    _ = {
      let reactor = TestReactor()
      weakReactor = reactor
      weakObservableObject = reactor.observableObject
      weakAction = reactor.action
      weakState = reactor.state
    }()

    XCTAssertNil(weakReactor)
    XCTAssertNil(weakObservableObject)
    XCTAssertNil(weakAction)
    XCTAssertNil(weakState)
  }
}

private final class TestReactor: Reactor {
  enum Action {
    case showAlert(message: String?)
    case increaseCount
  }

  enum Mutation {
    case setAlertMessage(String?)
    case increaseCount
  }

  struct State {
    @Pulse var alertMessage: String?
    var count: Int = 0
  }

  let initialState = State()

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .showAlert(message):
      return Observable.just(Mutation.setAlertMessage(message))

    case .increaseCount:
      return Observable.just(Mutation.increaseCount)
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state

    switch mutation {
    case let .setAlertMessage(alertMessage):
      newState.alertMessage = alertMessage

    case .increaseCount:
      newState.count += 1
    }

    return newState
  }
}
