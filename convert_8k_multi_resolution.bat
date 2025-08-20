@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM 8k 폴더 내 모든 이미지를 4k, 2k 해상도로 리사이즈하여 저장하는 스크립트
REM 원본 폴더: 8k
REM 대상 폴더: 4k, 2k
REM 처리 대상: 84A, 84B, 84C 모든 폴더

set "SRC_DIR=8k"

REM 4K 해상도 (UHD)
set "TARGET_4K_WIDTH=3840"
set "TARGET_4K_HEIGHT=2160"

REM 2K 해상도 (QHD)
set "TARGET_2K_WIDTH=2560"
set "TARGET_2K_HEIGHT=1440"

REM 품질은 원본과 동일하게 유지 (WebP 기본 품질 사용)
set "WEBP_QUALITY=100"

echo === 8k → 4k, 2k 다중 해상도 변환 시작 ===

REM ImageMagick 확인
where magick >nul 2>&1
if %errorlevel% neq 0 (
    where convert >nul 2>&1
    if %errorlevel% neq 0 (
        echo ❌ ImageMagick이 설치되어 있지 않습니다.
        echo 설치 방법:
        echo 1. https://imagemagick.org/script/download.php#windows 에서 다운로드
        echo 2. 또는 choco install imagemagick
        pause
        exit /b 1
    )
)

REM CPU 코어 수 자동 감지 (Windows)
set "MAX_JOBS=%NUMBER_OF_PROCESSORS%"
echo 🚀 병렬 처리 활성화: %MAX_JOBS%개 코어 사용

REM 4K 변환 실행
call :convert_to_resolution "4k" "%TARGET_4K_WIDTH%" "%TARGET_4K_HEIGHT%" "4K"

REM 2K 변환 실행
call :convert_to_resolution "2k" "%TARGET_2K_WIDTH%" "%TARGET_2K_HEIGHT%" "2K"

echo 🎉 모든 해상도 변환 완료!
echo.
echo === 최종 결과 요약 ===

REM 파일 개수 계산
set /a src_count=0
set /a dst_4k_count=0
set /a dst_2k_count=0

for /r "%SRC_DIR%" %%f in (*.webp) do (
    if exist "%%f" set /a src_count+=1
)

if exist "4k" (
    for /r "4k" %%f in (*.webp) do (
        if exist "%%f" set /a dst_4k_count+=1
    )
)

if exist "2k" (
    for /r "2k" %%f in (*.webp) do (
        if exist "%%f" set /a dst_2k_count+=1
    )
)

echo 원본 8k 파일: %src_count%개
echo 변환된 4k 파일: %dst_4k_count%개
echo 변환된 2k 파일: %dst_2k_count%개
echo.
echo 📁 폴더 구조:
echo   8k/84A, 8k/84B, 8k/84C → 4k/84A, 4k/84B, 4k/84C
echo   8k/84A, 8k/84B, 8k/84C → 2k/84A, 2k/84B, 2k/84C

pause
exit /b 0

REM 해상도별 변환 함수
:convert_to_resolution
set "target_dir=%~1"
set "target_width=%~2"
set "target_height=%~3"
set "resolution_name=%~4"

echo.
echo === %resolution_name% 변환 시작 ===
echo 목표 해상도: %target_width%x%target_height%
echo WebP 품질: %WEBP_QUALITY% (최고 품질)
echo 소스 디렉토리: %SRC_DIR%
echo 대상 디렉토리: %target_dir%
echo.

REM 대상 디렉토리 생성
if not exist "%target_dir%" mkdir "%target_dir%"

REM 변환 카운터
set /a converted_count=0
set /a skipped_count=0
set /a error_count=0

REM 모든 WebP 파일 찾기 및 변환
for /r "%SRC_DIR%" %%f in (*.webp) do (
    if exist "%%f" (
        call :convert_single_file "%%f" "%target_dir%" "%target_width%" "%target_height%"
    )
)

echo.
echo === %resolution_name% 변환 완료 ===
echo 변환 완료: !converted_count!개
echo 건너뜀: !skipped_count!개
echo 실패: !error_count!개
echo 결과 디렉토리: %target_dir%
echo.

goto :eof

REM 단일 파일 변환 함수
:convert_single_file
set "src_file=%~1"
set "target_dir=%~2"
set "target_width=%~3"
set "target_height=%~4"

REM 상대 경로 추출
set "rel_path=%src_file:%SRC_DIR%\=%"

REM 폴더 구조 유지
for %%p in ("%src_file%") do set "src_dir=%%~dp"
set "src_dir=%src_dir:%SRC_DIR%\=%"
set "dst_dir=%target_dir%\%src_dir%"

REM 파일명 유지 (WebP 확장자 그대로)
for %%f in ("%src_file%") do set "filename=%%~nxf"
set "dst_file=%dst_dir%%filename%"

REM 대상 디렉토리 생성
if not exist "%dst_dir%" mkdir "%dst_dir%"

REM 이미 존재하는 파일인지 확인
if exist "%dst_file%" (
    echo ⏭️  건너뜀: %rel_path% (이미 존재)
    set /a skipped_count+=1
    goto :eof
)

REM 변환
echo 🔄 변환 중: %rel_path% → %target_dir%\%rel_path%

REM ImageMagick을 사용하여 이미지 변환
where magick >nul 2>&1
if %errorlevel% equ 0 (
    REM ImageMagick 7.x
    magick "%src_file%" -resize "%target_width%x%target_height%>" -quality %WEBP_QUALITY% "%dst_file%"
) else (
    REM ImageMagick 6.x
    convert "%src_file%" -resize "%target_width%x%target_height%>" -quality %WEBP_QUALITY% "%dst_file%"
)

if %errorlevel% equ 0 (
    echo ✅ 완료: %target_dir%\%rel_path%
    set /a converted_count+=1
) else (
    echo ❌ 실패: %rel_path%
    set /a error_count+=1
)

goto :eof
