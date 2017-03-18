
DEPENDENCY_NAME="FoundationKit"
UNIVERSAL_DIR="$DEPENDENCY_NAME-Release-watchuniversal"
ARTIFACTS_DIR="workspace/artifacts"
PLATFORM_DIR="$WORKSPACE/Sources/Vendor/watchOS"

DEPENDENCY_ARTIFACT_DIR="$JENKINS_HOME/$ARTIFACTS_DIR/$DEPENDENCY_NAME/$UNIVERSAL_DIR"

if [ -d "$DEPENDENCY_ARTIFACT_DIR/$DEPENDENCY_NAME.framework" ]; then

    rm -rf "$PLATFORM_DIR/Sketch/$DEPENDENCY_NAME.framework"

    cp -R "$DEPENDENCY_ARTIFACT_DIR/$DEPENDENCY_NAME.framework" "$PLATFORM_DIR/Sketch"

fi
