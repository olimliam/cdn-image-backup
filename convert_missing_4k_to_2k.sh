#!/bin/bash

echo "=== 4k에서 2k로 누락 파일 변환 시작 ==="
echo ""

# 4k와 2k 디렉토리 설정
SOURCE_DIR="4k"
TARGET_DIR="2k"

# 2K 해상도 설정 (2560x1440)
TARGET_WIDTH=2560
TARGET_HEIGHT=1440

# WebP 품질 설정
WEBP_QUALITY=100

# 변환된 파일 카운터
converted_count=0
error_count=0
skipped_count=0

# CPU 코어 수 확인 (병렬 처리용)
CPU_CORES=$(sysctl -n hw.ncpu)
echo "🚀 병렬 처리 활성화: $CPU_CORES개 코어 사용"

# 누락된 파일 목록 파일 확인
if [ ! -f "4k_missing_in_2k.txt" ]; then
    echo "❌ 누락된 파일 목록이 없습니다. compare_4k_2k_files.sh를 먼저 실행하세요."
    exit 1
fi

# 총 변환할 파일 수
total_files=$(wc -l < 4k_missing_in_2k.txt)
echo "📊 변환할 파일 수: $total_files"
echo "목표 해상도: ${TARGET_WIDTH}x${TARGET_HEIGHT} (2K QHD)"
echo "WebP 품질: ${WEBP_QUALITY}"
echo ""

# 단일 파일 변환 함수
convert_single_file() {
    local relative_path="$1"
    local source_file="$SOURCE_DIR/$relative_path"
    local target_file="$TARGET_DIR/$relative_path"
    
    # 대상 디렉토리 생성
    local target_dir=$(dirname "$target_file")
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
    fi
    
    # 이미 파일이 존재하는지 확인
    if [ -f "$target_file" ]; then
        echo "⏭️  건너뜀: $(basename "$target_file") (이미 존재)"
        return 0
    fi
    
    # 원본 파일 존재 확인
    if [ ! -f "$source_file" ]; then
        echo "❌ 실패: 원본 파일 없음 - $source_file"
        return 1
    fi
    
    echo "🔄 변환 중: $(basename "$target_file")"
    
    # ImageMagick을 사용하여 2K로 변환
    if command -v magick &> /dev/null; then
        # ImageMagick 7.x
        if magick "$source_file" \
            -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" \
            -quality "$WEBP_QUALITY" \
            -define webp:lossless=false \
            -define webp:alpha-quality=100 \
            "$target_file" 2>/dev/null; then
            echo "✅ 완료: $(basename "$target_file")"
            return 0
        else
            echo "❌ 실패: $relative_path"
            return 1
        fi
    else
        # ImageMagick 6.x
        if convert "$source_file" \
            -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" \
            -quality "$WEBP_QUALITY" \
            -define webp:lossless=false \
            -define webp:alpha-quality=100 \
            "$target_file" 2>/dev/null; then
            echo "✅ 완료: $(basename "$target_file")"
            return 0
        else
            echo "❌ 실패: $relative_path"
            return 1
        fi
    fi
}

# 함수를 export하여 xargs에서 사용 가능하게 함
export -f convert_single_file
export SOURCE_DIR TARGET_DIR TARGET_WIDTH TARGET_HEIGHT WEBP_QUALITY

# 병렬 처리로 파일 변환
echo "🔄 병렬 변환 시작..."
echo ""

cat 4k_missing_in_2k.txt | xargs -I {} -P "$CPU_CORES" bash -c 'convert_single_file "$@"' _ {}

echo ""
echo "=== 변환 완료 ==="

# 결과 확인
echo "변환 결과 확인 중..."
success_count=0
while IFS= read -r relative_path; do
    target_file="$TARGET_DIR/$relative_path"
    if [ -f "$target_file" ]; then
        ((success_count++))
    fi
done < 4k_missing_in_2k.txt

echo "📊 총 변환 시도: $total_files"
echo "✅ 성공: $success_count"
echo "❌ 실패: $((total_files - success_count))"

if [ $success_count -eq $total_files ]; then
    echo ""
    echo "🎉 모든 파일이 성공적으로 변환되었습니다!"
    echo "이제 4k와 2k가 완전히 동기화되었습니다."
else
    echo ""
    echo "⚠️  일부 파일 변환에 실패했습니다."
fi

echo ""
echo "🎯 4k→2k 누락 파일 변환 작업이 완료되었습니다!"
