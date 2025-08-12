#!/bin/bash

# 84B Corridor 이미지 생성 스크립트
cd /Users/shhan/Workspace/backup/cdn-gs-mall/2025_08_10_0010/8k/84A/corridor

echo "🎨 84B Corridor 이미지 생성 시작"
echo "현재 위치: $(pwd)"
echo ""

# 1단계: Air_K_L + Sis_K_L → Air_n_Sis 복사 (8개 × 4패턴 = 32개)
echo "=== 1단계: Air_K_L + Sis_K_L → Air_n_Sis 복사 (32개) ==="

for pattern in "1O_2O" "1O_2X" "1X_2O" "1X_2X"; do
    echo "패턴 $pattern 처리 중..."
    
    # 8개 조합별로 복사
    cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_K_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
    cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_K_L_B1_B2_B3_n_Sis_K_L_B1.webp"
    cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_K_L_B1_B2_B3_n_Sis_K_L.webp"
    cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_K_L_B1_n_Sis_K_L_B1_B2_B3.webp"
    cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_K_L_B1_n_Sis_K_L_B1.webp"
    cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_K_L_B1_n_Sis_K_L.webp"
    cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_K_L_n_Sis_K_L_BX.webp"
    cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_K_L_n_Sis_K_L.webp"
    
    echo "  $pattern 패턴 8개 완료"
done

echo "1단계 완료: 32개 파일 생성"
echo ""

# 2단계: Air_K_L + Sis_L → Air 복사 (3개 × 4패턴 = 12개)
echo "=== 2단계: Air_K_L + Sis_L → Air 복사 (12개) ==="

for pattern in "1O_2O" "1O_2X" "1X_2O" "1X_2X"; do
    echo "패턴 $pattern 처리 중..."
    
    # 모든 패턴에 Air 이미지가 있으므로 Air 사용
    if [ -f "Corridor_${pattern}_Air.webp" ]; then
        cp "Corridor_${pattern}_Air.webp" "Corridor_${pattern}_Air_K_L_B1_B2_B3_n_Sis_L_B1.webp"
        cp "Corridor_${pattern}_Air.webp" "Corridor_${pattern}_Air_K_L_B1_n_Sis_L_B1.webp"
        cp "Corridor_${pattern}_Air.webp" "Corridor_${pattern}_Air_K_L_n_Sis_L.webp"
        echo "  $pattern 패턴 3개 완료 (Air 이미지 사용)"
    else
        # Air 이미지가 없으면 Air_n_Sis 사용
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_K_L_B1_B2_B3_n_Sis_L_B1.webp"
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_K_L_B1_n_Sis_L_B1.webp"
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_K_L_n_Sis_L.webp"
        echo "  $pattern 패턴 3개 완료 (Air_n_Sis 이미지 사용)"
    fi
done

echo "2단계 완료: 12개 파일 생성"
echo ""

# 3단계: Air_L + Sis_K_L → Sis 복사 (7개 × 4패턴 = 28개)
echo "=== 3단계: Air_L + Sis_K_L → Sis 복사 (28개) ==="

for pattern in "1O_2O" "1O_2X" "1X_2O" "1X_2X"; do
    echo "패턴 $pattern 처리 중..."
    
    # Sis 이미지가 있는지 확인하고 복사
    if [ -f "Corridor_${pattern}_Sis.webp" ]; then
        # 7개 조합별로 복사
        cp "Corridor_${pattern}_Sis.webp" "Corridor_${pattern}_Air_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
        cp "Corridor_${pattern}_Sis.webp" "Corridor_${pattern}_Air_L_B1_B2_B3_n_Sis_K_L_B1.webp"
        cp "Corridor_${pattern}_Sis.webp" "Corridor_${pattern}_Air_L_B1_B2_B3_n_Sis_K_L.webp"
        cp "Corridor_${pattern}_Sis.webp" "Corridor_${pattern}_Air_L_B1_n_Sis_K_L_B1_B2_B3.webp"
        cp "Corridor_${pattern}_Sis.webp" "Corridor_${pattern}_Air_L_B1_n_Sis_K_L_B1.webp"
        cp "Corridor_${pattern}_Sis.webp" "Corridor_${pattern}_Air_L_B1_n_Sis_K_L.webp"
        cp "Corridor_${pattern}_Sis.webp" "Corridor_${pattern}_Air_L_n_Sis_K_L.webp"
        echo "  $pattern 패턴 7개 완료 (Sis 이미지 사용)"
    else
        # Sis 이미지가 없으면 Air_n_Sis 사용
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_L_B1_B2_B3_n_Sis_K_L_B1.webp"
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_L_B1_B2_B3_n_Sis_K_L.webp"
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_L_B1_n_Sis_K_L_B1_B2_B3.webp"
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_L_B1_n_Sis_K_L_B1.webp"
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_L_B1_n_Sis_K_L.webp"
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_L_n_Sis_K_L.webp"
        echo "  $pattern 패턴 7개 완료 (Air_n_Sis 이미지 사용)"
    fi
