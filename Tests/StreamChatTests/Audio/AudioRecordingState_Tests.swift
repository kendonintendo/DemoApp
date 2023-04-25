//
// Copyright © 2023 Stream.io Inc. All rights reserved.
//

import Foundation
import StreamChat
import XCTest

final class AudioRecordingState_Tests: XCTestCase {
    // MARK: - rawValue

    func test_rawValue_eachStateHasItsExpectedRawValue() {
        XCTAssertEqual(AudioRecordingState.recording.rawValue, "recording")
        XCTAssertEqual(AudioRecordingState.paused.rawValue, "paused")
        XCTAssertEqual(AudioRecordingState.stopped.rawValue, "stopped")
    }
}
