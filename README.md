# CEN323_G13_RockPaperScissors
# 16-Bit Rock Paper Scissors vs Computer (Display Engine & Logic Matrix)

## Course Project
- **Course:** CEN323 - Computer Organization & Assembly Language (Section 6-A)
- **Instructor:** Sir Adnan
- **Developer:** Sarah Naseer (01-135232-088)

## Overview
This repository contains my core architectural modules for the 16-bit Rock Paper Scissors assembly project designed for `emu8086`. It handles processing the game state values, manipulating the screen workspace layout, and evaluating match outcomes.

## Developed Modules

### 1. Computer Move Display Engine (Part 1)
- Utilizes BIOS video interrupt `INT 10h` with function `AH=02h` to precisely position the terminal cursor at grid coordinates (Row 19, Column 22).
- Dynamically reads the computer's choice variable (`comp`) and routes execution paths using conditional jumps to print strings (`rock`, `paper`, or `scissors`) securely mapped to data memory offsets.

### 2. Match Results Matrix (Part 2)
- Compares player vs. computer inputs utilizing Lecture 9 conditional branching checks (`JE`).
- Directs logic paths to isolate match results into individual operational blocks (`win`, `lose`, or `draw`).
- Sets up clean outcome layout prints at unified grid coordinate boundaries and triggers safe program termination using DOS service termination `INT 21h / AH=4Ch`.

## Assembly Concepts Applied
- **Lecture 6 & 7:** Memory models, data segment layout variables, and direct memory offset addressing (`LEA`).
- **Lecture 9 & 10:** Flag-based conditional branching matrices (`JE`, `CMP`) and unconditional execution routing (`JMP`).
- **Lecture 15:** Direct hardware display interaction using manual BIOS video service controls.
