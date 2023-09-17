//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

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
  actor Tracker {
    private let storage = JSONFile()
    var history: History {
      get async { await storage.history }
    }

    func record(_ launch: Launch, after lastID: UUID) async -> UUID {
      let newRecord = Launch.Record(launch, after: lastID)
      await storage.record(newRecord)
      return newRecord.id
    }
  }
}

private extension Launch.Tracker {
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
