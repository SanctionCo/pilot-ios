//
//  UIColor+PilotColorsTest.swift
//  pilotTests
//
//  Created by Rohan Nagar on 10/14/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import Nimble
@testable import pilot
import Quick

class UIColor_PilotColorsTest: QuickSpec {
  override func spec() {
    describe("PilotColors") {

      /* fromRGB Tests */
      describe("fromRGB") {
        it("matches basic colors") {
          expect(UIColor.fromRGB(red: 255, green: 0, blue: 0)) == UIColor.red
          expect(UIColor.fromRGB(red: 0, green: 255, blue: 0)) == UIColor.green
          expect(UIColor.fromRGB(red: 0, green: 0, blue: 255)) == UIColor.blue
        }
      }
    }
  }
}
