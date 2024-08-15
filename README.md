# Dockerized Flask App

![image](https://github.com/user-attachments/assets/ace68ce9-5dc0-42e0-9e7e-f56229c91de0)

Bu proje, Flask ile geliştirilmiş bir web uygulamasını Docker container'ı içinde çalıştırmayı amaçlamaktadır. Flask, Python tabanlı bir mikro web çatısıdır ve bu proje, temel bir Flask uygulamasını Docker kullanarak nasıl paketleyip çalıştırabileceğinizi gösterir. Docker, uygulamaların her ortamda aynı şekilde çalışmasını sağlayan bir konteyner platformudur. Bu proje, Flask uygulamanızı Docker ile izole bir ortamda çalıştırarak, geliştirme ve dağıtım süreçlerini kolaylaştırmayı hedeflemektedir. Flask ve Docker'ı bir arada kullanarak, web projelerinizi daha taşınabilir ve yönetilebilir hale getirebilirsiniz.


## Docker Kurulum

İlk önce sunucumuzdaki paketleri güncelliyoruz:

```
sudo apt update && apt upgrade -y
```

Güncelledikten sonra aşağıda iletmiş olduğum komutları sırayla yazınız:

```
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
```
```
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.as
```
```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
```
sudo apt-get update
```
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Flask Ortamını Hazırlamak

İlk öncelikle bir tane `Dockerfile` oluşturuyoruz.

```
FROM python:3.9
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "app.py"]
```

`pythonapp` adlı bir dizin  oluşturabilirsiniz karışıklık olmamasına adına.

```
mkdir -p pythonapp
```

`app.py` adlı bir dosya oluşturup aşağıdaki gibi dolduruyoruz:

```
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, Flask is running in a Docker container!"

if __name__ == '__main__':
    app.run(host='0.0.0.0')

```

`requirements.txt` adlı bir dosya oluşturup aşağıdaki gibi dolduruyoruz:

```
Flask==2.0.2
Werkzeug==2.0.3
```

## Flask Uygulamasını Çalıştırmak

Flask uygulaması için Docker image'ını oluşturmamız gerekiyor. Aşağıdaki komutu yazıyoruz:

```
docker build -t flask-app .
```

Docker image'ını oluşturduktan sonra, container'ını aşağıdaki komutla çalıştırıyoruz:

```
docker run -d -p 5000:5000 flask-app
```

```
root@ip-172-31-43-64:~/pythonapp# docker ps
CONTAINER ID   IMAGE       COMMAND           CREATED          STATUS          PORTS                                       NAMES
f56ff4943d2a   flask-app   "python app.py"   17 minutes ago   Up 15 minutes   0.0.0.0:5000->5000/tcp, :::5000->5000/tcp   gifted_gates
root@ip-172-31-43-64:~/pythonapp# 
```

Containerimiz çalışıyor.

## HaProxy ile Dışarıya Açıyoruz

HaProxy servisi ile bunu dışarıya açıyoruz. `nano /etc/haproxy/haproxy.cfg` dosyasını aşağıdaki gibi dolduruyoruz:

```
global
    log /dev/log    local0
    log /dev/log    local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

defaults
    log     global
    option  redispatch
    option  dontlognull
    timeout connect 5000
    timeout client  50000
    timeout server  50000

frontend http_front
    bind *:80
    default_backend flask_backend

backend flask_backend
    server flask_app 172.17.0.2:5000 check
```

HaProxy servisini yeniden başlatıyoruz ve IP adresimizi tarayıcıya yazarak uygulamamızı görüntüleyebiliyoruz.

![image](https://github.com/user-attachments/assets/f7db2627-361c-4ee9-a30c-32cfaf4dfff5)




-----------------------------

Okuduğunuz için teşekkürler.










