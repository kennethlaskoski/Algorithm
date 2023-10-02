//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Foundation
import os

extension Launch.Recorder {
  actor JSONFile {
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
