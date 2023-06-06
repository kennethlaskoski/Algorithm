//  Copyright © 2023 Kenneth Laskoski
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct BootView: View {
  @State var fraction = 0.0 //+ 1.0 //- 0.5

  var body: some View {
    let phase = Phase(fraction)

    ZStack() {
      Rectangle()
	.foregroundColor(Color("AccentColor"))
	.mask(phase.button)
        .onTapGesture { fraction = 1.0 - fraction }

#if DEBUG
      DebugSlider(fraction: $fraction)
#endif

    }
  }

  enum Phase {
    case booting(Double)
    case booted

    init(_ fraction: Double) {
      self = fraction < 1.0 ? .booting(fraction) : .booted
    }

    func button() -> some View {
      var name = "none"
      var opacity = 0.0

      switch self {
      case .booting(let fraction):
	name = "power.dotted"
	opacity = fraction
      case .booted:
	name = "power"
	opacity = 1.0
      }

      return Image(systemName: name).mask()
	.font(.system(size: 144.0, weight: .heavy))
	.opacity(opacity)
    }
  }
}

extension View {
  func mask() -> some View {
    self.foregroundColor(.white).luminanceToAlpha()
  }
}

struct BootView_Previews: PreviewProvider {
  static var previews: some View {
    BootView()
  }
}

#if DEBUG
struct DebugSlider: View {
  @Binding var fraction: Double

  var body: some View {
    VStack {
      Spacer()

      HStack {
	let height = 44.0
	let phy = 1.61803398875

	Slider(value: $fraction)
	  .padding()
	  .frame(width: 3.0*phy*height, height: height)
	  .border(.red)

	Spacer()
      }
    }
    .padding(13.0)
  }
}
#endif
