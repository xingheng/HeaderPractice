
PROJECT_NAME := "HeaderPractice"

default:
    @echo "A few scripts work for header practice."
    @just --choose

generate-files count="1000":
    @bash generator.sh {{count}}

generate-files-project:
    just reset-existing-project-changes
    just add-files-to-project

reset-existing-project-changes:
    git checkout -- {{PROJECT_NAME}}/project.pbxproj

add-files-to-project:
    @ruby ./generator.rb

build clean="":
    #!/usr/bin/env bash
    set -euo pipefail

    STARTTIME=$(date +%s)

    xcodebuild -project {{PROJECT_NAME}}.xcodeproj \
        -scheme {{PROJECT_NAME}} \
        -arch x86_64 \
        -configuration Debug \
        {{clean}} build | xcpretty

    ENDTIME=$(date +%s)
    echo "Elapsed time: $(($ENDTIME - $STARTTIME)) second(s)."
