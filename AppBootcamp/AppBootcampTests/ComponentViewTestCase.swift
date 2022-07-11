//
//  ComponentViewTestCase.swift
//  AppBootcampTests
//
//  Created by Matheus Lenke on 08/07/22.
//

import XCTest
import SnapshotTesting

@testable import AppBootcamp

class ComponentViewTestCase: XCTestCase {

    let sut = ComponentView(frame: .init(origin: .zero, size: .init(width: 300, height: 400)))
    override func setUp()  {
        super.setUp()
        isRecording = false
    }

    func testComponentView() {
        if let message = verifySnapshot(matching: sut, as: .image, record: isRecording) {
            XCTFail(message)
        }
    }

}
