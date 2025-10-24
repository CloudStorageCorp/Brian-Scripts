selected_disks = [1, 2, 3]  # <-- Data would be fed in from Zhou's software

killdisk_path = r'"C:\Program Files\LSoft Technologies\Active@ KillDisk Ultimate 25\KillDisk.exe"'
base_flags = '-em=25 -v=10 -xd=0 -cp="C:\\Users\\%USERNAME%\\Desktop" -nc'

disk_args = " ".join([f"-eh={disk}" for disk in selected_disks])

full_command = f'{killdisk_path} {base_flags} {disk_args}'

print(full_command)