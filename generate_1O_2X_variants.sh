#!/bin/bash

# Corridor_1O_2X 변형 파일 생성 스크립트
# temp/webp_8k의 기본 파일들을 다양한 패턴으로 복사하여 생성

# 작업 디렉토리 설정
SOURCE_DIR="temp/webp_8k"
TARGET_DIR="temp/webp_8k"

# 디렉토리 확인
if [ ! -d "$SOURCE_DIR" ]; then
    echo "소스 디렉토리 '$SOURCE_DIR'가 존재하지 않습니다."
    exit 1
fi

# 함수: 파일 복사
copy_file() {
    local source_file="$1"
    local target_file="$2"
    
    if [ -f "$SOURCE_DIR/$source_file" ]; then
        cp "$SOURCE_DIR/$source_file" "$TARGET_DIR/$target_file"
        echo "생성: $target_file"
    else
        echo "경고: 소스 파일 '$source_file'를 찾을 수 없습니다."
    fi
}

echo "=== Corridor_1O_2X 변형 파일 생성 시작 ==="

# [Corridor_1O_2X_Air.webp] 기반 패턴 생성
echo ""
echo "1. Air 패턴 생성 중..."

copy_file "Corridor_1O_2X_Air.webp" "Corridor_1O_2X_Air_K_B1_B2_B3.webp"
copy_file "Corridor_1O_2X_Air.webp" "Corridor_1O_2X_Air_K_B1.webp"

# [Corridor_1O_2X_Air_n_Sis.webp] 기반 패턴 생성  
echo ""
echo "2. Air_n_Sis 패턴 생성 중..."

copy_file "Corridor_1O_2X_Air_n_Sis.webp" "Corridor_1O_2X_Air_K_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
copy_file "Corridor_1O_2X_Air_n_Sis.webp" "Corridor_1O_2X_Air_K_L_B1_B2_B3_n_Sis_K_L_B1.webp"
copy_file "Corridor_1O_2X_Air_n_Sis.webp" "Corridor_1O_2X_Air_K_L_B1_B2_B3_n_Sis_K_L.webp"
copy_file "Corridor_1O_2X_Air_n_Sis.webp" "Corridor_1O_2X_Air_K_L_B1_n_Sis_K_L_B1_B2_B3.webp"
copy_file "Corridor_1O_2X_Air_n_Sis.webp" "Corridor_1O_2X_Air_K_L_B1_n_Sis_K_L_B1.webp"
copy_file "Corridor_1O_2X_Air_n_Sis.webp" "Corridor_1O_2X_Air_K_L_B1_n_Sis_K_L.webp"
copy_file "Corridor_1O_2X_Air_n_Sis.webp" "Corridor_1O_2X_Air_K_L_n_Sis_K_L_BX.webp"
copy_file "Corridor_1O_2X_Air_n_Sis.webp" "Corridor_1O_2X_Air_K_L_n_Sis_K_L.webp"

# [Corridor_1O_2X_Sis.webp] 기반 패턴 생성
echo ""
echo "3. Sis 패턴 생성 중..."

copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Air_K_L_B1_B2_B3_n_Sis_L_B1.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Air_K_L_B1_n_Sis_L_B1.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Air_K_L_n_Sis_L.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Air_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Air_L_B1_B2_B3_n_Sis_K_L_B1.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Air_L_B1_B2_B3_n_Sis_K_L.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Air_L_B1_n_Sis_K_L_B1_B2_B3.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Air_L_B1_n_Sis_K_L_B1.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Air_L_B1_n_Sis_K_L.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Air_L_n_Sis_K_L.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Sis_K_L_B1_B2_B3.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Sis_K_L_B1.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Sis_K_L.webp"

echo ""
echo "=== 변형 파일 생성 완료 ==="

# 생성된 파일 수 확인
total_files=$(find "$TARGET_DIR" -name "Corridor_1O_2X_*.webp" | wc -l)
echo "📊 총 생성된 파일 수: $total_files"

echo ""
echo "📋 생성된 파일 목록:"
ls -la "$TARGET_DIR"/Corridor_1O_2X_*.webp | head -10
if [ $(ls "$TARGET_DIR"/Corridor_1O_2X_*.webp | wc -l) -gt 10 ]; then
    echo "... (총 $(ls "$TARGET_DIR"/Corridor_1O_2X_*.webp | wc -l)개 파일)"
fi
