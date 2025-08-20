@echo off
chcp 65001 >nul
echo 🖼️ 이미지 2K WebP 변환 작업 시작

REM 작업 디렉토리 설정
set "WORK_DIR=C:\yjgoh\img-clone\temp"
set "WEBP_OUTPUT_DIR=%WORK_DIR%\webp_2k"

REM 작업 디렉토리로 이동
if not exist "%WORK_DIR%" (
    echo ❌ 작업 디렉토리가 존재하지 않습니다: %WORK_DIR%
    echo 📁 디렉토리를 생성합니다...
    mkdir "%WORK_DIR%"
)

cd /d "%WORK_DIR%"
echo 현재 위치: %CD%
echo WebP 출력 디렉토리: %WEBP_OUTPUT_DIR%

REM webp 출력 디렉토리 생성
if not exist "%WEBP_OUTPUT_DIR%" (
    echo 📁 WebP 출력 디렉토리 생성: %WEBP_OUTPUT_DIR%
    mkdir "%WEBP_OUTPUT_DIR%"
)

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

REM 2K 해상도 설정
set "TARGET_WIDTH=2560"
set "TARGET_HEIGHT=1440"
set "WEBP_QUALITY=90"

echo.
echo === 설정 정보 ===
echo 목표 해상도: %TARGET_WIDTH%x%TARGET_HEIGHT% (2K)
echo WebP 품질: %WEBP_QUALITY%
echo 작업 디렉토리: %WORK_DIR%
echo WebP 출력 디렉토리: %WEBP_OUTPUT_DIR%
echo.

REM 변환 카운터 초기화
set /a converted_count=0
set /a skipped_count=0
set /a error_count=0

REM 모든 이미지 파일 찾기 및 변환
for /r "%WORK_DIR%" %%f in (*.jpg *.jpeg *.png *.tiff *.tif *.bmp *.webp) do (
    if exist "%%f" (
        call :convert_image "%%f"
    )
)

echo.
echo 🎨 이미지 변환 작업 완료
echo.
echo === 결과 요약 ===
echo ✅ 변환 완료: %converted_count%개
echo ⏭️  건너뜀: %skipped_count%개
echo ❌ 실패: %error_count%개
set /a total_count=%converted_count%+%skipped_count%+%error_count%
echo 📊 총 처리: %total_count%개

if %error_count% gtr 0 (
    echo.
    echo ⚠️  일부 파일 변환에 실패했습니다. 로그를 확인해주세요.
)

echo.
echo 🎯 2K WebP 변환 작업이 완료되었습니다!
pause
exit /b 0

:convert_image
set "src_file=%~1"
set "rel_path=%src_file:%WORK_DIR%\=%"
set "output_dir=%WEBP_OUTPUT_DIR%\%~dp1"
set "output_dir=%output_dir:%WORK_DIR%\=%"
set "output_dir=%WEBP_OUTPUT_DIR%\%output_dir%"
set "base_name=%~n1"
set "output_file=%output_dir%\%base_name%.webp"

REM 출력 디렉토리 생성
if not exist "%output_dir%" (
    mkdir "%output_dir%"
)

@REM REM 이미 WebP 파일이 존재하는지 확인
@REM if exist "%output_file%" (
@REM     echo ⏭️  건너뜀: %base_name%.webp (이미 존재)
@REM     set /a skipped_count+=1
@REM     goto :eof
@REM )

echo 🔄 변환 중: %rel_path% → webp\%rel_path:.webp=%\%base_name%.webp

REM ImageMagick을 사용하여 이미지 변환
where magick >nul 2>&1
if %errorlevel% equ 0 (
    REM ImageMagick 7.x
    magick "%src_file%" -resize "%TARGET_WIDTH%x%TARGET_HEIGHT%>" -quality %WEBP_QUALITY% -define webp:lossless=false -define webp:alpha-quality=100 "%output_file%"
) else (
    REM ImageMagick 6.x
    convert "%src_file%" -resize "%TARGET_WIDTH%x%TARGET_HEIGHT%>" -quality %WEBP_QUALITY% -define webp:lossless=false -define webp:alpha-quality=100 "%output_file%"
)

if %errorlevel% equ 0 (
    echo ✅ 성공: webp\%rel_path:.webp=%\%base_name%.webp
    set /a converted_count+=1
) else (
    echo ❌ 실패: %rel_path%
    set /a error_count+=1
)

goto :eof
