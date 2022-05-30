# Colorized app

The training project for creating applications using the UIKit framework.

## Objectives of the project:
- Getting to know the segues and delegates
- Designing the interface with the example of the app
- Learn standard application templates
- Practice with Storyboard

## Technical assignment
![colorized_app.gif](/gifs/colorized_app.gif)

Create an app. with two screens.
The second screen is the settings screen, where you can customize the color for the first screen. When switching to the settings screen in ColorView, you must pass the current color of the main screen.
When you close the settings screen, transfer the color selected in the settings to the main application screen using delegation.
- On this screen you can change the background color by using sliders. The value of each slider should be displayed in the corresponding label. The color of the slider to the left of the runner should correspond to the color for which he is responsible.
- Make text boxes in which you can set the color value from the on-screen keyboard. When calling the keyboard, make it possible to specify the entered values using the button «Done». When you press this button the keyboard must be hidden. Also make it possible to hide the keyboard taping on the screen.
- Slider values should be passed simultaneously to labels and text boxes. The values entered into the text fields must be transmitted simultaneously to sliders and labels. If you enter invalid values, the controller’s alert should be displayed.
