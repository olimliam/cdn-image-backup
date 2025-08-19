#!/bin/bash

echo "=== temp 폴더 파일명을 Corridor_1O_2X_* 패턴으로 변경 시작 ==="

# temp 디렉토리로 이동
cd temp

# 변경할 파일 수 확인
total_files=$(find . -maxdepth 1 -name "Corridor_*.webp" | wc -l)
echo "📁 변경할 파일 수: $total_files"

# 변경된 파일 수 카운터
changed_count=0

# Corridor_1X_2O_로 시작하는 모든 webp 파일을 Corridor_1O_2O_로 변경
for file in Corridor_1X_2X_*.webp; do
    if [ -f "$file" ]; then
        # 새 파일명 생성 (1X_2X를 1O_2X로 변경)
        new_name=$(echo "$file" | sed 's/Corridor_1X_2X_/Corridor_1O_2X_/')
        
        # 파일명 변경
        mv "$file" "$new_name"
        echo "🔄 변경: $file → $new_name"
        ((changed_count++))
    fi
done

echo ""
echo "=== 파일명 변경 완료 ==="
echo "📊 총 변경된 파일 수: $changed_count"
echo ""

# 변경 결과 확인
echo "📋 변경 후 파일 목록:"
ls -la Corridor_1O_2X_*.webp | head -10
if [ $(ls Corridor_1O_2X_*.webp | wc -l) -gt 10 ]; then
    echo "... (총 $(ls Corridor_1O_2X_*.webp | wc -l)개 파일)"
fi
