//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation
import os

class ApplicationDelegate: NSObject, ObservableObject {
  @Published var launches: [LaunchRecord] = []
  var isFirstLaunch: Bool { launches.count == 1 }

  //  private var launchHistory = JSONFileLaunchHistory()
  private var loadLaunchHistory: Task<JSONFileLaunchHistory, Never>!

  private let logger = Logger(OSLog(subsystem: "br.net.ken.algorithm.lifecycle", category: .pointsOfInterest))

  func willFinishLaunching() {
    logger.trace("Application will finish launching")

    UserDefaults.standard.register(defaults: [
      "OnboardingPhase": 0,
    ])

    loadLaunchHistory = Task {
      JSONFileLaunchHistory()
    }
  }

  func didFinishLaunching() {
    Task {
      var launchHistory = await loadLaunchHistory.value
      await launchHistory += LaunchRecord()
      launches = await launchHistory.records
    }

    logger.trace("Application did finish launchig")
  }
}

#if canImport(AppKit)
import AppKit

extension ApplicationDelegate: NSApplicationDelegate {
  func applicationWillFinishLaunching(_ notification: Notification) {
    willFinishLaunching()
  }

  func applicationDidFinishLaunching(_ notification: Notification) {
    didFinishLaunching()
  }
}
#endif

#if canImport(UIKit)
import UIKit

extension ApplicationDelegate: UIApplicationDelegate {
  func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    willFinishLaunching()
    return true
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    didFinishLaunching()
    return true
  }
}
#endif
