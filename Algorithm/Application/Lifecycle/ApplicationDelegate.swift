//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation
import os

class ApplicationDelegate: NSObject, ObservableObject {
  var launchHistory: [ApplicationLaunch] = []
  var isFirstLaunch: Bool { launchHistory.count == 1 }

  private let logger = Logger(OSLog(subsystem: "br.net.ken.algorithm.lifecycle", category: .pointsOfInterest))

  func willFinishLaunching() {
    logger.trace("Application will finish launching")
    UserDefaults.standard.register(defaults: [
      "LaunchesCount": 0,
      "OnboardingPhase": 0,
    ])
  }

  func didFinishLaunching() {
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

private extension ApplicationLaunch {
  private struct LaunchesFile {
    var data: Data?

    init() {
      data = try? Data(contentsOf: url, options: Data.ReadingOptions.mappedIfSafe)
    }

    private let url = URL(
      filePath: ".launches.json",
      directoryHint: .notDirectory,
      relativeTo: .applicationSupportDirectory
    )
  }

  static let fileData = LaunchesFile().data
}

private extension ApplicationDelegate {
  func loadPreviousLaunches() {
    guard let data = ApplicationLaunch.fileData else { return }
    let decoder = JSONDecoder()
    if let decoded = try? decoder.decode([ApplicationLaunch].self, from: data) {
      launchHistory = decoded
    }
  }
}

extension ApplicationDelegate {
  func appendLaunch() {
    launchHistory.append(ApplicationLaunch(id: UUID(), seq: launchHistory.count, date: Date(), serverDate: nil, person: nil))
//      save()
  }
}
