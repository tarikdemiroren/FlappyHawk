
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

1. **Download the appropriate version** from the **Releases** tab.  
2. **Decompress and open the folder** based on your platform:  
   - **Windows**: Double-click the `.exe` file to launch the game.  
   - **Web Version**:  
     1. Run the `serve.py` script in the directory containing the HTML file:  
        ```sh
        python3 serve.py --root ./
        ```  
     2. Open `debug_build.html` in your browser.  
3. **Enjoy the game!** 🎮  


## 📖 What I Learned
This project was built to **learn Godot and basic game design concepts**, covering:
- **Physics-based movement** in `CharacterBody2D`.  
- **Signals and event-driven programming** for updating the score dynamically.  
- **Procedural enemy spawning** with customizable gaps.  
- **Scene hierarchy and node management** to improve game structure.  
- **Refactoring** enemy logic for better maintainability.  

## 🚀 Future Improvements
- [x] Add items for the player to pick up.
- [x] Add sound effects and background music.  
- [ ] Implement difficulty scaling.  
- [x] Add a death screen.  

## 📝 License
This project is a **personal learning project** and is open-source. Feel free to use and modify it!  

---
🕹 **Built with ❤️ using Godot 4.3**  
