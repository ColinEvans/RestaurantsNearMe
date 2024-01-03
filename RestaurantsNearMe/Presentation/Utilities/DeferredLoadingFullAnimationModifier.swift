//
//  DeferredLoadingFullAnimationModifier.swift
//  RestaurantsNearMe
//
//  Created by Colin Evans on 2023-12-31.
//

import Foundation
import SwiftUI

struct DeferredLoadingFullAnimationModifier: ViewModifier {
  var isLoading: Bool
  @Binding var hasCompletedOnce: Bool
  
  init(
    isLoading: Bool,
    hasCompleted: Binding<Bool> = .constant(true)
  ) {
    self.isLoading = isLoading
    self._hasCompletedOnce = hasCompleted
  }

  @State private var loadingIndicatorVisible = false

  /// Sleeps for a set time to allow the underlying animation to finish before showing the loading indicator
  @State private var deferredTask: Task<Void, Never>?
  
  func body(content: Content) -> some View {
    content
      .opacity(loadingIndicatorVisible ? 0 : 1)
      .overlay {
        if loadingIndicatorVisible {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
        }
      }
      .onChange(of: isLoading, initial: false) { _, newValue in
        deferredTask?.cancel()
        
        if !newValue && hasCompletedOnce {
          loadingIndicatorVisible = false
          return
        }
        
        deferredTask = Task {
          try? await Task.sleep(for: .seconds(0.5))
          guard !Task.isCancelled else { return }
          hasCompletedOnce = true
          
          if newValue {
            loadingIndicatorVisible = true
          }
        }
      }
      .animation(.easeInOut, value: loadingIndicatorVisible)
  }
}

extension View {
  func deferredLoading(
    isLoading: Bool,
    hasCompleted: Binding<Bool> = .constant(true)
  ) -> some View {
    modifier(
      DeferredLoadingFullAnimationModifier(
        isLoading: isLoading,
        hasCompleted: hasCompleted
      )
    )
  }
}
