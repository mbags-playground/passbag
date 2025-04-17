# Passbag

_A Cross-Platform Password Strengthening Tool_

## 🚀 Purpose

Passbag transforms weak, easy-to-remember passwords into strong, consistent passwords using cryptographic methods. It allows you to reliably regenerate the same secure password anytime, without needing to store it.

---

## 💡 Motivation

Traditional password managers often generate random, complex passwords that are hard to remember and reproduce without syncing tools. **passbag** offers a user-friendly alternative:

- Enter two memorable "seed" passwords
- Combine them using a deterministic algorithm
- Generate a strong password that you can always recreate

This method allows you to:

- Avoid password fatigue
- Maintain strong security hygiene
- Stay in control of your credentials

---

## 🔐 How It Works

**Current Implementation:**

- **HMAC-SHA256** (via `cryptoHmacSha256`): A secure and widely trusted hashing algorithm
- **Base64 Encoding**: Converts hashed output into a readable format

### Example Flow:

1. User enters two weak passwords: `pass1` and `pass2`
2. The tool computes `HMAC_SHA256(pass1, pass2)` using Dart's `cryptoHmacSha256`
3. The result is base64-encoded
4. Output is a strong, deterministic password

> The same input pair always produces the same secure output.

---

## ✅ Features

- 🔁 Reproducible strong passwords
- 🧠 Works with memorable inputs
- 🌍 Cross-platform (Flutter: mobile, web, and desktop)
- 🗃️ No password storage required
- 📶 Works offline

---

## 📅 Roadmap & Future Plans

### 🔄 Algorithm Flexibility

- [ ] Support additional hash algorithms (SHA3, BLAKE2, etc.)
- [ ] Allow custom encoding options (hex, base64url, etc.)
- [ ] Add salt/pepper configurations for advanced users

### 🧬 Biometric Integration

- [ ] Enable **fingerprint or face ID** as a third input
  - Biometric hash included in final password generation
  - Deterministic per device or stored key
  - Useful for added security without sacrificing usability

### 📱 Platform Support (All via Flutter)

- [ ] **Mobile apps**: Android & iOS
- [ ] **Web app**: PWA with offline support
- [ ] **Desktop app**: Windows, macOS, and Linux (built using Flutter)

### 🧩 Advanced Customization

- [ ] Output formatting options:
  - Custom password length (e.g. 12, 16, 20+ characters)
  - Define character sets (symbols, upper/lowercase, digits, etc.)
  - Choose from different output styles (secure hash, passphrase, PIN)
- [ ] Masked mode to hide password on screen

### 🔐 Custom Output & Encryption Options

- [ ] Ability to define a password schema:
  - e.g. "16 characters: 4 digits, 4 uppercase, 4 symbols, 4 lowercase"
- [ ] Option to encrypt the generated password:
  - With a user-provided passphrase or key
  - Useful for secure sharing or device-specific protection
- [ ] Output encryption options:
  - AES-based encryption with user seed
  - One-time encryption with QR export
  - Encrypted backups of input/output pairs (optional and opt-in only)

### 🛡️ Enhanced Security

- [ ] Optional local encryption for input history (if stored)
- [ ] Integration with vetted crypto libraries (like libsodium)
- [ ] Cryptographic audit and pen-testing support

### 🧪 Testing & Usability

- [ ] Fuzz tests and unit testing for hashing module
- [ ] A/B testing for UX improvements
- [ ] Full accessibility support (screen readers, keyboard-only nav, etc.)

---

## 🧠 Inspired By

A need for secure but memorable passwords, especially when switching devices, working offline, or avoiding over-dependence on cloud-based password managers.

---

## 🛠️ Installation

Coming soon:

- Web demo
- Android APK & iOS TestFlight
- Desktop builds (macOS, Windows, Linux)

---

## 🤝 Contributing

Want to help make passbag better?

We're looking for:

- Flutter developers (mobile, web, desktop)
- Cryptography and security experts
- UI/UX designers and testers
