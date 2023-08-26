#!/bin/bash

directory_path="src"
java_files=""

for file in "$directory_path"/*.java; do
    if [[ -f "$file" && "$(basename "$file")" != "TestClass.java" ]]; then
        java_files+="$directory_path/$(basename "$file") "
    fi
done

java_files="${java_files% }"  # Remove trailing space
echo "Java files: $java_files"

mkdir out
javac -d out $java_files
javac -d out -cp deps/junit-platform-console-standalone-1.9.3.jar $java_files src/TestClass.java
java -jar deps/junit-platform-console-standalone-1.9.3.jar --class-path out --scan-class-path