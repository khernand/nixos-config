# 🚀 NixOS Configuration

This repository contains my **NixOS configuration**, utilizing **flakes** and **Home Manager** for a modular and customizable setup.

## 📌 Features
- **🔗 Entrypoint:** [`flake.nix`](./flake.nix)  
- **📁 Dotfiles Integration:** References dotfiles from [`github:khernand/dotfiles`](https://github.com/khernand/dotfiles) for Home Manager profiles.  
- **🔄 Automatic Imports:**  
  - **`imports/core/`** → Loads all `.nix` files in this directory automatically.  
  - **`imports/services/`** → Defines **toggleable system services** such as networking, Bluetooth, and NVIDIA drivers.  
  - **`imports/system-programs/`** → Defines **toggleable system-wide programs** like Docker and 1Password.  
- **🏠 Home Manager Integration:**  
  - **User configurations and applications** are managed in `profiles/`.  
  - **Home Manager profiles** allow easy installation of user-specific programs and settings.  

## ⚙️ Repository Structure
```plaintext
nixos-config/
│── flake.nix                 # Entrypoint defining hosts & imports
│── imports/
│   ├── core/                 # Core system configurations (auto-loaded)
│   ├── services/             # Toggleable system services
│   ├── system-programs/      # Toggleable system-wide programs
│── hosts/
│   ├── desktop/              # Example host configuration
│── profiles/                 # Home Manager user profiles
│── hardware-configuration.nix # System hardware configuration
```

## 🔧 Customization Guide
To adapt this configuration to your own setup:

### 1️⃣ Replace Dotfiles  
   - Update `flake.nix` to reference your own dotfiles repository.

### 2️⃣ Modify User Settings  
   - Update `specialArgs` in `flake.nix` to define:
     - `userName`
     - `userDescription`
     - `networkHostName`

### 3️⃣ Configure a Host  
   - Modify the existing `hosts/desktop/` (making sure to update the hardware configuration) **or**  
   - Create a new host under `hosts/<your-hostname>/`  

## 🚀 Usage
To apply system updates:
```sh
sudo nixos-rebuild switch --flake .
```
To update dependencies:
```sh
nix flake update
```

---

This configuration is **fully modular** and designed for **easy customization**. Feel free to fork and modify it to suit your NixOS setup!
