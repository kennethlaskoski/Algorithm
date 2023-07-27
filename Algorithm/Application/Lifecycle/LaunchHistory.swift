//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

struct LaunchRecord: Identifiable, Codable {
  let id: UUID
  let date: Date
  let person: Person?

  init(date: Date = .now, person: Person? = nil) {
    self.id = UUID()
    self.date = date
    self.person = person
  }
}

protocol LaunchHistory {
  associatedtype RecordSequence: Sequence<LaunchRecord>

  var records: RecordSequence { get async }
  mutating func append(_ new: LaunchRecord) async
}

extension LaunchHistory {
  static func += (lhs: inout Self, rhs: LaunchRecord) async {
    await lhs.append(rhs)
  }
}

//func += (_ lhs: LaunchHistory, _ rhs: LaunchRecord) async {
//  await lhs.append(rhs)
//}

actor JSONFileLaunchHistory: LaunchHistory {
  var records: [LaunchRecord] = []

  init() {
    guard let data = storage.data else { return }
    guard let decoded = try? JSONDecoder().decode([LaunchRecord].self, from: data) else { return }
    records = decoded
  }

  func append(_ launch: LaunchRecord) {
    records.append(launch)
    storage.write(records)
  }

  private struct FileStorage {
    var data: Data?

    init() {
      data = try? Data(contentsOf: url, options: Data.ReadingOptions.mappedIfSafe)
    }

    private let url = URL(
      filePath: "launch-history.json",
      directoryHint: .notDirectory,
      relativeTo: .applicationSupportDirectory
    )

    func write(_ launches: [LaunchRecord]) {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(launches) {
        do {
          // Save the 'Data' data file to the Documents directory.
          try encoded.write(to: url)
        } catch {
          print("Couldn't write file - " + error.localizedDescription)
        }
      }
    }
  }

  private let storage = FileStorage()
}
