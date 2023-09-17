//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation
import os

extension UUID {
  static let null = UUID(uuid: UUID_NULL)
  var isNull: Bool { self == .null }
}

class ApplicationDelegate: NSObject, ObservableObject {
  private let logger = Logger(OSLog(subsystem: "br.net.ken.algorithm", category: .pointsOfInterest))

  private let launch = Launch()
  private func recordLaunch(after lastID: UUID) async {
    let tracker = Launch.Tracker()
    Defaults.lastLaunchID = await tracker.record(launch, after: lastID)
    launchHistory = await tracker.history
  }

  @Published var launchHistory: Launch.History = []
  @Published var isFirstLaunch = true

  func willFinishLaunching() {
    logger.trace("Application will finish launching")

    registerDefaults()

    let lastLaunchID = Defaults.lastLaunchID
    isFirstLaunch = lastLaunchID.isNull

    Task.detached {
      await self.recordLaunch(after: lastLaunchID)
    }
  }

  func didFinishLaunching() {
    logger.trace("Application did finish launching")
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
