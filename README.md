
# RaM Setup Guide

## Prerequisites
Ensure that the following tools are installed:
- [Mise](https://github.com/jdx/mise)

## Steps to Run the Project

1. **Install Dependencies with Mise**  
   Run the following command to install the dependencies via Mise:
   ```bash
   mise i
   ```

2. **Install Tuist Dependencies**  
   Install the necessary dependencies for Tuist:
   ```bash
   tuist install
   ```

3. **Generate the Project**  
   Generate the Xcode project with Tuist:
   ```bash
   tuist generate
   ```

After completing these steps, you can open the generated `.xcodeproj` file in Xcode and run the project.

## Project Structure

The project is organized into the following main modules:

- **AppCore**: Contains base functionality and shared components used across all modules.
- **AppUI**: Contains the main UI components and building blocks for the application.
- **App**: The main module responsible for starting the application, coordinating communication between modules, and handling flow coordinators.
- **Features**: This folder contains individual modules for different features of the app:
  - **Characters**: Module for displaying characters.
  - **CharactersDetail**: Module for viewing detailed information about a character.
  - **Favorite**: Module for managing favorite items.
