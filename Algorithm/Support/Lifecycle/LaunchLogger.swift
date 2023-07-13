//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

struct Launch: Identifiable, Codable {
  let id: UUID
  let seq: Int
  let date: Date
  let serverDate: Date?
  let person: Person?
}

class LaunchLogger: ObservableObject {
  @Published var launches: [Launch] = []

  var isFirstLaunch: Bool { launches.count == 1 }

  init() {
    // Load the data model from the 'Data' data file found in the Documents directory.
    if let codedData = try? Data(contentsOf: dataURL) {
      let decoder = JSONDecoder()
      if let decoded = try? decoder.decode([Launch].self, from: codedData) {
        launches = decoded
      }
    }

    launches.append(Launch(id: UUID(), seq: launches.count, date: Date(), serverDate: nil, person: nil))
    save()
  }

  // The archived file name, saved to ~/Libray/Application Support folder.
  private let dataFileName = ".launches.json"
  private lazy var dataURL: URL = {
    URL(
      filePath: dataFileName,
      directoryHint: .notDirectory,
      relativeTo: .applicationSupportDirectory
    )
  }()


  func save() {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(launches) {
      do {
        // Save the 'Data' data file to the Documents directory.
        try encoded.write(to: dataURL)
      } catch {
        print("Couldn't write file - " + error.localizedDescription)
      }
    }
  }
}
