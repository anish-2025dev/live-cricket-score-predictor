```markdown
# 🏏 Live Cricket Score CLI (C++)

A command-line application that fetches **live cricket match data** using the [CricAPI](https://www.cricapi.com/) and displays team names, match status, and innings scores using:

- `libcurl` for making HTTP requests
- `nlohmann/json` for parsing JSON responses

---

## 📂 Project Structure

```

.
├── main.cpp        # Main source file
├── json.hpp        # Header for nlohmann::json
├── Makefile        # Optional build helper
├── shell.nix       # Nix development environment (optional)
└── README.md       # This file

````

---

## 🛠️ Requirements

You’ll need:

- C++ compiler (GCC/Clang)
- `libcurl` development libraries
- `nlohmann/json` header-only library (`json.hpp`)
- Internet connection (to call the API)

---

## ⚙️ Setup Instructions

### 1. Install Dependencies

#### Option 1: Using apt (Debian/Ubuntu)

```bash
sudo apt update
sudo apt install g++ curl libcurl4-openssl-dev
````

Download `json.hpp` from [https://github.com/nlohmann/json/releases](https://github.com/nlohmann/json/releases) and place it in the project directory.

#### Option 2: Using Nix

If you're using Nix, the provided `shell.nix` sets up the dev environment:

```bash
nix-shell
```

### 2. Build the Project

```bash
g++ main.cpp -o live_score -lcurl
```

### 3. Run the Program

```bash
./live_score
```

You’ll get output like:

```
=== Live Cricket Matches ===

India vs Australia (odi)
Status: India won by 3 wickets
India Inning 1: 289/7 (48.5 overs)
Australia Inning 1: 287/8 (50 overs)
---
```

---

## 🔑 API Key Setup

This app uses [CricAPI](https://www.cricapi.com/). You must generate your own API key and replace it in `main.cpp`:

```cpp
string apiKey = "your-api-key-here";
```

---

## 💡 What You Will Learn

* How to perform **HTTP requests** in C++ using `libcurl`
* How to parse **JSON** using `nlohmann/json`
* How to handle **API response errors** and edge cases
* How to build **real-world C++ command-line tools**
* How to extract structured data from live APIs

---

## 🚀 Possible Enhancements

* Auto-refresh match data every minute
* Add CLI filters for team/country
* Export scores to a CSV or file
* Package the tool for easier distribution (e.g., `.deb`)
* Create a GUI version using ncurses or Qt

---

## 📄 License

This project is intended for educational and personal use. Please review CricAPI's terms for any production usage.

---

Made with ❤️ in C++

```

Let me know if you want this as a downloadable `.md` file.
```
