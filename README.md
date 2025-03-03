
# Flappy Clone - Godot 4.3

A simple **Flappy Bird-inspired** game built with **Godot 4.3** as a **learning project** to explore game development, physics-based movement, and UI handling.

## 🛠 Features
- **Player Movement**: Implemented with `CharacterBody2D` and basic physics (jumping, gravity, and horizontal movement).  
- **Dynamic Enemy Spawning**: Enemies (obstacles) are spawned in **tuples** with configurable gaps.  
- **Score System**: Points are awarded when the player successfully passes through obstacles.  
- **UI Updates**: A signal-based system dynamically updates the score.  
- **Game Loop & Optimization**: Implemented scene cleanup to remove old enemies and prevent memory leaks.

## 🎮 How to Play
- Adds a twist to Flappy Bird, you can now move in each direction using `Arrow Keys`.
- Press `Space` or `Jump` action to make the bird flap.  
- Avoid colliding with enemy hawks.  
- Pass between enemy hawks to earn points!  

## 📦 Installation
1. Clone this repository:
   ```sh
   git clone https://github.com/tarikdemiroren/FlappyHawk.git
   ```
2. Open the project in **Godot 4.3**.  
3. Click **Run** ▶ to start playing!  

## 📖 What I Learned
This project was built to **learn Godot and basic game design concepts**, covering:
- **Physics-based movement** in `CharacterBody2D`.  
- **Signals and event-driven programming** for updating the score dynamically.  
- **Procedural enemy spawning** with customizable gaps.  
- **Scene hierarchy and node management** to improve game structure.  
- **Refactoring** enemy logic for better maintainability.  

## 🚀 Future Improvements
- Add sound effects and background music.  
- Implement difficulty scaling (faster enemies over time).  
- Improve animations and add a death screen.  

## 📝 License
This project is a **personal learning project** and is open-source. Feel free to use and modify it!  

---
🕹 **Built with ❤️ using Godot 4.3**  
