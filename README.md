# 🧠 Typing Master Game (MIPS Assembly)

Welcome to **Typing Master**, a simple terminal-based game built using **MIPS Assembly language**. This game tests your typing speed and accuracy by offering randomly selected sentences to type in either **Easy** or **Hard** mode. It calculates the typing speed in **characters per second** based on user input and elapsed time.

---

## 📌 Features

* 🖥 Terminal interface with user prompts
* 🎮 Two difficulty levels:

  * **Easy**: Short, beginner-friendly sentences
  * **Hard**: Long and complex quotes for advanced typists
* ⏱️ Real-time typing speed calculation
* 🔁 Retry on incorrect input or invalid time
* ❌ Exit anytime or restart the game

---

## 🛠 Requirements

To run this program, you’ll need a **MIPS simulator** such as:

* MARS45

---

## ▶️ How to Run

1. Open the `.asm` file in your preferred MIPS simulator (e.g., QtSPIM or MARS).
2. Assemble and run the program.
3. Follow the on-screen instructions:

   * Choose a difficulty level
   * Type the displayed sentence accurately
   * View your typing speed in characters per second

---

## 🎯 Game Flow

```
1. Welcome Screen
2. Choose Difficulty:
    0 - Restart
    1 - Easy Mode
    2 - Hard Mode
    3 - Exit

3. A random sentence is displayed.
4. Type the sentence as accurately as possible.
5. If correct:
    - Shows time taken
    - Shows characters typed
    - Shows typing speed (CPS)

6. If incorrect:
    - You get the option to retry or exit.
```

---

## 📂 Code Structure

* `.data` section: Contains all prompts, strings, and buffers
* `main`: Displays welcome message and handles user flow
* `easyLevel` and `hardLevel`: Core logic for both difficulty modes
* Real-time comparison of input and output strings
* Typing speed calculated as:

  ```
  Characters per second = Total characters typed / Time (in seconds)
  ```

---

## 🧪 Sample Sentences

### Easy Mode:

* “The fox jumps over lazy dog.”
* “Typing is fun and easy.”
* “They don't know me son!”

### Hard Mode:

* “Success is not final, failure is not fatal: It is the courage to continue that counts.”
* “The only limit to our realization of tomorrow is our doubts of today.”

---

## 📌 Notes

* The game uses syscall `30` to measure elapsed time in milliseconds.
* A minimum time of **1 second** is required to calculate speed accurately.
* String comparison is done character by character.

---

## 📸 Screenshot (Example)

```
Welcome to the Typing Master Game.
Choose any difficulty level to Start:
0. Start again
1. Easy mode
2. Hard mode
3. Exit

> 1

You have entered the easy mode.

Write the below string:

Typing is fun and easy.

> Typing is fun and easy.

You completed it in (seconds): 4
You typed (Characters count): 24
Your typing speed is (Characters Per Second): 6
```
