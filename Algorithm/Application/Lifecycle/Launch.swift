//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation
import os

struct Launch: Sendable, Codable {
  let date: Date
  var person: Person
  var device: Device

  init(at date: Date = .now, by person: Person = .placeholder, on device: Device = .unknown) {
    self.date = date
    self.person = person
    self.device = device
  }
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

private extension Launch.Recorder {
  private actor JSONFile {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let url = URL(
      filePath: "launch-history.json",
      directoryHint: .notDirectory,
      relativeTo: .applicationSupportDirectory
    )

    var history = Launch.History()

    init() {
      guard let data = try? Data(contentsOf: url) else {
        // TODO: log failure
        return
      }
      guard let decoded = try? decoder.decode(Launch.History.self, from: data) else {
        // TODO: log failure
        return
      }

      history = decoded
    }

    func record(_ newRecord: Launch.History.Element) {
      history.append(newRecord)

      guard let encoded = try? encoder.encode(history) else {
        // TODO: log failure
        return
      }

      do {
        try encoded.write(to: url)
      } catch {
        // TODO: implement retry (exponential backoff?)
        // TODO: log failure
        print("Couldn't write file - " + error.localizedDescription)
      }
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
