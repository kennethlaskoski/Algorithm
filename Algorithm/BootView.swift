//  Copyright © 2023 Kenneth Laskoski. All Rights Reserved.
//  SPDX-License-Identifier: Apache-2.0

import SwiftUI

struct BootView: View {

  @State var fraction = 0.0
  

  var body: some View {
    let state: BootView.Phase = fraction < 1.0 ? .booting(fraction) : .booted
    ZStack() {
      Rectangle()
        .foregroundColor(Color("AccentColor"))
        .mask(state.mask)
        .background(.black)

#if DEBUG
      DebugSlider(fraction: $fraction)
#endif

    }
  }

  enum Phase {
    case booting(Double)
    case booted

    func mask() -> some View {
      var name = "none"
      var opacity = 1.0
      switch self {
      case .booting(let fraction):
        name = "power.dotted"
        opacity = fraction
      case .booted:
        name = "power"
      }
      
      return systemMask(name: name).opacity(opacity)
    }
  }
}

func systemMask(name: String) -> some View {
  Image(systemName: name)
    .font(.system(size: 144.0, weight: .heavy))
    .foregroundColor(
      Color(.white)
    )
    .luminanceToAlpha()
}

struct PowerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BootView()
    }
}

#if DEBUG
struct DebugSlider: View {
  @Binding var fraction: Double
  var body: some View {
    VStack() {
      Spacer()
      HStack() {
        let height = 44.0
        let phy = 1.61803398875
        Slider(value: $fraction)
          .padding(11.0)
          .frame(width: 3.0*phy*height, height: height)
          .border(.red)
        Spacer()
      }
    }
    .padding(13.0)
  }
}
#endif
