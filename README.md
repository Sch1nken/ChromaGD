This is a Godot Plugin to simulate different types of color blindness in the editor as well as in the game.

The shader code has been adapted from HLSL to Godot (~GLSL) from this recently open sourced Ubisoft project: https://github.com/ubisoft/Chroma

**NOTE:** As a result of this, the shader code is licensed under the Apache 2.0 License used by the Ubisoft project.
(I am not sure if I could license it under MIT since I translated it from HLSL to GLSL, but better safe than sorry).

After installing and enabling the plugin, you should see a new option button next in the top right corner of the editor. This allows you to change the simulation mode for the 2D and 3D viewports.

[![Editor Screenshot](https://raw.githubusercontent.com/Sch1nken/ChromaGD/refs/heads/main/github_images/editor_screenshot.png)

To change the simulation mode in-game the plugin automatically adds a new global autoload scene for you. You can toggle the mode in-game by pressing F4 (currently hardcoded). The current mode will be displayed in the top right corner.
