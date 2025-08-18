#!/bin/bash

# temp/webp_8k의 *_Sis.webp 파일들을 기반으로 Sis_K_L 패턴 파일 생성 스크립트

# 작업 디렉토리 설정
SRC_DIR="temp/webp_8k"
TARGET_DIR="8k"

echo "=== Sis_K_L 패턴 파일 생성 시작 ==="

# 디렉토리 확인
if [ ! -d "$SRC_DIR" ]; then
    echo "소스 디렉토리 '$SRC_DIR'가 존재하지 않습니다."
    exit 1
fi

# 대상 디렉토리 생성
mkdir -p "$TARGET_DIR"

# 함수: 파일 복사
copy_file() {
    local source_file="$1"
    local target_file="$2"
    
    if [ -f "$SRC_DIR/$source_file" ]; then
        cp "$SRC_DIR/$source_file" "$TARGET_DIR/$target_file"
        echo "생성: $target_file"
    else
        echo "경고: 소스 파일 '$source_file'를 찾을 수 없습니다."
    fi
}

echo ""
echo "Sis_K_L 패턴 생성 중..."

# Corridor_1X_2X_Sis.webp 기반 파일들
copy_file "Corridor_1X_2X_Sis.webp" "Corridor_1X_2X_Sis_K_L_B1_B2_B3.webp"
copy_file "Corridor_1X_2X_Sis.webp" "Corridor_1X_2X_Sis_K_L_B1.webp"
copy_file "Corridor_1X_2X_Sis.webp" "Corridor_1X_2X_Sis_K_L.webp"
copy_file "Corridor_1X_2X_Sis.webp" "Corridor_1X_2X_Sis_K.webp"

# Corridor_1X_2O_Sis.webp 기반 파일들
copy_file "Corridor_1X_2O_Sis.webp" "Corridor_1X_2O_Sis_K_L_B1_B2_B3.webp"
copy_file "Corridor_1X_2O_Sis.webp" "Corridor_1X_2O_Sis_K_L_B1.webp"
copy_file "Corridor_1X_2O_Sis.webp" "Corridor_1X_2O_Sis_K_L.webp"
copy_file "Corridor_1X_2O_Sis.webp" "Corridor_1X_2O_Sis_K.webp"

# Corridor_1O_2O_Sis.webp 기반 파일들
copy_file "Corridor_1O_2O_Sis.webp" "Corridor_1O_2O_Sis_K_L_B1_B2_B3.webp"
copy_file "Corridor_1O_2O_Sis.webp" "Corridor_1O_2O_Sis_K_L_B1.webp"
copy_file "Corridor_1O_2O_Sis.webp" "Corridor_1O_2O_Sis_K_L.webp"
copy_file "Corridor_1O_2O_Sis.webp" "Corridor_1O_2O_Sis_K.webp"

# Corridor_1O_2X_Sis.webp 기반 파일들
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Sis_K_L_B1_B2_B3.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Sis_K_L_B1.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Sis_K_L.webp"
copy_file "Corridor_1O_2X_Sis.webp" "Corridor_1O_2X_Sis_K.webp"

echo ""
echo "=== Sis_K_L 패턴 파일 생성 완료 ==="
echo "총 생성된 파일 개수: $(find $TARGET_DIR -name "Corridor_*_Sis_K*.webp" | wc -l)"
