#!/bin/bash

# Kitchen Common Air 변형 파일 생성 스크립트
# temp/webp_8k의 Kitchen_Common_Air_n_Sis*.webp 파일들을 기반으로 다양한 패턴 생성

# 작업 디렉토리 설정
SRC_DIR="temp/webp_8k"
TARGET_DIR="8k"

echo "=== Kitchen Common Air 변형 파일 생성 시작 ==="

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
echo "1. Kitchen_Common_Air_n_Sis.webp 기반 패턴 생성 중..."

# Kitchen_Common_Air_n_Sis.webp 기반 파일들
copy_file "Kitchen_Common_Air_n_Sis.webp" "Kitchen_Common_Air_K_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
copy_file "Kitchen_Common_Air_n_Sis.webp" "Kitchen_Common_Air_K_L_B1_B2_B3_n_Sis_K_L_B1.webp"
copy_file "Kitchen_Common_Air_n_Sis.webp" "Kitchen_Common_Air_K_L_B1_B2_B3_n_Sis_K_L.webp"
copy_file "Kitchen_Common_Air_n_Sis.webp" "Kitchen_Common_Air_K_L_B1_n_Sis_K_L_B1_B2_B3.webp"
copy_file "Kitchen_Common_Air_n_Sis.webp" "Kitchen_Common_Air_K_L_B1_n_Sis_K_L_B1.webp"
copy_file "Kitchen_Common_Air_n_Sis.webp" "Kitchen_Common_Air_K_L_B1_n_Sis_K_L.webp"
copy_file "Kitchen_Common_Air_n_Sis.webp" "Kitchen_Common_Air_K_L_n_Sis_K_L.webp"

echo ""
echo "2. Kitchen_Common_Air_n_Sis2.webp 기반 패턴 생성 중..."

# Kitchen_Common_Air_n_Sis2.webp 기반 파일들
copy_file "Kitchen_Common_Air_n_Sis2.webp" "Kitchen_Common_Air_K_L_B1_B2_B3_n_Sis_L_B1.webp"
copy_file "Kitchen_Common_Air_n_Sis2.webp" "Kitchen_Common_Air_K_L_B1_n_Sis_L_B1.webp"
copy_file "Kitchen_Common_Air_n_Sis2.webp" "Kitchen_Common_Air_K_L_n_Sis_L.webp"

echo ""
echo "3. Kitchen_Common_Air_n_Sis3.webp 기반 패턴 생성 중..."

# Kitchen_Common_Air_n_Sis3.webp 기반 파일들
copy_file "Kitchen_Common_Air_n_Sis3.webp" "Kitchen_Common_Air_L_B1_B2_B3_n_Sis_K_L_B1_B2_B3.webp"
copy_file "Kitchen_Common_Air_n_Sis3.webp" "Kitchen_Common_Air_L_B1_B2_B3_n_Sis_K_L_B1.webp"
copy_file "Kitchen_Common_Air_n_Sis3.webp" "Kitchen_Common_Air_L_B1_B2_B3_n_Sis_K_L.webp"
copy_file "Kitchen_Common_Air_n_Sis3.webp" "Kitchen_Common_Air_L_B1_B2_B3_n_Sis_L_B1.webp"
copy_file "Kitchen_Common_Air_n_Sis3.webp" "Kitchen_Common_Air_L_B1_n_Sis_K_L_B1_B2_B3.webp"
copy_file "Kitchen_Common_Air_n_Sis3.webp" "Kitchen_Common_Air_L_B1_n_Sis_K_L_B1.webp"
copy_file "Kitchen_Common_Air_n_Sis3.webp" "Kitchen_Common_Air_L_B1_n_Sis_K_L.webp"
copy_file "Kitchen_Common_Air_n_Sis3.webp" "Kitchen_Common_Air_L_B1_n_Sis_L_B1.webp"

echo ""
echo "=== Kitchen Common Air 변형 파일 생성 완료 ==="
echo "총 생성된 파일 개수: $(find $TARGET_DIR -name "Kitchen_Common_Air_*.webp" | wc -l)"
echo ""
echo "생성된 파일 목록:"
ls -la "$TARGET_DIR"/Kitchen_Common_Air_*.webp 2>/dev/null | head -10
