//
//  URL+ParamsTest.swift
//  pilotTests
//
//  Created by Rohan Nagar on 10/14/17.
//  Copyright © 2017 sanction. All rights reserved.
//

import Foundation
import Nimble
@testable import pilot
import Quick

class URL_ParamsTest: QuickSpec {
  override func spec() {
    describe("URL+Params") {

      /* getQueryParam() Tests */
      describe("getQueryParam") {
        it("returns nil if not found") {
          let url = URL(string: "http://www.example.com")

          expect(url!.getQueryParam(key: "test")).to(beNil())
        }

        it("finds the correct value") {
          let url = URL(string: "http://www.example.com?test=samplevalue")

          expect(url!.getQueryParam(key: "test")) == "samplevalue"
        }
      }

      /* getFragementParam() Tests */
      describe("getFragementParam") {
        it("returns nil if no fragements") {
          let url = URL(string: "http://www.example.com")

          expect(url!.getFragementParam(key: "test")).to(beNil())
        }

        it("returns nil if no matching fragements") {
          let url = URL(string: "http://www.example.com#wrong=samplevalue")

          expect(url!.getFragementParam(key: "test")).to(beNil())
        }

        it("finds the correct value") {
          let url = URL(string: "http://www.example.com#test=samplevalue")

          expect(url!.getFragementParam(key: "test")) == "samplevalue"
        }
      }

    }
  }
}
