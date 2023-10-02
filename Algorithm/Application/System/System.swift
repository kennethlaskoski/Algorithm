//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import Observation

@Observable
final class System {
  let buildTimeOS = OperatingSystem.atBuildTime
}
