<p align="center">
  <a href="https://github.com/Dathinel/rodaje"><img src="https://raw.githubusercontent.com/Dathinel/rodaje/main/assets/marca/rodaje.svg" alt="Logotipo de Rodaje" width="104"></a>
</p>

<h1 align="center">rodaje-transiciones</h1>

<p align="center">
  Complemento opcional para <a href="https://github.com/Dathinel/rodaje">Rodaje</a>: 8 transiciones hechas solo con curvas de la transformación y una mezcla del propio editor, sin shaders ni código.
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/licencia-CC0_1.0-E8833A?style=flat-square&labelColor=1D1D1D" alt="Licencia CC0 1.0"></a>
  <a href="https://github.com/Dathinel/rodaje-transiciones/releases/latest"><img src="https://img.shields.io/github/v/release/Dathinel/rodaje-transiciones?style=flat-square&labelColor=1D1D1D&color=E8833A&label=versi%C3%B3n" alt="Última versión"></a>
  <img src="https://img.shields.io/badge/formato-.paquete-E8833A?style=flat-square&labelColor=1D1D1D" alt="Formato .paquete">
  <a href="https://github.com/Dathinel/rodaje"><img src="https://img.shields.io/badge/para-Rodaje-E8833A?style=flat-square&labelColor=1D1D1D" alt="Para Rodaje"></a>
</p>

| Transición | Cómo es |
|---|---|
| Deslizar a la izquierda, derecha, arriba y abajo | El clip nuevo entra desde fuera del cuadro y tapa al anterior (barrido sin borde que sigue al clip) |
| Empujar | El nuevo entra por la derecha y empuja al anterior fuera |
| Acercar y alejar | Fundido mientras la cámara se acerca o se aleja |
| Girar | Un cuarto de vuelta con fundido |

## Instalar en Rodaje

En Rodaje, Complementos → Instalar lo baja, comprueba su firma y lo instala. A mano: descarga `rodaje-transiciones-<versión>.paquete` de las [releases](https://github.com/Dathinel/rodaje-transiciones/releases) y, en Rodaje, usa «Instalar desde archivo…» en Complementos o suéltalo sobre la biblioteca. Aparecen en Transiciones; se sueltan sobre un corte (0,5 s por defecto). Si un proyecto usa una y el paquete falta, se ve como fundido cruzado y Rodaje avisa.

## Construir el paquete

```
powershell -NoProfile -ExecutionPolicy Bypass -File empaquetar.ps1
```

Solo hace falta Windows PowerShell 5.1. Deja `dist\rodaje-transiciones-<versión>.paquete` con orden y fecha fijos: las mismas fuentes dan el mismo archivo byte a byte. `-Salida <carpeta>` cambia dónde queda.

| Archivo | Qué es |
|---|---|
| `paquete.json` | Manifiesto: 8 `transition` |
| `transiciones/*.json` | `rodaje.preset` v2: curvas del clip que sale y del que entra, más la mezcla |
| `empaquetar.ps1` | Arma el `.paquete` |

## Licencia

CC0 1.0 (dominio público), ver `LICENSE`. El logotipo de Rodaje es marca de su autor y no forma parte de este contenido ([TRADEMARK.md](https://github.com/Dathinel/rodaje/blob/main/TRADEMARK.md)).
