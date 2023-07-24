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

//class LaunchLogger: ObservableObject {
//  @Published var launches: [Launch] = []
//
//  var isFirstLaunch: Bool { launches.count == 1 }
//
//
//
//
//  func save() {
//    let encoder = JSONEncoder()
//    if let encoded = try? encoder.encode(launches) {
//      do {
//        // Save the 'Data' data file to the Documents directory.
//        try encoded.write(to: dataURL)
//      } catch {
//        print("Couldn't write file - " + error.localizedDescription)
//      }
//    }
//  }
//}
