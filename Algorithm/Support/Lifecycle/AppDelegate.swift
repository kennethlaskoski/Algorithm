//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

#if os(macOS)
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {

}
#endif

#if !os(macOS)
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {

}
#endif
