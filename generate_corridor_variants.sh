#!/bin/bash

# Corridor 변형 파일 생성 스크립트
# 기본 파일들을 다양한 패턴으로 복사하여 생성

# 작업 디렉토리 설정
SOURCE_DIR="temp"
TARGET_DIR="8k"

# 디렉토리 확인
if [ ! -d "$SOURCE_DIR" ]; then
    echo "소스 디렉토리 '$SOURCE_DIR'가 존재하지 않습니다."
    exit 1
fi

# 함수: 파일 복사 및 변환 (PNG에서 WebP로)
copy_and_convert() {
    local source_file="$1"
    local target_file="$2"
    
    if [ -f "$SOURCE_DIR/$source_file" ]; then
        # PNG 파일을 WebP로 변환하면서 복사
        cwebp "$SOURCE_DIR/$source_file" -o "$TARGET_DIR/$target_file" -q 90
        echo "생성: $target_file"
    else
        echo "경고: 소스 파일 '$source_file'를 찾을 수 없습니다."
    fi
}

echo "=== Corridor 변형 파일 생성 시작 ==="

# [Air_n_Sis] 패턴 생성
echo ""
echo "1. Air_n_Sis 패턴 생성 중..."

# Corridor_1X_2X_Air_n_Sis.webp 기반 파일들
copy_and_convert "Corridor_1X_2X_Air_n_Sis.png" "Corridor_1X_2X_Air_K_L_B1_B2_B3_n_Sis_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1X_2X_Air_n_Sis.png" "Corridor_1X_2X_Air_K_L_B1_B2_B3_n_Sis_L_B1.webp"
copy_and_convert "Corridor_1X_2X_Air_n_Sis.png" "Corridor_1X_2X_Air_K_L_B1_B2_B3_n_Sis_L.webp"
copy_and_convert "Corridor_1X_2X_Air_n_Sis.png" "Corridor_1X_2X_Air_K_L_B1_n_Sis_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1X_2X_Air_n_Sis.png" "Corridor_1X_2X_Air_K_L_B1_n_Sis_L_B1.webp"
copy_and_convert "Corridor_1X_2X_Air_n_Sis.png" "Corridor_1X_2X_Air_K_L_B1_n_Sis_L.webp"
copy_and_convert "Corridor_1X_2X_Air_n_Sis.png" "Corridor_1X_2X_Air_K_L_n_Sis_L.webp"

# Corridor_1X_2O_Air_n_Sis.webp 기반 파일들
copy_and_convert "Corridor_1X_2O_Air_n_Sis.png" "Corridor_1X_2O_Air_K_L_B1_B2_B3_n_Sis_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1X_2O_Air_n_Sis.png" "Corridor_1X_2O_Air_K_L_B1_B2_B3_n_Sis_L_B1.webp"
copy_and_convert "Corridor_1X_2O_Air_n_Sis.png" "Corridor_1X_2O_Air_K_L_B1_B2_B3_n_Sis_L.webp"
copy_and_convert "Corridor_1X_2O_Air_n_Sis.png" "Corridor_1X_2O_Air_K_L_B1_n_Sis_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1X_2O_Air_n_Sis.png" "Corridor_1X_2O_Air_K_L_B1_n_Sis_L_B1.webp"
copy_and_convert "Corridor_1X_2O_Air_n_Sis.png" "Corridor_1X_2O_Air_K_L_B1_n_Sis_L.webp"
copy_and_convert "Corridor_1X_2O_Air_n_Sis.png" "Corridor_1X_2O_Air_K_L_n_Sis_K_L.webp"

# Corridor_1O_2O_Air_n_Sis.webp 기반 파일들
copy_and_convert "Corridor_1O_2O_Air_n_Sis.png" "Corridor_1O_2O_Air_K_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1O_2O_Air_n_Sis.png" "Corridor_1O_2O_Air_K_L_B1_B2_B3_n_Sis_K_L_B1.webp"
copy_and_convert "Corridor_1O_2O_Air_n_Sis.png" "Corridor_1O_2O_Air_K_L_B1_B2_B3_n_Sis_K_L.webp"
copy_and_convert "Corridor_1O_2O_Air_n_Sis.png" "Corridor_1O_2O_Air_K_L_B1_n_Sis_K_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1O_2O_Air_n_Sis.png" "Corridor_1O_2O_Air_K_L_B1_n_Sis_K_L_B1.webp"
copy_and_convert "Corridor_1O_2O_Air_n_Sis.png" "Corridor_1O_2O_Air_K_L_B1_n_Sis_K_L.webp"
copy_and_convert "Corridor_1O_2O_Air_n_Sis.png" "Corridor_1O_2O_Air_K_L_n_Sis_K_L.webp"

