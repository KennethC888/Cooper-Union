[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/XC_j3CKm)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=17982577&assignment_repo_type=AssignmentRepo)
# Verilog Project Template

## To compile:

### On Unix (MacOS and Linux)
```bash
make COMPONENT=example_module compile
```
### On Windows (with Chocolatey installed)
```powershell
.\makefile.ps1 example_module compile
```

## To simulate:
### On Unix (MacOS and Linux)
```bash
make COMPONENT=example_module simulate
```
### On Windows (with Chocolatey installed)
```powershell
.\makefile.ps1 example_module simulate
```


## To display simulation using GTKWAVE:
### On Unix (MacOS and Linux)
```bash
make COMPONENT=example_module display
```
### On Windows (with Chocolatey installed)
```powershell
.\makefile.ps1 example_module display
```


Then choose "example_tb" as your SST. Highlight "uut" and choose all signals, dragging them to Signal area to right. Once done, got to menu Time -> Zoom -> Zoom Bet Fit.


## To clean up all generated files:
### On Unix (MacOS and Linux)
```bash
make COMPONENT=example_module clean
```
### On Windows (with Chocolatey installed)
```powershell
.\makefile.ps1 example_module clean
```