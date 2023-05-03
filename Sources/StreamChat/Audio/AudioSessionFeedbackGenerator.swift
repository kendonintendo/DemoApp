//
// Copyright © 2023 Stream.io Inc. All rights reserved.
//

import Foundation
import UIKit.UIImpactFeedbackGenerator
import UIKit.UISelectionFeedbackGenerator

/// A protocol that defines the required methods for providing haptic feedback for different events in an audio session
protocol AudioSessionFeedbackGenerator {
    /// Initialises an instance of the conforming type
    init()

    /// Provides feedback when playback starts
    func feedbackForPlay()

    /// Provides feedback when playback is paused
    func feedbackForPause()

    /// Provides feedback when playback is stopped
    func feedbackForStop()

    /// Provides feedback when the playback rate changes
    func feedbackForPlaybackRateChange()

    /// Provides feedback when seeking through the audio playback
    func feedbackForSeeking()

    /// Provides feedback when preparing to start a recording
    func feedbackForPreparingRecording()

    /// Provides feedback when starting a recording
    func feedbackForBeginRecording()

    /// Provides feedback when cancelling a recording
    func feedbackForCancelRecording()

    /// Provides feedback when stopping a recording
    func feedbackForStopRecording()

    /// Provides feedback when discarding a recording
    func feedbackForDiscardRecording()
}

/// A class that conforms to the AudioSessionFeedbackGenerator protocol
final class StreamAudioSessionFeedbackGenerator: AudioSessionFeedbackGenerator {
    /// The following properties are instances of feedback generators
    private let lightImpactFeedbackGenerator: UIImpactFeedbackGenerator
    private let mediumImpactFeedbackGenerator: UIImpactFeedbackGenerator
    private let heavyImpactFeedbackGenerator: UIImpactFeedbackGenerator
    private let selectionFeedbackGenerator: UISelectionFeedbackGenerator

    /// A required initialiser for the AudioSessionFeedbackGenerator protocol
    required convenience init() {
        self.init(
            { UIImpactFeedbackGenerator(style: $0) },
            selectionFeedbackGeneratorProvider: { .init() }
        )
    }

    init(
        _ impactFeedbackGeneratorProvider: (UIImpactFeedbackGenerator.FeedbackStyle) -> UIImpactFeedbackGenerator,
        selectionFeedbackGeneratorProvider: () -> UISelectionFeedbackGenerator
    ) {
        lightImpactFeedbackGenerator = impactFeedbackGeneratorProvider(.light)
        mediumImpactFeedbackGenerator = impactFeedbackGeneratorProvider(.medium)
        heavyImpactFeedbackGenerator = impactFeedbackGeneratorProvider(.heavy)
        selectionFeedbackGenerator = selectionFeedbackGeneratorProvider()
    }

    /// Methods that play haptic feedback for different events

    func feedbackForPlay() {
        lightImpactFeedbackGenerator.impactOccurred()
    }

    func feedbackForPause() {
        lightImpactFeedbackGenerator.impactOccurred()
    }

    func feedbackForStop() {
        mediumImpactFeedbackGenerator.impactOccurred()
    }

    func feedbackForPlaybackRateChange() {
        mediumImpactFeedbackGenerator.impactOccurred()
    }

    func feedbackForSeeking() {
        selectionFeedbackGenerator.selectionChanged()
    }

    func feedbackForPreparingRecording() {
        lightImpactFeedbackGenerator.impactOccurred()
    }

    func feedbackForBeginRecording() {
        mediumImpactFeedbackGenerator.impactOccurred()
    }

    func feedbackForCancelRecording() {
        heavyImpactFeedbackGenerator.impactOccurred()
    }

    func feedbackForStopRecording() {
        mediumImpactFeedbackGenerator.impactOccurred()
    }

    func feedbackForDiscardRecording() {
        heavyImpactFeedbackGenerator.impactOccurred()
    }
}
