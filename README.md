# 🌫️ Air Quality Monitoring System (Proteus Simulation)

This is a Proteus-based simulation project for an **Air Quality Monitoring System**, utilizing a **PIC16F877 microcontroller**. The system reads environmental parameters such as gas concentration and temperature and simulates visual and audio alerts.

## 🎯 Objective

Simulate an embedded system that:
- Monitors air quality using the **MQ-2 Gas Sensor** and **LM35 Temperature Sensor**
- Displays data on an **LM044L LCD**
- Activates visual (LED) and audio (buzzer) alerts based on thresholds

---

## 🧰 Components Used (Proteus Library)

| Component          | Purpose                                      |
|-------------------|----------------------------------------------|
| **BUTTON**         | User input (e.g., to simulate reset or test) |
| **BUZZER**         | Audio alert for dangerous gas levels         |
| **HCH-1000**       | Simulates humidity sensing (optional)        |
| **LED-GREEN**      | Safe condition indicator                     |
| **LED-RED**        | Danger alert indicator                       |
| **LM35**           | Temperature sensor                           |
| **LM044L**         | 16x2 LCD for displaying values               |
| **LOGICSTATE**     | Simulate digital logic sensor output         |
| **MQ-2 GAS SENSOR**| Detects LPG, smoke, methane, etc.            |
| **PIC16F877**      | Microcontroller (central logic unit)         |
| **PNP**            | Transistor for control logic (optional)      |
| **RES**            | Resistors for signal conditioning            |

---

## 📂 Project Structure

Air-quality-monitoring-system/
├── Simulation/ # Proteus .pdsprj file (main simulation circuit)
├── Code/ # Source code for PIC16F877 (MPLAB or MikroC)
└── README.md

---

## ⚙️ Requirements

To run and test this simulation, you’ll need:

- [Proteus 8 Professional](https://www.labcenter.com/downloads/)
- [MPLAB X IDE](https://www.microchip.com/en-us/tools-resources/develop/mplab-x-ide) or [MikroC PRO for PIC](https://www.mikroe.com/mikroc/pic)
- **XC8 Compiler** or MikroC Compiler
- A basic understanding of:
  - Embedded C programming
  - Digital electronics and microcontroller interfacing

PS: If you can't find the MQ-2 Gas Sensor then follow this link https://github.com/albaloshi1996/Proteus-Libraries-

---

## 🚀 How to Run the Simulation

### 1. Compile the PIC Code

- Use **MPLAB X**, **MikroC PRO for PIC**, or any suitable IDE.
- Write your embedded C code to read sensors and control outputs.
- Compile the code and generate a `.hex` file.

### 2. Open in Proteus

- Navigate to the `Simulation/` folder.
- Open the `.pdsprj` file in **Proteus 8 Professional**.
- Double-click on the **PIC16F877** microcontroller.
- Load your compiled `.hex` file.
- Click the **Run Simulation** button.

---

## 🖥️ System Behavior

- **LCD** displays real-time:
  - Gas level
  - Temperature (°C)
- **Red LED** and **buzzer** activate when gas level exceeds the safe threshold.
- **Green LED** stays on when air quality is safe.
- Button or logic inputs can simulate dynamic changes in sensor output.

---


## 🔮 Possible Enhancements

- Add UART communication to send data to a serial terminal
- Log data to EEPROM or SD card
- Add real-time clock (RTC) module for timestamps
- Replace PIC with Arduino for easier IoT integration

---

## 👨‍💻 Author

**Youssef Baizig**  
[GitHub Profile](https://github.com/YoussefBaizig)

---

## 📄 License

This project is licensed under the **MIT License**.  
Feel free to modify and use it for educational purposes.