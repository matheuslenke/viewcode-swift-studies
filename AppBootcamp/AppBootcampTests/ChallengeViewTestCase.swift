//
//  ChallengeTests.swift
//  AppBootcampTests
//
//  Created by Matheus Lenke on 11/07/22.
//

import XCTest
import SnapshotTesting
@testable import AppBootcamp

class ChallengeViewTestCase: XCTestCase {
    
    let sut = ChallengeView(frame: CGRect(origin: .zero, size: CGSize(width: 414, height: 736)))

    override func setUp() {
        super.setUp()
        isRecording = false
    }

    override func tearDown()  {
        super.tearDown()
    }

    func testChallengeView() throws {
        if let message = verifySnapshot(matching: sut, as: .image, record: isRecording) {
            XCTFail(message)
        }
    }

}
