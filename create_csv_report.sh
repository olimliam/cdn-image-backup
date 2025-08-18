#!/bin/bash

# 중복 이미지를 CSV 형식으로 정리하는 스크립트
output_csv="duplicate_images_report.csv"

echo "=== CSV 리포트 생성 시작 ==="

# CSV 헤더 생성
echo "그룹번호,해시값,파일명,전체경로,폴더타입,방타입,파일타입,중복개수" > $output_csv

group_num=1

# 모든 webp 파일의 해시 계산
all_hash_file=$(mktemp)
find ./8k -name "*.webp" -type f -exec md5sum {} + | sort > $all_hash_file

# 중복된 해시값만 추출
duplicated_hashes=$(cut -d' ' -f1 $all_hash_file | uniq -d)

if [ ! -z "$duplicated_hashes" ]; then
    echo "$duplicated_hashes" | while read hash; do
        # 해당 해시값을 가진 파일들 찾기
        duplicate_files=$(grep "^$hash" $all_hash_file)
        duplicate_count=$(echo "$duplicate_files" | wc -l | tr -d ' ')
        
        echo "$duplicate_files" | while read line; do
            file_path=$(echo "$line" | cut -d' ' -f2-)
            file_name=$(basename "$file_path")
            
            # 경로에서 정보 추출
            folder_type=""
            room_type=""
            file_type=""
            
            if [[ $file_path == *"/84A/"* ]]; then
                folder_type="84A"
            elif [[ $file_path == *"/84B/"* ]]; then
                folder_type="84B"
            elif [[ $file_path == *"/84C/"* ]]; then
                folder_type="84C"
            fi
            
            if [[ $file_path == *"/bath1/"* ]]; then
                room_type="bath1"
            elif [[ $file_path == *"/bath2/"* ]]; then
                room_type="bath2"
            elif [[ $file_path == *"/bed1/"* ]]; then
                room_type="bed1"
            elif [[ $file_path == *"/bed2/"* ]]; then
                room_type="bed2"
            elif [[ $file_path == *"/bed3/"* ]]; then
                room_type="bed3"
            elif [[ $file_path == *"/kitchen/"* ]]; then
                room_type="kitchen"
            elif [[ $file_path == *"/living/"* ]]; then
                room_type="living"
            elif [[ $file_path == *"/corridor/"* ]]; then
                room_type="corridor"
            elif [[ $file_path == *"/ent/"* ]]; then
                room_type="ent"
            elif [[ $file_path == *"/still/"* ]]; then
                room_type="still"
            fi
            
            if [[ $file_name == *"Air.webp" ]]; then
                file_type="Air"
            elif [[ $file_name == *"Sis.webp" ]]; then
                file_type="Sis"
            elif [[ $file_name == *"Air_n_Sis.webp" ]]; then
                file_type="Air_n_Sis"
            elif [[ $file_name == *"Bath_High.webp" ]]; then
                file_type="Bath_High"
            elif [[ $file_name == *"Door.webp" ]]; then
                file_type="Door"
            elif [[ $file_name == *"Fan.webp" ]]; then
                file_type="Fan"
            elif [[ $file_name == *"Dish.webp" ]]; then
                file_type="Dish"
            elif [[ $file_name == *"Induction.webp" ]]; then
                file_type="Induction"
            elif [[ $file_name == *"Oven.webp" ]]; then
                file_type="Oven"
            elif [[ $file_name == *"Ref2.webp" ]]; then
                file_type="Ref2"
            elif [[ $file_name == *"Ref3.webp" ]]; then
                file_type="Ref3"
            elif [[ $file_name == *"Closet.webp" ]]; then
                file_type="Closet"
            elif [[ $file_name == *"DuctAll.webp" ]]; then
                file_type="DuctAll"
            else
                file_type="기타"
            fi
            
            # CSV 행 추가 (쉼표가 포함된 경우를 위해 따옴표 사용)
            echo "$group_num,\"$hash\",\"$file_name\",\"$file_path\",\"$folder_type\",\"$room_type\",\"$file_type\",$duplicate_count" >> $output_csv
        done
        
        group_num=$((group_num + 1))
    done
fi

rm -f $all_hash_file

echo "=== CSV 리포트 생성 완료 ==="
echo "결과가 $output_csv 에 저장되었습니다."
echo "엑셀에서 열어보세요!"
