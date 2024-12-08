# Define la ruta del backup y la fecha
$fecha = Get-Date -Format "yyyy-MM-dd"
$backupPath = "D:\UNI08\Source\CINT1\PF\CINT1_PF\backup\backup_$fecha.sql"

# Ejecuta el comando mysqldump (sin solicitar contraseña)
& mysqldump -u root --password= sb_db > $backupPath

# Mensaje de confirmación
Write-Host "Backup completado: $backupPath"
