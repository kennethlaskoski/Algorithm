//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import System
import DeviceCheck

extension Device {
  typealias Token = Data

  var supportsCheck: Bool { DCDevice.current.isSupported }
  var token: Token {
    get async throws { try await DCDevice.current.generateToken() }
  }
}

extension Device {
  var supportsAttestation: Bool { DCAppAttestService.shared.isSupported }
}

actor Attester {
  private let service = DCAppAttestService.shared
  private let keyFilename = ".attestation-key-id"
  private lazy var keyURL: URL = {
    URL(
      filePath: keyFilename,
      directoryHint: .notDirectory,
      relativeTo: .applicationSupportDirectory
    )
  }()

  private typealias KeyID = String

  private var keyID: KeyID {
    get async throws {
      guard service.isSupported else { throw DCError(.featureUnsupported) }
      return try KeyID(contentsOf: keyURL)
    }
  }

  private var hasPersistedKeyID: Bool { persistedKeyID != nil }
  private lazy var persistedKeyID: String? = { try? String(contentsOf: keyURL, encoding: .nonLossyASCII) }()

  func generateKey() async {
    if hasPersistedKeyID {
      return
    }

    let generateID = Task {
      guard service.isSupported else { throw DCError(.featureUnsupported) }
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
