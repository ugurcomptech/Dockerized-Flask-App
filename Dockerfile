# Base image olarak Python'ı kullan
FROM python:3.9

# Çalışma dizinini ayarla
WORKDIR /app

# Gereksinim dosyalarını kopyala
COPY requirements.txt requirements.txt

# Gereksinimleri yükle
RUN pip install -r requirements.txt

# Uygulama dosyalarını kopyala
COPY . .

# Uygulamayı çalıştır
CMD ["python", "app.py"]
