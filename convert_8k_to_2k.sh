#!/bin/bash

# 8k 폴더 내 모든 이미지를 2k 해상도로 리사이즈하여 저장하는 스크립트
# 원본 폴더: 8k
# 대상 폴더: 2k

SRC_DIR="8k"
DST_DIR="2k"

# 2K 해상도 (QHD)
TARGET_WIDTH=2560
TARGET_HEIGHT=1440

# WebP 품질
WEBP_QUALITY=90

echo "=== 8k → 2k 이미지 변환 시작 ==="

# ImageMagick 확인
if ! command -v convert &> /dev/null && ! command -v magick &> /dev/null; then
    echo "❌ ImageMagick이 설치되어 있지 않습니다. brew install imagemagick"
    exit 1
fi

# 대상 디렉토리 생성
mkdir -p "$DST_DIR"

# 변환된 파일 카운터
converted_count=0

echo "=== 설정 정보 ==="
echo "목표 해상도: ${TARGET_WIDTH}x${TARGET_HEIGHT} (2K QHD)"
echo "WebP 품질: ${WEBP_QUALITY}"
echo "소스 디렉토리: $SRC_DIR"
echo "대상 디렉토리: $DST_DIR"
echo ""

# find로 모든 이미지 파일 탐색 (webp, png, jpg, jpeg, bmp, tiff)
find "$SRC_DIR" -type f \( -iname "*.webp" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.tif" \) | while read -r src_file; do
    # 상대 경로 추출
    rel_path="${src_file#$SRC_DIR/}"
    
    # 폴더 구조 유지
    dst_dir="$DST_DIR/$(dirname "$rel_path")"
    
    # 파일명에서 확장자를 .webp로 변경
    filename=$(basename "$rel_path")
    filename_no_ext="${filename%.*}"
    dst_file="$dst_dir/${filename_no_ext}.webp"
    
    # 대상 디렉토리 생성
    mkdir -p "$dst_dir"
    
    # 이미 존재하는 파일인지 확인
    if [ -f "$dst_file" ]; then
        echo "⏭️  건너뜀: $rel_path (이미 존재)"
        continue
    fi

    # 변환
    echo "🔄 변환 중: $rel_path → ${dst_file#$DST_DIR/}"
    
    if command -v magick &> /dev/null; then
        magick "$src_file" -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" -quality "$WEBP_QUALITY" "$dst_file"
    else
        convert "$src_file" -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" -quality "$WEBP_QUALITY" "$dst_file"
    fi

    if [ $? -eq 0 ]; then
        echo "✅ 완료: ${dst_file#$DST_DIR/}"
        ((converted_count++))
    else
        echo "❌ 실패: $rel_path"
    fi

done

echo ""
echo "=== 8k → 2k 변환 완료 ==="
echo "변환된 파일 수: $converted_count"
echo "결과 디렉토리: $DST_DIR"
echo ""

# 결과 파일 개수 확인
total_files=$(find "$DST_DIR" -name "*.webp" | wc -l)
echo "총 2k WebP 파일 개수: $total_files"
