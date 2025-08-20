#!/bin/bash

echo "=== 4k vs 2k 파일 비교 분석 ==="
echo ""

# 4k 파일 목록 생성 (상대 경로로)
echo "📁 4k 파일 목록 생성 중..."
find 4k -name "*.webp" | sed 's|^4k/||' | sort > 4k_files_list.txt
total_4k=$(wc -l < 4k_files_list.txt)
echo "4k 파일 수: $total_4k"

# 2k 파일 목록 생성 (상대 경로로)  
echo "📁 2k 파일 목록 생성 중..."
find 2k -name "*.webp" | sed 's|^2k/||' | sort > 2k_files_list.txt
total_2k=$(wc -l < 2k_files_list.txt)
echo "2k 파일 수: $total_2k"

echo ""
echo "=== 비교 결과 ==="

# 4k에는 있지만 2k에는 없는 파일들
echo "🔍 4k에만 있는 파일들:"
missing_in_2k=$(comm -23 4k_files_list.txt 2k_files_list.txt)
missing_count=$(echo "$missing_in_2k" | grep -v '^$' | wc -l)

if [ $missing_count -eq 0 ]; then
    echo "✅ 없음 - 4k의 모든 파일이 2k에 존재합니다!"
else
    echo "❌ $missing_count개 파일이 2k에 없습니다:"
    echo "$missing_in_2k" | head -20
    if [ $missing_count -gt 20 ]; then
        echo "... (총 $missing_count개 중 20개만 표시)"
    fi
    echo ""
    echo "📋 누락된 파일 상세 목록을 4k_missing_in_2k.txt에 저장했습니다."
    echo "$missing_in_2k" > 4k_missing_in_2k.txt
fi

echo ""

# 2k에는 있지만 4k에는 없는 파일들
echo "🔍 2k에만 있는 파일들:"
extra_in_2k=$(comm -13 4k_files_list.txt 2k_files_list.txt)
extra_count=$(echo "$extra_in_2k" | grep -v '^$' | wc -l)

if [ $extra_count -eq 0 ]; then
    echo "✅ 없음 - 2k에 추가 파일이 없습니다!"
else
    echo "📋 $extra_count개 파일이 2k에만 있습니다:"
    echo "$extra_in_2k" | head -20
    if [ $extra_count -gt 20 ]; then
        echo "... (총 $extra_count개 중 20개만 표시)"
    fi
    echo ""
    echo "📋 추가 파일 상세 목록을 2k_extra_files.txt에 저장했습니다."
    echo "$extra_in_2k" > 2k_extra_files.txt
fi

echo ""
echo "=== 요약 ==="
echo "4k 파일 수: $total_4k"
echo "2k 파일 수: $total_2k"
echo "4k에만 있음: $missing_count"
echo "2k에만 있음: $extra_count"
echo "공통 파일: $((total_4k - missing_count))"

# 변환 완료율 계산
if [ $total_4k -gt 0 ]; then
    completion_rate=$(echo "scale=2; ($total_4k - $missing_count) * 100 / $total_4k" | bc)
    echo "변환 완료율: ${completion_rate}%"
fi

echo ""
echo "=== 권장 사항 ==="
if [ $missing_count -gt 0 ]; then
    echo "🔧 4k→2k 변환이 필요한 파일이 $missing_count개 있습니다."
    echo "   ./convert_8k_multi_resolution.sh 를 실행하여 변환을 완료하세요."
elif [ $total_4k -eq $total_2k ] && [ $missing_count -eq 0 ] && [ $extra_count -eq 0 ]; then
    echo "🎉 완벽! 4k와 2k 파일이 완전히 동기화되었습니다!"
else
    echo "📊 4k와 2k 파일 동기화가 거의 완료되었습니다."
fi

# 임시 파일 정리
rm -f 4k_files_list.txt 2k_files_list.txt
