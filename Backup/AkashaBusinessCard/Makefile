# Makefile for AkashaBusinessCard macOS App

BUILD_DIR = .build

.PHONY: build run clean test

# Build the app in Debug configuration
build:
	xcodebuild -project AkashaBusinessCard.xcodeproj -scheme AkashaBusinessCard -configuration Debug -destination 'platform=macOS' -derivedDataPath $(BUILD_DIR) build

# Build and run the app
run: build
	open $(BUILD_DIR)/Build/Products/Debug/AkashaBusinessCard.app

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)

# Run tests
test:
	xcodebuild -project AkashaBusinessCard.xcodeproj -scheme AkashaBusinessCard -destination 'platform=macOS' -derivedDataPath $(BUILD_DIR) test