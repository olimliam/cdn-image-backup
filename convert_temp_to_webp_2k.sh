#!/bin/bash

# temp 폴더 내 모든 이미지를 2k WebP로 변환하여 저장하는 스크립트 (병렬 처리)
# 원본 폴더: temp
# 대상 폴더: temp/webp_2k

SRC_DIR="temp/webp_8k"
DST_DIR="temp/webp_2k"

# 2K 해상도 (QHD)
TARGET_WIDTH=2560
TARGET_HEIGHT=1440

# WebP 품질
WEBP_QUALITY=100

# CPU 코어 수 자동 감지 (macOS)
MAX_JOBS=$(sysctl -n hw.ncpu)

echo "=== temp 폴더 파일을 2k WebP로 변환 시작 (병렬 처리) ==="
echo "🚀 병렬 처리 활성화: ${MAX_JOBS}개 코어 사용"

# ImageMagick 확인
if ! command -v convert &> /dev/null && ! command -v magick &> /dev/null; then
    echo "❌ ImageMagick이 설치되어 있지 않습니다. brew install imagemagick"
    exit 1
fi

# 대상 디렉토리 생성
mkdir -p "$DST_DIR"

# 단일 파일 변환 함수
convert_single_file() {
    local src_file=$1
    local filename=$(basename "$src_file")
    local filename_no_ext="${filename%.*}"
    local dst_file="$DST_DIR/${filename_no_ext}.webp"

    # 변환
    echo "🔄 변환 중: $filename → ${filename_no_ext}.webp"
    
    if command -v magick &> /dev/null; then
        magick "$src_file" -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" -quality "$WEBP_QUALITY" "$dst_file"
    else
        convert "$src_file" -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" -quality "$WEBP_QUALITY" "$dst_file"
    fi

    if [ $? -eq 0 ]; then
        echo "✅ 완료: ${filename_no_ext}.webp"
        return 0
    else
        echo "❌ 실패: $filename"
        return 1
    fi
}

export -f convert_single_file
export DST_DIR TARGET_WIDTH TARGET_HEIGHT WEBP_QUALITY

# find로 모든 이미지 파일을 찾고 병렬로 처리
find "$SRC_DIR" -maxdepth 1 -type f \( -iname "*.webp" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.tif" \) | \
xargs -I {} -P "$MAX_JOBS" bash -c 'convert_single_file "$@"' _ {}

# 변환된 파일 수 계산
converted_count=$(ls -1 "$DST_DIR"/*.webp 2>/dev/null | wc -l)

echo ""
echo "=== 변환 완료 ==="
echo "변환된 파일 수: $converted_count"
echo "목표 해상도: 2560x1440 (2K QHD)"
echo "결과 디렉토리: $DST_DIR"
echo "병렬 처리로 속도 향상!"
echo ""
echo "변환된 파일 목록:"
ls -la "$DST_DIR"/*.webp 2>/dev/null || echo "변환된 파일이 없습니다."