# Corridor_1O_2X_Air_n_Sis.webp 기반 파일들
copy_and_convert "Corridor_1O_2X_Air_n_Sis.png" "Corridor_1O_2X_Air_K_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1O_2X_Air_n_Sis.png" "Corridor_1O_2X_Air_K_L_B1_B2_B3_n_Sis_K_L_B1.webp"
copy_and_convert "Corridor_1O_2X_Air_n_Sis.png" "Corridor_1O_2X_Air_K_L_B1_B2_B3_n_Sis_K_L.webp"
copy_and_convert "Corridor_1O_2X_Air_n_Sis.png" "Corridor_1O_2X_Air_K_L_B1_n_Sis_K_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1O_2X_Air_n_Sis.png" "Corridor_1O_2X_Air_K_L_B1_n_Sis_K_L_B1.webp"
copy_and_convert "Corridor_1O_2X_Air_n_Sis.png" "Corridor_1O_2X_Air_K_L_B1_n_Sis_K_L.webp"
copy_and_convert "Corridor_1O_2X_Air_n_Sis.png" "Corridor_1O_2X_Air_K_L_n_Sis_K_L.webp"

# [Air] 패턴 생성
echo ""
echo "2. Air 패턴 생성 중..."

# Corridor_1X_2X_Air.webp 기반 파일들
copy_and_convert "Corridor_1X_2X_Air.png" "Corridor_1X_2X_Air_K_L_B1_B2_B3_n_Sis_L_B1.webp"
copy_and_convert "Corridor_1X_2X_Air.png" "Corridor_1X_2X_Air_K_L_B1_n_Sis_L_B1.webp"
copy_and_convert "Corridor_1X_2X_Air.png" "Corridor_1X_2X_Air_K_L_n_Sis_L.webp"
copy_and_convert "Corridor_1X_2X_Air.png" "Corridor_1X_2X_Air_K.webp"

# Corridor_1X_2O_Air.webp 기반 파일들
copy_and_convert "Corridor_1X_2O_Air.png" "Corridor_1X_2O_Air_K_L_B1_B2_B3_n_Sis_L_B1.webp"
copy_and_convert "Corridor_1X_2O_Air.png" "Corridor_1X_2O_Air_K_L_B1_n_Sis_L_B1.webp"
copy_and_convert "Corridor_1X_2O_Air.png" "Corridor_1X_2O_Air_K_L_n_Sis_L.webp"
copy_and_convert "Corridor_1X_2O_Air.png" "Corridor_1X_2O_Air_K.webp"

# Corridor_1O_2O_Air.webp 기반 파일들
copy_and_convert "Corridor_1O_2O_Air.png" "Corridor_1O_2O_Air_K_L_B1_B2_B3_n_Sis_L_B1.webp"
copy_and_convert "Corridor_1O_2O_Air.png" "Corridor_1O_2O_Air_K_L_B1_n_Sis_L_B1.webp"
copy_and_convert "Corridor_1O_2O_Air.png" "Corridor_1O_2O_Air_K_L_n_Sis_L.webp"
copy_and_convert "Corridor_1O_2O_Air.png" "Corridor_1O_2O_Air_K.webp"

# Corridor_1O_2X_Air.webp 기반 파일들
copy_and_convert "Corridor_1O_2X_Air.png" "Corridor_1O_2X_Air_K_L_B1_B2_B3_n_Sis_L_B1.webp"
copy_and_convert "Corridor_1O_2X_Air.png" "Corridor_1O_2X_Air_K_L_B1_n_Sis_L_B1.webp"
copy_and_convert "Corridor_1O_2X_Air.png" "Corridor_1O_2X_Air_K_L_n_Sis_L.webp"
copy_and_convert "Corridor_1O_2X_Air.png" "Corridor_1O_2X_Air_K.webp"

# [Sis] 패턴 생성
echo ""
echo "3. Sis 패턴 생성 중..."

