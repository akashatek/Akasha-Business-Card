# Makefile for Akasha Business Card App

PROJECT_NAME = AkashaBusinessCard
XCODEBUILD = xcodebuild
DESTINATION = platform=macOS,name=My Mac

.PHONY: build run clean ios-build

build:
	@echo "Building $(PROJECT_NAME) for macOS..."
	$(XCODEBUILD) -project $(PROJECT_NAME)/$(PROJECT_NAME).xcodeproj \
		-scheme $(PROJECT_NAME) \
		-configuration Debug \
		-destination '$(DESTINATION)' \
		build

ios-build:
	@echo "Building $(PROJECT_NAME) for iOS..."
	$(XCODEBUILD) -project $(PROJECT_NAME)/$(PROJECT_NAME).xcodeproj \
		-scheme $(PROJECT_NAME) \
		-configuration Debug \
		-destination 'generic/platform=iOS Simulator' \
		build

run: build
	@echo "Running $(PROJECT_NAME)..."
	@PRODUCT_NAME="$(PROJECT_NAME)"; \
	DATA_PATH=$$(find ~/Library/Developer/Xcode/DerivedData -name "$$PRODUCT_NAME-*" -type d 2>/dev/null | head -1); \
	if [ -n "$$DATA_PATH" ]; then \
		APP_PATH="$$DATA_PATH/Build/Products/Debug/$$PRODUCT_NAME.app"; \
		if [ -d "$$APP_PATH" ]; then \
			open "$$APP_PATH"; \
			echo "Opened $$APP_PATH"; \
		else \
			echo "App not found at $$APP_PATH"; \
			echo "Build completed. Open Xcode and run manually."; \
		fi \
	else \
		echo "Build completed. Open Xcode and run manually."; \
	fi

clean:
	@echo "Cleaning build artifacts..."
	$(XCODEBUILD) clean -project $(PROJECT_NAME)/$(PROJECT_NAME).xcodeproj \
		-scheme $(PROJECT_NAME) \
		-configuration Debug
	@echo "Done!"
