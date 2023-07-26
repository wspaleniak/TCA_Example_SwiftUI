//
//  TCA_Example_SwiftUIApp.swift
//  TCA_Example_SwiftUI
//
//  Created by Wojciech Spaleniak on 27/07/2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_Example_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            CounterView(
                store: Store(
                    initialState: Counter.State(),
                    reducer: { Counter() }
                )
            )
        }
    }
}