done

echo "3단계 완료: 28개 파일 생성"
echo ""

# 4단계: 기타 → 적절한 이미지 복사 (3개 × 4패턴 = 12개)
echo "=== 4단계: 기타 → 적절한 이미지 복사 (12개) ==="

for pattern in "1O_2O" "1O_2X" "1X_2O" "1X_2X"; do
    echo "패턴 $pattern 처리 중..."
    
    # Air_L_n_Sis_L → Air_n_Sis 사용
    cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Air_L_n_Sis_L.webp"
    
    # Sis_K_L_B1_B2_B3, Sis_K_L_B1, Sis_K_L → Sis 또는 Air_n_Sis 사용
    if [ -f "Corridor_${pattern}_Sis.webp" ]; then
        cp "Corridor_${pattern}_Sis.webp" "Corridor_${pattern}_Sis_K_L_B1_B2_B3.webp"
        cp "Corridor_${pattern}_Sis.webp" "Corridor_${pattern}_Sis_K_L_B1.webp"
        cp "Corridor_${pattern}_Sis.webp" "Corridor_${pattern}_Sis_K_L.webp"
        echo "  $pattern 패턴 4개 완료 (Sis 이미지 사용)"
    else
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Sis_K_L_B1_B2_B3.webp"
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Sis_K_L_B1.webp"
        cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_Sis_K_L.webp"
        echo "  $pattern 패턴 4개 완료 (Air_n_Sis 이미지 사용)"
    fi
done

echo "4단계 완료: 16개 파일 생성"
echo ""

# 5단계: Air_K 패턴 → Air 또는 Air_n_Sis 복사 (추가 패턴들)
echo "=== 5단계: Air_K 패턴 → Air 또는 Air_n_Sis 복사 ==="

# ttemp.txt에서 누락된 Air_K 관련 패턴들 추가
air_k_patterns=(
    "Air_K_B1_B2_B3"
    "Air_K_B1"
    "Air_K"
)

step5_count=0
for pattern in "1O_2O" "1O_2X" "1X_2O" "1X_2X"; do
    echo "패턴 $pattern 처리 중..."
    
    for air_k_pattern in "${air_k_patterns[@]}"; do
        # Air 이미지가 있으면 사용, 없으면 Air_n_Sis 사용
        if [ -f "Corridor_${pattern}_Air.webp" ]; then
            cp "Corridor_${pattern}_Air.webp" "Corridor_${pattern}_${air_k_pattern}.webp"
        else
            cp "Corridor_${pattern}_Air_n_Sis.webp" "Corridor_${pattern}_${air_k_pattern}.webp"
        fi
        ((step5_count++))
    done
    
    echo "  $pattern 패턴 ${#air_k_patterns[@]}개 완료"
done

echo "5단계 완료: ${step5_count}개 파일 생성"
echo ""

# 검증 - 정확한 개수 확인
echo "=== 생성된 파일 개수 확인 ==="

