# AkashaBusinessCard App

This is the SwiftUI-based business card app for macOS, built with Couchbase Lite for offline-first functionality.

## Features

- Offline-first architecture using Couchbase Lite
- Cross-platform support (macOS, iOS, Web)
- Data synchronization across platforms using Couchbase Sync Gateway

## Building and Running

Use the provided Makefile for common tasks:

- `make build`: Build the app in Debug configuration
- `make run`: Build and run the app
- `make clean`: Clean build artifacts
- `make test`: Run the test suite

The build artifacts are stored in the `.build` directory.