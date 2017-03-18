
PROJECT_NAME="UserInterfaceKit"
UNIVERSAL_DIR="$PROJECT_NAME-Release-tvuniversal"
ARTIFACTS_DIR="workspace/artifacts"
OUTPUT_DIR="$WORKSPACE/Output"

FRAMEWORK_ARTIFACT_DIR="$JENKINS_HOME/$ARTIFACTS_DIR/$PROJECT_NAME/$UNIVERSAL_DIR"

if [ -d $FRAMEWORK_ARTIFACT_DIR ]; then

    rm -rf $FRAMEWORK_ARTIFACT_DIR

fi

mkdir $FRAMEWORK_ARTIFACT_DIR

cp -R "$OUTPUT_DIR/$UNIVERSAL_DIR/$PROJECT_NAME.framework" $FRAMEWORK_ARTIFACT_DIR