# 1단계: Air_K_L + Sis_K_L 조합 (정확히 8개 × 4패턴 = 32개)
step1_files=(
    "Air_K_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3"
    "Air_K_L_B1_B2_B3_n_Sis_K_L_B1"
    "Air_K_L_B1_B2_B3_n_Sis_K_L"
    "Air_K_L_B1_n_Sis_K_L_B1_B2_B3"
    "Air_K_L_B1_n_Sis_K_L_B1"
    "Air_K_L_B1_n_Sis_K_L"
    "Air_K_L_n_Sis_K_L_BX"
    "Air_K_L_n_Sis_K_L"
)

step1_count=0
for pattern in "1O_2O" "1O_2X" "1X_2O" "1X_2X"; do
    for file_pattern in "${step1_files[@]}"; do
        if [ -f "Corridor_${pattern}_${file_pattern}.webp" ]; then
            ((step1_count++))
        fi
    done
done

# 2단계: Air_K_L + Sis_L 조합 (3개 × 4패턴 = 12개)
step2_files=(
    "Air_K_L_B1_B2_B3_n_Sis_L_B1"
    "Air_K_L_B1_n_Sis_L_B1"
    "Air_K_L_n_Sis_L"
)

step2_count=0
for pattern in "1O_2O" "1O_2X" "1X_2O" "1X_2X"; do
    for file_pattern in "${step2_files[@]}"; do
        if [ -f "Corridor_${pattern}_${file_pattern}.webp" ]; then
            ((step2_count++))
        fi
    done
done

# 3단계: Air_L + Sis_K_L 조합 (7개 × 4패턴 = 28개)
step3_files=(
    "Air_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3"
    "Air_L_B1_B2_B3_n_Sis_K_L_B1"
    "Air_L_B1_B2_B3_n_Sis_K_L"
    "Air_L_B1_n_Sis_K_L_B1_B2_B3"
    "Air_L_B1_n_Sis_K_L_B1"
    "Air_L_B1_n_Sis_K_L"
    "Air_L_n_Sis_K_L"
)

step3_count=0
for pattern in "1O_2O" "1O_2X" "1X_2O" "1X_2X"; do
    for file_pattern in "${step3_files[@]}"; do
        if [ -f "Corridor_${pattern}_${file_pattern}.webp" ]; then
            ((step3_count++))
        fi
    done
done

# 4단계: 기타 (4개 × 4패턴 = 16개)
step4_files=(
    "Air_L_n_Sis_L"
    "Sis_K_L_B1_B2_B3"
    "Sis_K_L_B1"
    "Sis_K_L"
)

step4_count=0
for pattern in "1O_2O" "1O_2X" "1X_2O" "1X_2X"; do
    for file_pattern in "${step4_files[@]}"; do
        if [ -f "Corridor_${pattern}_${file_pattern}.webp" ]; then
            ((step4_count++))
        fi
    done
done

# 5단계: Air_K 패턴 (3개 × 4패턴 = 12개)
step5_files=(
    "Air_K_B1_B2_B3"
    "Air_K_B1"
    "Air_K"
)

step5_count=0
for pattern in "1O_2O" "1O_2X" "1X_2O" "1X_2X"; do
    for file_pattern in "${step5_files[@]}"; do
        if [ -f "Corridor_${pattern}_${file_pattern}.webp" ]; then
            ((step5_count++))
        fi
    done
done

total_generated=$((step1_count + step2_count + step3_count + step4_count + step5_count))

echo "1단계 (Air_K_L + Sis_K_L): ${step1_count}개 / 32개"
echo "2단계 (Air_K_L + Sis_L): ${step2_count}개 / 12개"
echo "3단계 (Air_L + Sis_K_L): ${step3_count}개 / 28개"
echo "4단계 (기타): ${step4_count}개 / 16개"
echo "5단계 (Air_K): ${step5_count}개 / 12개"
echo "총 생성된 파일: ${total_generated}개 / 100개"

if [ $total_generated -eq 100 ]; then
    echo "✅ 모든 파일이 성공적으로 생성되었습니다!"
else
    echo "❌ 생성된 파일: ${total_generated}개, 누락: $((100 - total_generated))개"
fi

echo ""
echo "🎨 84B Corridor 이미지 생성 완료"
