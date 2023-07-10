//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation

struct Launch: Identifiable, Codable {
  let id: UUID
  let date: Date
}

class AppData: ObservableObject {
  @Published var launches: [Launch] = []

  var isFirstLaunch: Bool { launches.count == 1 }

  init() {
    // Load the data model from the 'Data' data file found in the Documents directory.
    if let codedData = try? Data(contentsOf: dataURL()) {
      let decoder = JSONDecoder()
      if let decoded = try? decoder.decode([Launch].self, from: codedData) {
        launches = decoded
      }
    }

    launches.append(Launch(id: UUID(), date: Date()))
    save()
  }

  // The archived file name, saved to Documents folder.
  private let dataFileName = "appdata.json"

  private func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
  }

  private func dataURL() -> URL {
    let docURL = documentsDirectory()
    return docURL.appendingPathComponent(dataFileName)
  }

  func save() {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(launches) {
      do {
        // Save the 'Data' data file to the Documents directory.
        try encoded.write(to: dataURL())
      } catch {
        print("Couldn't write file - " + error.localizedDescription)
      }
    }
  }
}
