//
//  CounterView.swift
//  Counter
//
//  Created by Ethen on 7/5/24.
//

import SwiftUIReactorKit

struct CounterView: ReactorView {
  var reactor: CounterViewReactor
  
  func body(reactor: CounterViewReactor.ObservableObject) -> some View {
    ZStack {
      HStack(alignment: .center) {
        Button(action: {
          reactor.action.onNext(.decrease)
        }) {
          Text("-")
            .font(.title)
        }
        .frame(width: 30, height: 46)
        
        Text("\(reactor.state.value)")
          .font(.title)
          .foregroundColor(.black)
          .frame(maxWidth: .infinity)
        
        Button(action: {
          reactor.action.onNext(.increase)
        }) {
          Text("+")
            .font(.title)
        }
        .frame(width: 30, height: 46)
      }
      .padding(.horizontal, 30)
      
      ProgressView()
        .padding(.top, 150)
        .opacity(reactor.state.isLoading ? 1 : 0)
    }
    .onReceive(reactor.pulse(\.$alertMessage)) { alertMessage in
      let alertController = UIAlertController(
        title: nil,
        message: alertMessage,
        preferredStyle: .alert
      )
      alertController.addAction(UIAlertAction(
        title: "OK",
        style: .default,
        handler: nil
      ))
      self.rootController?.present(alertController, animated: true)
    }
  }
  
  private var rootController: UIViewController? {
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let root = screen.windows.first?.rootViewController else {
      return nil
    }
    return root
  }
}