# Corridor_1X_2X_Sis.webp 기반 파일들
copy_and_convert "Corridor_1X_2X_Sis.png" "Corridor_1X_2X_Air_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1X_2X_Sis.png" "Corridor_1X_2X_Air_L_B1_B2_B3_n_Sis_K_L_B1.webp"
copy_and_convert "Corridor_1X_2X_Sis.png" "Corridor_1X_2X_Air_L_B1_B2_B3_n_Sis_K_L.webp"
copy_and_convert "Corridor_1X_2X_Sis.png" "Corridor_1X_2X_Air_L_B1_n_Sis_K_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1X_2X_Sis.png" "Corridor_1X_2X_Air_L_B1_n_Sis_K_L_B1.webp"
copy_and_convert "Corridor_1X_2X_Sis.png" "Corridor_1X_2X_Air_L_B1_n_Sis_K_L.webp"
copy_and_convert "Corridor_1X_2X_Sis.png" "Corridor_1X_2X_Air_L_n_Sis_K_L.webp"

# Corridor_1X_2O_Sis.webp 기반 파일들
copy_and_convert "Corridor_1X_2O_Sis.png" "Corridor_1X_2O_Air_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1X_2O_Sis.png" "Corridor_1X_2O_Air_L_B1_B2_B3_n_Sis_K_L_B1.webp"
copy_and_convert "Corridor_1X_2O_Sis.png" "Corridor_1X_2O_Air_L_B1_B2_B3_n_Sis_K_L.webp"
copy_and_convert "Corridor_1X_2O_Sis.png" "Corridor_1X_2O_Air_L_B1_n_Sis_K_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1X_2O_Sis.png" "Corridor_1X_2O_Air_L_B1_n_Sis_K_L_B1.webp"
copy_and_convert "Corridor_1X_2O_Sis.png" "Corridor_1X_2O_Air_L_B1_n_Sis_K_L.webp"
copy_and_convert "Corridor_1X_2O_Sis.png" "Corridor_1X_2O_Air_L_n_Sis_K_L.webp"

# Corridor_1O_2O_Sis.webp 기반 파일들
copy_and_convert "Corridor_1O_2O_Sis.png" "Corridor_1O_2O_Air_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1O_2O_Sis.png" "Corridor_1O_2O_Air_L_B1_B2_B3_n_Sis_K_L_B1.webp"
copy_and_convert "Corridor_1O_2O_Sis.png" "Corridor_1O_2O_Air_L_B1_B2_B3_n_Sis_K_L.webp"
copy_and_convert "Corridor_1O_2O_Sis.png" "Corridor_1O_2O_Air_L_B1_n_Sis_K_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1O_2O_Sis.png" "Corridor_1O_2O_Air_L_B1_n_Sis_K_L_B1.webp"
copy_and_convert "Corridor_1O_2O_Sis.png" "Corridor_1O_2O_Air_L_B1_n_Sis_K_L.webp"
copy_and_convert "Corridor_1O_2O_Sis.png" "Corridor_1O_2O_Air_L_n_Sis_K_L.webp"

# Corridor_1O_2X_Sis.webp 기반 파일들
copy_and_convert "Corridor_1O_2X_Sis.png" "Corridor_1O_2X_Air_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1O_2X_Sis.png" "Corridor_1O_2X_Air_L_B1_B2_B3_n_Sis_K_L_B1.webp"
copy_and_convert "Corridor_1O_2X_Sis.png" "Corridor_1O_2X_Air_L_B1_B2_B3_n_Sis_K_L.webp"
copy_and_convert "Corridor_1O_2X_Sis.png" "Corridor_1O_2X_Air_L_B1_n_Sis_K_L_B1_B2_B3.webp"
copy_and_convert "Corridor_1O_2X_Sis.png" "Corridor_1O_2X_Air_L_B1_n_Sis_K_L_B1.webp"
copy_and_convert "Corridor_1O_2X_Sis.png" "Corridor_1O_2X_Air_L_B1_n_Sis_K_L.webp"
copy_and_convert "Corridor_1O_2X_Sis.png" "Corridor_1O_2X_Air_L_n_Sis_K_L.webp"

echo ""
echo "=== Corridor 변형 파일 생성 완료 ==="
echo "총 생성된 파일 개수: $(find $TARGET_DIR -name "Corridor_*_*.webp" | wc -l)"
