#!/bin/bash
# IT"S NOT TESTED!!!
set -e
set -o pipefail

# Set variables
COMPILER=javac
EXEC=java

SRC_PATH="src/main/java"
LIBS_DIR="libs"

OUTPUT_PATH="out"
SAMPLE_OUT="out_samples"

PREPROC_PATH="libs/lombok-1.18.38.jar"

CP=""

# Create output directories if not exist
mkdir -p "$OUTPUT_PATH"
mkdir -p "$SAMPLE_OUT"

# Build classpath with all jar files in libs
for jar in "$LIBS_DIR"/*.jar; do
    CP="$CP:$jar"
done

echo "classPath: $CP"

# Collect .java files into input lists
find src/ -name "*.java" > inputs.txt
find samples/ -name "*.java" > inputs_sample.txt

# COMPILATION CloudSimPlus
echo "COMPILE: CloudSimPlus Started!"
$COMPILER -Xlint:none -cp "$CP:$OUTPUT_PATH" -d "$OUTPUT_PATH" --processor-path "$PREPROC_PATH" @"inputs.txt"

if [ $? -ne 0 ]; then
    echo "Compilation: CloudSimPlus Failed!"
    exit 1
fi
echo "COMPILE: CloudSimPlus Completed!"

# COMPILATION CloudSimPlus-Examples
echo "COMPILE: CloudSimPlus-Examples Started!"
$COMPILER -cp "$CP:$OUTPUT_PATH" -d "$SAMPLE_OUT" @"inputs_sample.txt"

if [ $? -ne 0 ]; then
    echo "Compilation: CloudSimPlus-Examples Failed!"
    exit 1
fi
echo "COMPILE: CloudSimPlus-Examples Completed!"

# RUN BasicFirstExample (FQCN)
echo "RUN_SIMULATION: org.cloudsimplus.examples.BasicFirstExample"
$EXEC -cp "$CP:$OUTPUT_PATH:$SAMPLE_OUT" org.cloudsimplus.examples.BasicFirstExample

