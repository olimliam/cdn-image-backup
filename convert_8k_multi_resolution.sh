#!/bin/bash

# 8k 폴더 내 모든 이미지를 4k, 2k 해상도로 리사이즈하여 저장하는 스크립트
# 원본 폴더: 8k
# 대상 폴더: 4k, 2k
# 처리 대상: 84A, 84B, 84C 모든 폴더

SRC_DIR="8k"

# 4K 해상도 (UHD)
TARGET_4K_WIDTH=3840
TARGET_4K_HEIGHT=2160

# 2K 해상도 (QHD)
TARGET_2K_WIDTH=2560
TARGET_2K_HEIGHT=1440

# 품질은 원본과 동일하게 유지 (WebP 기본 품질 사용)
WEBP_QUALITY=100

echo "=== 8k → 4k, 2k 다중 해상도 변환 시작 ==="

# ImageMagick 확인
if ! command -v convert &> /dev/null && ! command -v magick &> /dev/null; then
    echo "❌ ImageMagick이 설치되어 있지 않습니다. brew install imagemagick"
    exit 1
fi

# CPU 코어 수 자동 감지 (macOS)
MAX_JOBS=$(sysctl -n hw.ncpu)
echo "🚀 병렬 처리 활성화: ${MAX_JOBS}개 코어 사용"

# 병렬 변환 함수
convert_to_resolution() {
    local target_dir=$1
    local target_width=$2
    local target_height=$3
    local resolution_name=$4
    
    echo ""
    echo "=== $resolution_name 변환 시작 (병렬 처리) ==="
    echo "목표 해상도: ${target_width}x${target_height}"
    echo "WebP 품질: $WEBP_QUALITY (최고 품질)"
    echo "소스 디렉토리: $SRC_DIR"
    echo "대상 디렉토리: $target_dir"
    echo "병렬 작업 수: $MAX_JOBS"
    echo ""
    
    # 대상 디렉토리 생성
    mkdir -p "$target_dir"
    
    # 변환 작업 함수
    convert_single_file() {
        local src_file=$1
        local target_dir=$2
        local target_width=$3
        local target_height=$4
        
        # 상대 경로 추출
        rel_path="${src_file#$SRC_DIR/}"
        
        # 폴더 구조 유지
        dst_dir="$target_dir/$(dirname "$rel_path")"
        
        # 파일명 유지 (WebP 확장자 그대로)
        filename=$(basename "$rel_path")
        dst_file="$dst_dir/$filename"
        
        # 대상 디렉토리 생성
        mkdir -p "$dst_dir"
        
        # 이미 존재하는 파일인지 확인
        if [ -f "$dst_file" ]; then
            echo "⏭️  건너뜀: $rel_path (이미 존재)"
            return 0
        fi
        
        # 변환
        echo "🔄 변환 중: $rel_path → ${dst_file#$target_dir/}"
        
        if command -v magick &> /dev/null; then
            magick "$src_file" -resize "${target_width}x${target_height}>" -quality "$WEBP_QUALITY" "$dst_file"
        else
            convert "$src_file" -resize "${target_width}x${target_height}>" -quality "$WEBP_QUALITY" "$dst_file"
        fi
        
        if [ $? -eq 0 ]; then
            echo "✅ 완료: ${dst_file#$target_dir/}"
            return 0
        else
            echo "❌ 실패: $rel_path"
            return 1
        fi
    }
    
    export -f convert_single_file
    export SRC_DIR WEBP_QUALITY
    
    # find로 모든 WebP 파일을 찾고 병렬로 처리
    find "$SRC_DIR" -type f -name "*.webp" | \
    xargs -I {} -P "$MAX_JOBS" bash -c 'convert_single_file "$@"' _ {} "$target_dir" "$target_width" "$target_height"
    
    local converted_count=$(find "$target_dir" -name "*.webp" | wc -l)
    
    echo ""
    echo "=== $resolution_name 변환 완료 ==="
    echo "변환된 파일 수: $converted_count"
    echo "결과 디렉토리: $target_dir"
    
    # 결과 파일 개수 확인
    local total_files=$(find "$target_dir" -name "*.webp" | wc -l)
    echo "총 $resolution_name WebP 파일 개수: $total_files"
    echo ""
}

# 4K 변환 실행
convert_to_resolution "4k" "$TARGET_4K_WIDTH" "$TARGET_4K_HEIGHT" "4K"

# 2K 변환 실행
convert_to_resolution "2k" "$TARGET_2K_WIDTH" "$TARGET_2K_HEIGHT" "2K"

echo "🎉 모든 해상도 변환 완료!"
echo ""
echo "=== 최종 결과 요약 ==="
echo "원본 8k 파일:"
find 8k -name "*.webp" | wc -l | xargs echo "  8k 폴더:"
echo "변환된 4k 파일:"
find 4k -name "*.webp" 2>/dev/null | wc -l | xargs echo "  4k 폴더:"
echo "변환된 2k 파일:"
find 2k -name "*.webp" 2>/dev/null | wc -l | xargs echo "  2k 폴더:"
echo ""
echo "📁 폴더 구조:"
echo "  8k/84A, 8k/84B, 8k/84C → 4k/84A, 4k/84B, 4k/84C"
echo "  8k/84A, 8k/84B, 8k/84C → 2k/84A, 2k/84B, 2k/84C"
