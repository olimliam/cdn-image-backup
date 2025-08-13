#!/bin/bash

# 8k 폴더 내 모든 이미지를 4k 해상도로 리사이즈하여 동일한 이름으로 새로운 폴더에 저장하는 스크립트
# 원본 폴더: 8k
# 대상 폴더: 4k_resized

SRC_DIR="/Users/shhan/Workspace/backup/cdn-gs-mall/2025_08_10_0010/temp"
DST_DIR="/Users/shhan/Workspace/backup/cdn-gs-mall/2025_08_10_0010/4k/84B/ent"

# 4K 해상도
TARGET_WIDTH=3840
TARGET_HEIGHT=2160

# WebP 품질
WEBP_QUALITY=90

# ImageMagick 확인
if ! command -v convert &> /dev/null && ! command -v magick &> /dev/null; then
    echo "❌ ImageMagick이 설치되어 있지 않습니다. brew install imagemagick"
    exit 1
fi

mkdir -p "$DST_DIR"

# find로 모든 이미지 파일 탐색 (webp, png, jpg, jpeg, bmp, tiff)
find "$SRC_DIR" -type f \( -iname "*.webp" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.tif" \) | while read -r src_file; do
    # 상대 경로 추출
    rel_path="${src_file#$SRC_DIR/}"
    dst_file="$DST_DIR/$rel_path"
    dst_dir="$(dirname "$dst_file")"
    mkdir -p "$dst_dir"

    # 변환
    echo "🔄 $rel_path → $dst_file"
    if command -v magick &> /dev/null; then
        magick "$src_file" -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" -quality "$WEBP_QUALITY" "$dst_file"
    else
        convert "$src_file" -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" -quality "$WEBP_QUALITY" "$dst_file"
    fi

done

echo "✅ 8k → 4k 리사이즈 완료. 결과는 $DST_DIR 에 저장됨."