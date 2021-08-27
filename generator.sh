#!/usr/bin/env bash

set -euo pipefail

HEADER_DIR="./HeaderPractice/placeholders"
HEADER_PREFIX="Placeholder"
COUNT="${1:-1000}"

function generate_placeholder_class() {
    local id="$1"

    cat << EOF > "$HEADER_DIR/$HEADER_PREFIX$id.h"
//
//  Placeholder$id.h
//  HeaderPractice
//
//  Created by WeiHan on 2021/8/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Placeholder$id : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSUInteger value;
@property (nonatomic, assign) BOOL state;

@end

NS_ASSUME_NONNULL_END
EOF

    cat << EOF > "$HEADER_DIR/$HEADER_PREFIX$id.m"
//
//  Placeholder$id.m
//  HeaderPractice
//
//  Created by WeiHan on 2021/8/26.
//

#import "Placeholder$id.h"

@implementation Placeholder$id

@end
EOF
}


mkdir -p "$HEADER_DIR"
# Remove the existing placeholder files.
find "$HEADER_DIR" -type f -name "*.h" -or -name "*.m" | xargs -I@ rm -fr @

for i in `seq $COUNT`
do
    echo -ne "Generating $HEADER_DIR/$HEADER_PREFIX$i.{h,m} \r"
    generate_placeholder_class $i
done

echo -ne '\n'
echo -e "Generated $((COUNT*2)) file(s) under $HEADER_DIR\r"
