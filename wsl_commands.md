# WSL - Powershell

## Powershell (Windows terminal)

```shell
[guid]::NewGuid()   # Get a system Id
code (Get-PSReadlineOption).HistorySavePath   # ver historial de comandos
Get-service vmcompute | Restart-Service       # Reiniciar todas las VMs

```

## WSL

```shell
wsl -l -v [-o|-q]   # Listar VMs, estado y version
wsl --status
wsl --terminate <nameVM>
wsl --shutdown      # Apaga los procesos de wsl y las VMs
wsl --update [--web-download]   # Actualizar kernels
wsl -d <nameVM>     # Borrar VM
```

## Referencias

- [Lograr conexiones desde wsl MVs sobre VPNs](https://github.com/sakai135/wsl-vpnkit)
