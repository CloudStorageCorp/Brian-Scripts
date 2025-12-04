@echo off
echo Checking NVIDIA ECC Errors...
powershell -Command "nvidia-smi -q -d ECC"

pause
