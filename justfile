
PROJECT_NAME := "HeaderPractice"

default:
    @echo "A few scripts work for header practice."
    @just --choose

generate-files count="1000":
    @bash generator.sh {{count}}

generate-files-project:
    @just reset-existing-project-changes
    @just add-files-to-project

reset-existing-project-changes:
    git checkout -- {{PROJECT_NAME}}.xcodeproj/project.pbxproj

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
        {{clean}} build 2>&1 | xcpretty

    ENDTIME=$(date +%s)
    echo "Elapsed time: $(($ENDTIME - $STARTTIME)) second(s)."

update-prefix-header:
    @touch {{PROJECT_NAME}}/PrefixHeader.pch

rebuild-with-new-prefix:
    @just update-prefix-header
    @just build
