#!/bin/bash

echo "=== 8k vs 4k 파일 비교 분석 ==="
echo ""

# 8k 파일 목록 생성 (상대 경로로)
echo "📁 8k 파일 목록 생성 중..."
find 8k -name "*.webp" | sed 's|^8k/||' | sort > 8k_files_list.txt
total_8k=$(wc -l < 8k_files_list.txt)
echo "8k 파일 수: $total_8k"

# 4k 파일 목록 생성 (상대 경로로)  
echo "📁 4k 파일 목록 생성 중..."
find 4k -name "*.webp" | sed 's|^4k/||' | sort > 4k_files_list.txt
total_4k=$(wc -l < 4k_files_list.txt)
echo "4k 파일 수: $total_4k"

echo ""
echo "=== 비교 결과 ==="

# 8k에는 있지만 4k에는 없는 파일들
echo "🔍 8k에만 있는 파일들:"
missing_in_4k=$(comm -23 8k_files_list.txt 4k_files_list.txt)
missing_count=$(echo "$missing_in_4k" | grep -v '^$' | wc -l)

if [ $missing_count -eq 0 ]; then
    echo "✅ 없음 - 8k의 모든 파일이 4k에 존재합니다!"
else
    echo "❌ $missing_count개 파일이 4k에 없습니다:"
    echo "$missing_in_4k" | head -20
    if [ $missing_count -gt 20 ]; then
        echo "... (총 $missing_count개 중 20개만 표시)"
    fi
fi

echo ""

# 4k에는 있지만 8k에는 없는 파일들
echo "🔍 4k에만 있는 파일들:"
extra_in_4k=$(comm -13 8k_files_list.txt 4k_files_list.txt)
extra_count=$(echo "$extra_in_4k" | grep -v '^$' | wc -l)

if [ $extra_count -eq 0 ]; then
    echo "✅ 없음 - 4k에 추가 파일이 없습니다!"
else
    echo "📋 $extra_count개 파일이 4k에만 있습니다:"
    echo "$extra_in_4k" | head -20
    if [ $extra_count -gt 20 ]; then
        echo "... (총 $extra_count개 중 20개만 표시)"
    fi
fi

echo ""
echo "=== 요약 ==="
echo "8k 파일 수: $total_8k"
echo "4k 파일 수: $total_4k"
echo "8k에만 있음: $missing_count"
echo "4k에만 있음: $extra_count"
echo "공통 파일: $((total_8k - missing_count))"

# 임시 파일 정리
rm -f 8k_files_list.txt 4k_files_list.txt
