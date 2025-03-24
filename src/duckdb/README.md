# **Hướng Dẫn Cài Đặt Git Trên Ubuntu**

### Bước 1: Cài git

`sudo apt install git -y`

> Nếu bị lỗi
>
> ```
> E: Could not get lock /var/lib/dpkg/lock-frontend - open (11: Resource temporarily unavailable)
> E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), is another process using it?
> ```
>
> thì dùng cặp câu lệnh
>
> ```
> sudo rm -f /var/lib/dpkg/lock
> sudo rm -f /var/lib/dpkg/lock-frontend
> ```

### Bước 2: Cấp quyền cho các file

> ```
> chmod a+x [Đường dẫn file shell]
> ```

### Bước 3: Chạy script

> ```
> ./[Đường dẫn file shell]
> ```
