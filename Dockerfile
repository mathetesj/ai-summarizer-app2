# 1. 베이스 이미지 선택 (파이썬 3.9)
FROM python:3.9-slim

# 2. 작업 폴더 설정
WORKDIR /app

# 3. Streamlit이 설정 파일을 안전한 곳에 만들도록 환경 변수 지정 (권한 문제 해결)
ENV STREAMLIT_HOME=/app/.streamlit

# 4. 외부 프로그램 설치 (ffmpeg)
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# 5. 현재 폴더의 모든 파일을 작업 폴더로 복사
COPY . .

# 6. requirements.txt에 있는 파이썬 라이브러리 설치
RUN pip install --no-cache-dir -r requirements.txt

# 7. 앱이 사용할 포트를 서버에 알려주기
EXPOSE 7860

# 8. 앱 실행 명령어
CMD ["streamlit", "run", "app.py", "--server.port=7860"]

