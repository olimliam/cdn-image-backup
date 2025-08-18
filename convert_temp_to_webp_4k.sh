#!/bin/bash

# temp 폴더 내 모든 이미지를 4k WebP로 변환하여 저장하는 스크립트
# 원본 폴더: temp
# 대상 폴더: temp/webp_4k

SRC_DIR="temp"
DST_DIR="temp/webp_4k"

# 4K 해상도
TARGET_WIDTH=3840
TARGET_HEIGHT=2160

# WebP 품질
WEBP_QUALITY=90

echo "=== temp 폴더 파일을 4k WebP로 변환 시작 ==="

# ImageMagick 확인
if ! command -v convert &> /dev/null && ! command -v magick &> /dev/null; then
    echo "❌ ImageMagick이 설치되어 있지 않습니다. brew install imagemagick"
    exit 1
fi

# 대상 디렉토리 생성
mkdir -p "$DST_DIR"

# 변환된 파일 카운터
converted_count=0

# find로 모든 이미지 파일 탐색 (webp, png, jpg, jpeg, bmp, tiff)
find "$SRC_DIR" -maxdepth 1 -type f \( -iname "*.webp" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.tif" \) | while read -r src_file; do
    # 파일명만 추출 (경로 제거)
    filename=$(basename "$src_file")
    # 확장자를 .webp로 변경
    filename_no_ext="${filename%.*}"
    dst_file="$DST_DIR/${filename_no_ext}.webp"

    # 변환
    echo "🔄 변환 중: $filename → ${filename_no_ext}.webp"
    
    if command -v magick &> /dev/null; then
        magick "$src_file" -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" -quality "$WEBP_QUALITY" "$dst_file"
    else
        convert "$src_file" -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" -quality "$WEBP_QUALITY" "$dst_file"
    fi

    if [ $? -eq 0 ]; then
        echo "✅ 완료: ${filename_no_ext}.webp"
        ((converted_count++))
    else
        echo "❌ 실패: $filename"
    fi

done

echo ""
echo "=== 변환 완료 ==="
echo "변환된 파일 수: $converted_count"
echo "결과 디렉토리: $DST_DIR"
echo "변환된 파일 목록:"
ls -la "$DST_DIR"/*.webp 2>/dev/null || echo "변환된 파일이 없습니다."
