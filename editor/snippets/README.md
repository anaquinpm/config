# Snippets - Reutilización de Texto en Vim

Esta carpeta contiene **archivos de texto reutilizable** que puedes insertar rápidamente en Vim sin necesidad de plugins de snippets.

## ¿Qué es esto?

En lugar de escribir cabeceras, boilerplate, o bloques de código repetitivos manualmente, puedes almacenarlos aquí y insertarlos directamente en Vim.

**Ejemplo:**
- `header` → Cabecera estándar para scripts bash/terraform
- Puedes crear más: `python_header`, `yaml_template`, etc.

## Cómo usar en Vim

### Método 1: Comando `:read` (más simple)

Ubícate en la línea donde quieres insertar el contenido y ejecuta:

```vim
:read /Users/anakin/dev/config/editor/snippets/header
```

O si usas rutas relativas desde home:

```vim
:read ~/.config/vim/snippets/header
```

El contenido se insertará **debajo de la línea actual**.

### Método 2: Atajo de teclado (recomendado)

Agrega esto a tu `.vimrc` o `init.lua` para usar un atajo:

**Para `vimrc`:**
```vim
" Insertar snippet header rápidamente
nnoremap <leader>h :read ~/.config/vim/snippets/header<CR>

" Insertar otros snippets
nnoremap <leader>py :read ~/.config/vim/snippets/python_header<CR>
nnoremap <leader>tf :read ~/.config/vim/snippets/terraform_template<CR>
```

**Para `init.lua` (Neovim):**
```lua
-- Insertar snippets con atajos
vim.keymap.set("n", "<leader>h", ":read ~/.config/vim/snippets/header<CR>")
vim.keymap.set("n", "<leader>py", ":read ~/.config/vim/snippets/python_header<CR>")
vim.keymap.set("n", "<leader>tf", ":read ~/.config/vim/snippets/terraform_template<CR>")
```

### Método 3: Modo Insert (desde dentro de insert)

Mientras editas en modo insert, puedes insertar un snippet:

```vim
Ctrl-x Ctrl-r  → Abre un menú para seleccionar archivos
```

O simplemente interrumpe la inserción, usa `:read`, y vuelve al modo insert.

## Estructura recomendada

```
snippets/
├── README.md                  # Este archivo
├── header                     # Cabecera estándar
├── python_header              # Cabecera con docstring
├── bash_header                # Shebang + set -e
├── terraform_template         # HCL template básico
├── kubernetes_manifests       # Pod, Deployment template
└── docker_template            # Dockerfile boilerplate
```

## Ejemplo: Crear un nuevo snippet

1. Crea el archivo:
```bash
cat > ~/.config/vim/snippets/bash_header << 'EOF'
#!/bin/bash
set -euo pipefail

# Script: $(basename $0)
# Description: 

main() {
    echo "Starting..."
}

main "$@"
EOF
```

2. Usa en Vim:
```vim
nnoremap <leader>sh :read ~/.config/vim/snippets/bash_header<CR>
```

3. Presiona `<leader>sh` en una archivo nuevo y listo!

## Ventajas de este enfoque

✅ **Sin dependencias** - Solo Vim puro, funciona en cualquier máquina  
✅ **Control total** - Editas los snippets como archivos normales  
✅ **Multiplataforma** - Funciona igual en Linux, macOS, Windows  
✅ **Rápido** - Inserción instantánea sin complejidad de plugins  
✅ **Versionable** - Los snippets están en Git, sincronizados en todas tus máquinas  

## Roadmap de snippets

- [x] `header` → Cabecera estándar
- [x] `python_header` → Script Python con shebang
- [x] `bash_header` → Script Bash robusto
- [x] `terraform_template` → Estructura básica HCL
- [x] `dockerfile_template` → Dockerfile multi-stage
- [x] `kubernetes_pod` → Pod manifest básico
