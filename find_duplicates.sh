#!/bin/bash

# 중복 이미지를 찾는 스크립트
# Air.webp, Sis.webp, Air_n_Sis.webp 파일들의 중복을 확인

echo "=== 중복 이미지 검사 시작 ==="
echo ""

# 결과 파일 생성
output_file="duplicate_images_report.md"
echo "# 중복 이미지 리포트" > $output_file
echo "" >> $output_file
echo "Air.webp, Sis.webp, Air_n_Sis.webp 파일들의 중복 사용을 확인합니다." >> $output_file
echo "" >> $output_file

# 각 타입별로 중복 검사
for pattern in "Air.webp" "Sis.webp" "Air_n_Sis.webp"; do
    echo "## $pattern 파일들" >> $output_file
    echo "" >> $output_file
    
    # 해당 패턴의 파일들을 찾고 MD5 해시 계산
    echo "### 찾은 파일들:" >> $output_file
    files=$(find ./8k -name "*$pattern" -type f)
    
    if [ -z "$files" ]; then
        echo "- 해당 패턴의 파일이 없습니다." >> $output_file
        echo "" >> $output_file
        continue
    fi
    
    # 파일 리스트 출력
    echo "$files" | while read file; do
        echo "- $file" >> $output_file
    done
    echo "" >> $output_file
    
    # MD5 해시로 중복 검사
    echo "### 중복 검사 결과:" >> $output_file
    temp_hash_file=$(mktemp)
    
    echo "$files" | while read file; do
        if [ -f "$file" ]; then
            md5sum "$file" >> $temp_hash_file
        fi
    done
    
    # 중복된 해시값 찾기
    duplicates=$(sort $temp_hash_file | awk '{print $1}' | uniq -d)
    
    if [ -z "$duplicates" ]; then
        echo "- 중복된 파일이 없습니다." >> $output_file
    else
        echo "**중복된 파일들:**" >> $output_file
        echo '```' >> $output_file
        
        # 중복된 파일들의 경로 그룹핑
        echo "$duplicates" | while read hash; do
            echo "" >> $output_file
            echo "**해시값: $hash**" >> $output_file
            grep "^$hash" $temp_hash_file | while read line; do
                file_path=$(echo "$line" | cut -d' ' -f2-)
                file_name=$(basename "$file_path")
                echo "- $file_name → $file_path" >> $output_file
            done
        done
        echo '```' >> $output_file
    fi
    
    rm -f $temp_hash_file
    echo "" >> $output_file
    echo "---" >> $output_file
    echo "" >> $output_file
done

# 전체 파일에서 이름은 다르지만 내용이 같은 파일들 찾기
echo "## 전체 중복 검사 (이름이 다르지만 내용이 같은 파일들)" >> $output_file
echo "" >> $output_file

# 모든 webp 파일의 해시 계산
all_hash_file=$(mktemp)
find ./8k -name "*.webp" -type f -exec md5sum {} + | sort > $all_hash_file

# 중복된 해시값만 추출
duplicated_hashes=$(cut -d' ' -f1 $all_hash_file | uniq -d)

if [ -z "$duplicated_hashes" ]; then
    echo "- 내용이 동일한 중복 파일이 없습니다." >> $output_file
else
    echo "### 내용이 동일한 파일 그룹들:" >> $output_file
    echo "" >> $output_file
    
    echo "$duplicated_hashes" | while read hash; do
        echo "**해시값: $hash**" >> $output_file
        grep "^$hash" $all_hash_file | while read line; do
            file_path=$(echo "$line" | cut -d' ' -f2-)
            file_name=$(basename "$file_path")
            echo "- $file_name → $file_path" >> $output_file
        done
        echo "" >> $output_file
    done
fi

rm -f $all_hash_file

echo "=== 중복 이미지 검사 완료 ==="
echo "결과가 $output_file 에 저장되었습니다."
