//
//  HorizontalCardViewTestCase.swift
//  AppBootcampTests
//
//  Created by Matheus Lenke on 11/07/22.
//

import XCTest
import SnapshotTesting
@testable import AppBootcamp

class HorizontalCardViewTestCase: XCTestCase {
    
    let sut = HorizontalCardView(frame: .zero)

    override func setUp()  {
        super.setUp()
        isRecording = false
    }

    override func tearDown()  {
        super.tearDown()
    }
    
    func testHorizontalCardView() throws {
        let vc = MockViewController()
        
        vc.configureMockView(mockView: sut)
        
        if let message = verifySnapshot(matching: vc, as: .image(on: .iPhone12), record: isRecording) {
            XCTFail(message)
        }
    }
}
