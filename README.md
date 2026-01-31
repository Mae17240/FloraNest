# 🌿 FloraNest

**FloraNest** is an iOS mobile application that uses on-device machine learning to identify plant species in real time. The app enables users to scan plants, store their discoveries, and explore plants found in their local area — all with full offline functionality.

> 🎓 Developed as a **BSc (Hons) Computer Science Dissertation Project**  
> **Final Grade:** 70.1%

---

## App Overview

FloraNest combines **computer vision**, **CoreML**, and **location services** to deliver an intelligent and accessible plant identification experience. The system is designed for speed, privacy, and offline usability, making it suitable for outdoor and remote environments.

---

## Features

### Plant Identification
- Real-time plant scanning using the device camera  
- Identification of **200 indoor and outdoor plant species**  
- Fast on-device inference  
- No internet connection required for recognition  

### CoreML Machine Learning Model
- Custom-trained **CoreML model** embedded within the app  
- Fully **offline AI processing**  
- Optimized for mobile performance and low latency  
- Designed to differentiate visually similar plant species  

### Account System
- User account creation and management  
- Personal plant collection storage  
- Persistent user data  
- Secure credential handling via **iOS Keychain**  

### Map Integration
- Location-based plant discovery  
- View plants identified within the user's local area  
- Map API integration for geographic visualization  

---

## 🏗 System Architecture

| Component        | Description |
|------------------|------------|
| **iOS Application** | Swift-based mobile interface |
| **CoreML Model** | Embedded model for plant classification |
| **Camera Module** | Captures real-time images for inference |
| **Local Storage** | Stores plant data and user information |
| **Keychain** | Secure storage for authentication data |
| **Map API** | Displays geographically tagged plant data |

---

## Offline Capability

A core design goal of FloraNest is accessibility. The embedded CoreML model allows plant identification to function **without internet access**, ensuring the application remains usable in outdoor and low-connectivity environments.

---

## Project Objectives

- Deliver accurate mobile plant recognition  
- Provide secure personal plant tracking  
- Enable offline AI-powered functionality  
- Integrate environmental awareness via location-based mapping  

---

## Future Enhancements

- Expansion beyond 200 plant species  
- Cloud synchronization across devices  
- Plant care guidance and reminders  
- Disease detection and plant health analysis  
- Community-based plant sharing features  

---


