#!/bin/bash

# 이미지를 4K 해상도로 줄이고 WebP 포맷으로 변환하는 스크립트

# 작업 디렉토리 설정
WORK_DIR="/Users/shhan/Workspace/backup/cdn-gs-mall/2025_08_10_0010/temp"
cd "$WORK_DIR"

echo "🖼️ 이미지 4K WebP 변환 작업 시작"
echo "현재 위치: $(pwd)"
echo ""

# ImageMagick이 설치되어 있는지 확인
if ! command -v convert &> /dev/null && ! command -v magick &> /dev/null; then
    echo "❌ ImageMagick이 설치되어 있지 않습니다."
    echo "설치 방법:"
    echo "brew install imagemagick"
    exit 1
fi

# 변환할 이미지 확장자 목록
IMAGE_EXTENSIONS=("*.jpg" "*.jpeg" "*.png" "*.tiff" "*.tif" "*.bmp")

# 4K 해상도 설정 (3840x2160)
TARGET_WIDTH=3840
TARGET_HEIGHT=2160

# WebP 품질 설정 (0-100, 85는 높은 품질)
WEBP_QUALITY=85

# 변환된 파일 카운터
converted_count=0
skipped_count=0
error_count=0

echo "=== 설정 정보 ==="
echo "목표 해상도: ${TARGET_WIDTH}x${TARGET_HEIGHT} (4K)"
echo "WebP 품질: ${WEBP_QUALITY}"
echo "작업 디렉토리: $WORK_DIR"
echo ""

# 재귀적으로 모든 하위 디렉토리에서 이미지 파일 찾기
find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.tiff" -o -iname "*.tif" -o -iname "*.bmp" \) | while read -r image_file; do
    # 파일명에서 확장자 제거
    base_name="${image_file%.*}"
    
    # 출력 파일명 (.webp)
    output_file="${base_name}.webp"
    
    # 이미 WebP 파일이 존재하는지 확인
    if [ -f "$output_file" ]; then
        echo "⏭️  건너뜀: $output_file (이미 존재)"
        ((skipped_count++))
        continue
    fi
    
    echo "🔄 변환 중: $image_file"
    
    # ImageMagick을 사용하여 이미지 변환
    # -resize: 4K 해상도로 크기 조정 (비율 유지)
    # -quality: WebP 품질 설정
    # -define: WebP 관련 옵션
    if command -v magick &> /dev/null; then
        # ImageMagick 7.x
        if magick "$image_file" \
            -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" \
            -quality "$WEBP_QUALITY" \
            -define webp:lossless=false \
            -define webp:alpha-quality=100 \
            "$output_file"; then
            echo "✅ 성공: $output_file"
            ((converted_count++))
        else
            echo "❌ 실패: $image_file"
            ((error_count++))
        fi
    else
        # ImageMagick 6.x
        if convert "$image_file" \
            -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}>" \
            -quality "$WEBP_QUALITY" \
            -define webp:lossless=false \
            -define webp:alpha-quality=100 \
            "$output_file"; then
            echo "✅ 성공: $output_file"
            ((converted_count++))
        else
            echo "❌ 실패: $image_file"
            ((error_count++))
        fi
    fi
    
    echo ""
done

echo "🎨 이미지 변환 작업 완료"
echo ""
echo "=== 결과 요약 ==="
echo "✅ 변환 완료: ${converted_count}개"
echo "⏭️  건너뜀: ${skipped_count}개"
echo "❌ 실패: ${error_count}개"
echo "📊 총 처리: $((converted_count + skipped_count + error_count))개"

if [ $error_count -gt 0 ]; then
    echo ""
    echo "⚠️  일부 파일 변환에 실패했습니다. 로그를 확인해주세요."
fi

echo ""
echo "🎯 4K WebP 변환 작업이 완료되었습니다!"
