//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation
import os

extension UUID {
  static let null = UUID(uuid: UUID_NULL)
  var isNull: Bool { self == .null }
}

extension Launch {
  struct Record: Sendable, Identifiable, Codable {
    var id: UUID
    var lastID: UUID
    var launch: Launch

    init(_ launch: Launch, after lastID: UUID) {
      self.id = UUID()
      self.lastID = lastID
      self.launch = launch
    }
  }

  typealias History = [Launch.Record]
}

extension Launch {
  actor Recorder {
    private static let logger = Logger(OSLog(subsystem: "br.net.ken.algorithm", category: "Launch.Recorder"))

    private let storage = JSONFile()

    var history: History {
      get async { await storage.history }
    }

    func record(_ launch: Launch, after lastID: UUID) async {
      let newRecord = Launch.Record(launch, after: lastID)
      await storage.record(newRecord)
      Recorder.lastID = newRecord.id
    }
  }
}

extension Launch.Recorder {
  private static let defaultKey = "lastLaunchID"
  private static let defaultValue = UUID.null

  static private(set) var lastID: UUID {
    get {
      let lastLaunchIDString = defaultID.value

      // parse last launch ID string from user defaults
      guard let lastLaunchID = UUID(uuidString: lastLaunchIDString) else {
        logger.critical("Application will crash - error parsing last launch ID string from user defaults")
        fatalError("Failure parsing user defaults")
      }
      logger.trace("Last launch ID: \(lastLaunchID)")

      return lastLaunchID
    }

    set {
      defaultID.set(newValue: newValue.uuidString)
    }
  }

  private static let defaultID = Default(
    key: defaultKey,
    defaultValue: defaultValue.uuidString,

    getter: {
      logger.trace("Retrieving last launch ID from user defaults...")

      // retrieve last launch ID string from user defaults
      guard let lastLaunchIDString = UserDefaults.standard.string(forKey: defaultKey) else {
        logger.critical("Application will crash - error retrieving last launch ID string from user defaults.")
        fatalError("Failure reading user defaults")
      }
      logger.trace(#"User defaults string for key "\#(defaultKey)": "\#(lastLaunchIDString)""#)

      return lastLaunchIDString
    },

    setter: { newValue in
      logger.trace("Writing launch ID \(newValue) to user defaults")
      UserDefaults.standard.set(newValue, forKey: defaultKey)
    }
  )
}
