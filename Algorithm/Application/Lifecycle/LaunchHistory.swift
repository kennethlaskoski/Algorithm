//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

struct ApplicationLaunch: Identifiable, Codable {
  let id: UUID
  let seq: Int
  let date: Date
  let serverDate: Date?
  let person: Person?
}

actor LaunchHistory {
  var launches: [ApplicationLaunch] = []
  var count: Int { launches.count }

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

    func write(_ launches: [ApplicationLaunch]) {
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

  private var file = LaunchesFile()

  init() {
    guard let data = file.data else { return }
    guard let decoded = try? JSONDecoder().decode([ApplicationLaunch].self, from: data) else { return }
    launches = decoded
  }

  func append(_ launch: ApplicationLaunch) {
    launches.append(launch)
    file.write(launches)
  }
}
//class LaunchLogger: ObservableObject {
//  @Published var launches: [Launch] = []
//
//  var isFirstLaunch: Bool { launches.count == 1 }
//
//
//
//
//  func save() {
//  }
//}
