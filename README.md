![Not_enough](https://github.com/roma-sh/Inception/img/not_enough.png)

## Table of Contents
1. [Introduction](#-inception-project--escape-the-dependency-dungeon)
2. [Note](#-note)
3. [How to Run](#-how-to-run)
4. [What is Docker?](#-what-is-docker)
5. [What is NGINX?](#-what-is-nginx)
6. [What is an SSL Certificate?](#-what-is-an-ssl-certificate--why-do-we-need-it)
7. [What is MariaDB?](#-what-is-mariadb)
8. [What is WordPress?](#-what-is-wordpress)
9. [Purpose](#-purpose)
10. [Project requirements](#-project-requirements)

# 🐳 Inception Project – Escape the Dependency Dungeon!

Ever tried to run someone else’s project and suddenly found yourself installing 42 versions of Python, 13 obscure libraries, and a cursed package that hasn’t been updated since 2003? Welcome to dependency hell 🔥.

But wait... there's hope! What if you could ship your project inside a small, self-contained box where everything *just works*? No more “but it works on my machine!” excuses. That’s the magic of **containerization** – and why **Docker** was invented.

---
## 📝 Note:

1. **Please add your own values to the `.env` file**
![Not_enough](https://github.com/roma-sh/Inception/img/env.png)

2. **You can modify the storage location** by changing the path for volumes in the `docker-compose.yml` file
![Not_enough](https://github.com/roma-sh/Inception/img/path.png)

3. you can chnage the Domain by setting it in the env file.
---
## 🚀 How to Run:

1. In the terminal cd to the root directory.
2. Enter:
``` bash
make all
```
3. Wait until all containers are built and running
4. Open your browser to this link: https://127.0.0.1
5. Set up your WordPress account
6. Have fun and modify as much as you like! 😄🎨

---

Not familiar with Docker, Nginx, WordPress?? No worries:

![Not_enough](https://github.com/roma-sh/Inception/img/docker.png)


## 🐋 What is Docker?

Docker is like a magical suitcase: you pack your entire application with all its dependencies into it, and it will run *exactly* the same no matter where you open it. Whether it's your laptop, a server, or your grandma’s Linux machine – if Docker runs, your app runs.

Docker uses **containers**, which are lightweight, isolated environments. They're faster and more efficient than virtual machines and are the foundation of this project.

---

## 🌐 What is NGINX?

NGINX (pronounced "engine-x") is a high-performance web server. It handles:

- HTTP requests
- Load balancing
- Reverse proxying
- SSL termination

In our project, NGINX is the entry point. It receives all requests on port 443 (HTTPS), handles SSL encryption, and passes the requests to the appropriate container (like WordPress).

---

## 🔒 What is an SSL Certificate & Why Do We Need It?

SSL (Secure Sockets Layer) encrypts the data sent between your browser and the server, preventing hackers from stealing sensitive information. Without SSL:

- Browsers will show "Not Secure" warnings 🚨
- Data (like passwords) can be intercepted
- Google might drop you in search rankings 😢

That’s why we configure NGINX to support **only** secure protocols: TLSv1.2 or TLSv1.3.

---

## 🐬 What is MariaDB?

MariaDB is an open-source, drop-in replacement for MySQL. It's responsible for:

- Storing and retrieving all WordPress data
- Managing user info, posts, settings, etc.
- Using SQL (Structured Query Language) to interact with the data

In this project, MariaDB lives in its own container and connects with WordPress through a shared Docker network.

---
## 📝 What is WordPress?

WordPress is the most popular content management system (CMS) in the world. It allows users to easily build and manage websites without needing to write any code.

In this project:

- WordPress runs inside its own container
- It connects to the MariaDB container to store data
- You’ll use the WordPress web interface to create posts, pages, and manage your site like a pro 🧑‍💻

---

## 📦 Project Overview

### 🎯 Purpose

The goal of this project is to build a lightweight web infrastructure using **Docker**, where each service (NGINX, WordPress, MariaDB) lives in its own isolated container.

You'll build everything yourself using **Dockerfiles**, without relying on pre-made images. It's an excellent way to learn system administration, containerization, and networking.

---

## 📋 Project requirements

- Run inside a Virtual Machine (no bare metal!)
- Use **Docker Compose** to orchestrate everything
- Each service has its own container
- Use either Alpine or Debian as base OS
- Write your own Dockerfiles (no ready-made images!)
- Configure:
  - **NGINX** with SSL (TLSv1.2/1.3 only)
  - **WordPress** with PHP-FPM (no nginx)
  - **MariaDB** with persistent volume
- Use environment variables (via `.env`)
- Set up Docker volumes for:
  - WordPress files
  - WordPress database
- Connect containers using a Docker network
- Handle automatic restarts
- No infinite loops (like `tail -f`, `sleep infinity`, etc.)
- No `host` networking or deprecated linking options
- No "admin" in WordPress admin username
- Use secrets or env vars for credentials (never in plain Dockerfiles!)
- Everything behind HTTPS (`https://127.0.0.1`)

