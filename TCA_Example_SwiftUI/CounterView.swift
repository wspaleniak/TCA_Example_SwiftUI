//
//  CounterView.swift
//  TCA_Example_SwiftUI
//
//  Created by Wojciech Spaleniak on 27/07/2023.
//

import SwiftUI
import ComposableArchitecture

// MARK: Counter
/// Typ który zawiera domenę i zachowanie funkcjonalności.
/// Musi być zgodny z `ReducerProtocol`.
struct Counter: ReducerProtocol {
    
    // STATE
    /// Struktura przechowuje aktualny stan funkcjonalności.
    struct State: Equatable {
        var count = 0
    }
    
    // ACTION
    /// Typ definiuje dostępne akcje w funkcjonalności.
    enum Action: Equatable {
        case decrement
        case increment
    }
    
    // REDUCER
    /// Metoda z protokołu `ReducerProtocol`.
    /// Metoda pozwala zdefiniować logikę działania funkcjonalności.
    /// Jeżeli dana akcja nie ma efektu to zwracamy `.none`.
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .decrement: state.count -= 1
        case .increment: state.count += 1
        }
        return .none
    }
}

struct CounterView: View {
    let store: StoreOf<Counter>
    
    var body: some View {
        
        /// `WithViewStore` przekształca Store w ViewStore.
        /// Dzięki temu stan może być obserwowany przez konstruktora widoku.
        WithViewStore(store) { viewStore in
            VStack {
                Spacer()
                Text("\(viewStore.count)")
                    .font(.largeTitle)
                Spacer()
                HStack {
                    Button(
                        action: {
                            /// Akcja wywoływana gdy klikniemy w przycisk minus.
                            viewStore.send(.decrement)
                        }, label: {
                            Image(systemName: "minus")
                                .font(.title)
                                .frame(width: 44, height: 44, alignment: .center)
                        }
                    )
                    .buttonStyle(.borderedProminent)
                    Spacer()
                    Button(
                        action: {
                            /// Akcja wywoływana gdy klikniemy w przycisk plus.
                            viewStore.send(.increment)
                        }, label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .frame(width: 44, height: 44, alignment: .center)
                        }
                    )
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
        }
    }
}
