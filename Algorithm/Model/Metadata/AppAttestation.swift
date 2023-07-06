//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import DeviceCheck

fileprivate let device = DCDevice.current

/// The device checker actor
actor Checker {
  /// True if the current device
  /// supports being checked
  let canCheck = device.isSupported
  private var token: Data?

  init() async {
    if AppData().isFirstRun && canCheck {
      token = try? await device.generateToken()
    }
  }
}

fileprivate let keyFilename = "appdata.json"
fileprivate let keyURL: URL = {
  let urls = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
  precondition(urls.count > 0, "Failed to access Application Support directory")
  return urls[0].appendingPathComponent(keyFilename)
}()

fileprivate let service = DCAppAttestService.shared

// The app atterster actor
actor Attester {
  var canAttest: Bool { service.isSupported }
  private var persistedKeyID: String? { try? String(contentsOf: keyURL, encoding: .nonLossyASCII) }
  private var hasPersistedKeyID: Bool { persistedKeyID != nil }

  func generateKey() async {
    if persistedKeyID == nil {
      let generateID = Task {
        guard canAttest else { throw DCError(.featureUnsupported) }
        return try await service.generateKey()
      }

      guard let transient = try? await generateID.value else { return }

      // TODO: set timeout to cancel task
    /*  var persistKeyID = */ Task {
        var throttle = Duration.milliseconds(1)
        var isPersisted = false
        repeat {
          do {
            try transient.data(using: .nonLossyASCII)?.write(to: keyURL)
            isPersisted = true
          } catch {
            try? await Task.sleep(for: throttle)
            throttle *= 2
          }
        } while(!isPersisted)
      }
    }
  }
}
