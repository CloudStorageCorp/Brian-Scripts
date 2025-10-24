@echo off
echo Checking NVIDIA ECC Errors...
powershell -Command "nvidia-smi -q | Select-String -Pattern 'ECC Errors' -Context 0,38"
pause