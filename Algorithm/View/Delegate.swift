//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation
import os

extension Application {
  class Delegate: NSObject, ObservableObject {
    private let logger = Logger(OSLog(subsystem: "br.net.ken.algorithm", category: .pointsOfInterest))

    private let launch = Launch()
    private func recordLaunch(after lastID: UUID) async {
      let recorder = Launch.Recorder()
      await recorder.record(launch, after: lastID)
      launchHistory = await recorder.history
    }

    @Published var launchHistory: Launch.History = []
    @Published var isFirstLaunch = true

    func willFinishLaunching() {
      logger.trace("Application will finish launching...")

      let defaults: [Default<Any>] = [
        Default(key: "lastLaunchID", defaultValue: UUID.null.uuidString, getter: { "" }, setter: {_ in}),
        Default(key: "onboardingPhase", defaultValue: 0, getter: { 0 }, setter: {_ in}),
      ]

      Defaults(defaults: defaults).register()

      let lastLaunchID = Launch.Recorder.lastID
      isFirstLaunch = lastLaunchID.isNull

      Task.detached {
        await self.recordLaunch(after: lastLaunchID)
      }
    }

    func didFinishLaunching() {
      let launchLog =
"""
Date: \(launch.date)
Device: \(launch.deviceID)
"""
      logger.trace("Application launch: \n\(launchLog)")
      logger.trace("Application did finish launching.")
    }
  }
}

#if canImport(AppKit)
import AppKit

extension Application.Delegate: NSApplicationDelegate {
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

extension Application.Delegate: UIApplicationDelegate {
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
