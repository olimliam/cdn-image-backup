#!/bin/bash

# temp 폴더의 모든 파일을 8k로 변환하는 스크립트 (병렬 처리)
# 원본 폴더: temp
# 대상 폴더: temp/webp_8k

SRC_DIR="temp"
DST_DIR="temp/webp_8k"

# 8K 해상도
TARGET_WIDTH=7680
TARGET_HEIGHT=4320

# WebP 품질 (최고 품질)
WEBP_QUALITY=100

# CPU 코어 수 자동 감지 (macOS)
MAX_JOBS=$(sysctl -n hw.ncpu)

echo "=== temp 폴더 파일을 8k WebP로 변환 시작 (병렬 처리) ==="
echo "🚀 병렬 처리 활성화: ${MAX_JOBS}개 코어 사용"

# ImageMagick 확인
if ! command -v convert &> /dev/null && ! command -v magick &> /dev/null; then
    echo "❌ ImageMagick이 설치되어 있지 않습니다. brew install imagemagick"
    exit 1
fi

# 대상 디렉토리 생성
mkdir -p "$DST_DIR"

echo "=== 설정 정보 ==="
echo "목표 해상도: ${TARGET_WIDTH}x${TARGET_HEIGHT} (8K UHD)"
echo "WebP 품질: ${WEBP_QUALITY}% (최고 품질)"
echo "소스 디렉토리: $SRC_DIR"
echo "대상 디렉토리: $DST_DIR"
echo "병렬 처리: ${MAX_JOBS}개 코어"
echo ""

# 단일 파일 변환 함수
convert_single_file() {
    local src_file=$1
    local filename=$(basename "$src_file")
    local filename_no_ext="${filename%.*}"
    local dst_file="$DST_DIR/${filename_no_ext}.webp"

    # 파일이 이미 존재하는지 확인
    if [ -f "$dst_file" ]; then
        echo "⏭️  건너뜀: $filename (이미 존재)"
        return 0
    fi

    # 변환
    echo "🔄 변환 중: $filename → ${filename_no_ext}.webp (8K)"
    
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

# 시작 시간 기록
start_time=$(date +%s)

# find로 모든 이미지 파일을 찾고 병렬로 처리 (webp_8k 폴더 제외)
find "$SRC_DIR" -maxdepth 1 -type f \( -iname "*.webp" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.tif" \) | \
xargs -I {} -P "$MAX_JOBS" bash -c 'convert_single_file "$@"' _ {}

# 종료 시간 및 통계
end_time=$(date +%s)
duration=$((end_time - start_time))

echo ""
echo "=== 변환 완료 ==="
echo "⏱️  소요 시간: ${duration}초"

# 최종 파일 수 확인
total_src=$(find "$SRC_DIR" -maxdepth 1 -type f \( -iname "*.webp" -o -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.tif" \) | wc -l)
total_dst=$(find "$DST_DIR" -name "*.webp" | wc -l)

echo "📊 변환 결과:"
echo "   - 원본 파일: $total_src개"
echo "   - 8k 변환: $total_dst개"

if [ $total_src -eq $total_dst ]; then
    echo "🎉 모든 파일이 성공적으로 8k로 변환되었습니다!"
else
    echo "⚠️  일부 파일 변환에 문제가 있을 수 있습니다."
fi

echo ""
echo "✅ temp → 8k WebP 변환 작업이 완료되었습니다!"
