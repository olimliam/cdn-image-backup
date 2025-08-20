#!/bin/bash

# 4k 폴더의 모든 파일을 2k로 변환하는 스크립트 (병렬 처리)
# 원본 폴더: 4k
# 대상 폴더: 2k

SRC_DIR="4k"
DST_DIR="2k"

# 2K 해상도 (QHD)
TARGET_WIDTH=2560
TARGET_HEIGHT=1440

# WebP 품질
WEBP_QUALITY=100

# CPU 코어 수 자동 감지 (macOS)
MAX_JOBS=$(sysctl -n hw.ncpu)

echo "=== 4k → 2k 이미지 변환 시작 (병렬 처리) ==="
echo "🚀 병렬 처리 활성화: ${MAX_JOBS}개 코어 사용"

# ImageMagick 확인
if ! command -v convert &> /dev/null && ! command -v magick &> /dev/null; then
    echo "❌ ImageMagick이 설치되어 있지 않습니다. brew install imagemagick"
    exit 1
fi

# 대상 디렉토리 생성
mkdir -p "$DST_DIR"

echo "=== 설정 정보 ==="
echo "목표 해상도: ${TARGET_WIDTH}x${TARGET_HEIGHT} (2K QHD)"
echo "WebP 품질: ${WEBP_QUALITY}"
echo "소스 디렉토리: $SRC_DIR"
echo "대상 디렉토리: $DST_DIR"
echo "병렬 처리: ${MAX_JOBS}개 코어"
echo ""

# 단일 파일 변환 함수
convert_single_file() {
    local src_file=$1
    local rel_path="${src_file#$SRC_DIR/}"
    local dst_file="$DST_DIR/$rel_path"
    local dst_dir="$(dirname "$dst_file")"
    
    # 대상 디렉토리 생성
    mkdir -p "$dst_dir"
    
    # 파일이 이미 존재하는지 확인
    if [ -f "$dst_file" ]; then
        echo "⏭️  건너뜀: $rel_path (이미 존재)"
        return 0
    fi
    
    # 변환
    echo "🔄 변환 중: $rel_path"
    
    if command -v magick &> /dev/null; then
        magick "$src_file" -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" -quality "$WEBP_QUALITY" "$dst_file" 2>/dev/null
    else
        convert "$src_file" -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" -quality "$WEBP_QUALITY" "$dst_file" 2>/dev/null
    fi
    
    if [ $? -eq 0 ]; then
        echo "✅ 완료: $rel_path"
        return 0
    else
        echo "❌ 실패: $rel_path"
        return 1
    fi
}

export -f convert_single_file
export SRC_DIR DST_DIR TARGET_WIDTH TARGET_HEIGHT WEBP_QUALITY

# 시작 시간 기록
start_time=$(date +%s)

# find로 모든 WebP 파일을 찾고 병렬로 처리
echo "🔍 4k 폴더에서 WebP 파일 검색 중..."
file_count=$(find "$SRC_DIR" -type f -name "*.webp" | wc -l)
echo "📁 변환할 파일 수: $file_count개"
echo ""

find "$SRC_DIR" -type f -name "*.webp" | \
xargs -I {} -P "$MAX_JOBS" bash -c 'convert_single_file "$@"' _ {}

# 종료 시간 및 통계
end_time=$(date +%s)
duration=$((end_time - start_time))

echo ""
echo "=== 변환 완료 ==="
echo "⏱️  소요 시간: ${duration}초"

# 최종 파일 수 확인
total_4k=$(find "$SRC_DIR" -name "*.webp" | wc -l)
total_2k=$(find "$DST_DIR" -name "*.webp" | wc -l)

echo "📊 변환 결과:"
echo "   - 4k 원본: $total_4k개"
echo "   - 2k 변환: $total_2k개"

if [ $total_4k -eq $total_2k ]; then
    echo "🎉 모든 파일이 성공적으로 변환되었습니다!"
    echo "📂 결과 위치: $DST_DIR"
else
    echo "⚠️  일부 파일 변환에 문제가 있을 수 있습니다."
    echo "   예상: $total_4k개, 실제: $total_2k개"
fi

echo ""
echo "✅ 4k → 2k 변환 작업이 완료되었습니다!"
