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




