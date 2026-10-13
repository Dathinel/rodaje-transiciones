<p align="center">
  <a href="https://github.com/Dathinel/rodaje"><img src="https://raw.githubusercontent.com/Dathinel/rodaje/main/assets/marca/rodaje.svg" alt="Logotipo de Rodaje" width="104"></a>
</p>

<h1 align="center">rodaje-transiciones</h1>

<p align="center">
  Complemento opcional para <a href="https://github.com/Dathinel/rodaje">Rodaje</a>: 45 transiciones hechas solo con curvas de la transformación y una mezcla del propio editor, sin shaders ni código.
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/licencia-CC0_1.0-E8833A?style=flat-square&labelColor=1D1D1D" alt="Licencia CC0 1.0"></a>
  <a href="https://github.com/Dathinel/rodaje-transiciones/releases/latest"><img src="https://img.shields.io/github/v/release/Dathinel/rodaje-transiciones?style=flat-square&labelColor=1D1D1D&color=E8833A&label=versi%C3%B3n" alt="Última versión"></a>
  <img src="https://img.shields.io/badge/contenido-45_transiciones-E8833A?style=flat-square&labelColor=1D1D1D" alt="Contenido: 45 transiciones">
  <img src="https://img.shields.io/badge/formato-.paquete-E8833A?style=flat-square&labelColor=1D1D1D" alt="Formato .paquete">
  <a href="https://github.com/Dathinel/rodaje"><img src="https://img.shields.io/badge/para-Rodaje-E8833A?style=flat-square&labelColor=1D1D1D" alt="Para Rodaje"></a>
</p>

| Transición | Cómo es |
|---|---|
| Deslizar a la izquierda, derecha, arriba y abajo | El clip nuevo entra desde fuera del cuadro y tapa al anterior (barrido sin borde que sigue al clip) |
| Empujar (a la izquierda), a la derecha, arriba y abajo | El nuevo entra y empuja al anterior fuera |
| Acercar y alejar | Fundido mientras la cámara se acerca o se aleja |
| Girar | Un cuarto de vuelta con fundido |
| Atravesar | El anterior crece mucho y el nuevo llega desde atrás, con fundido |
| Girar y empujar | Empujar con un leve giro |
| Fundido a negro y a blanco | Al color y desde él |
| Fundido desenfocado | Fundido cruzado a través de un desenfoque |
| Barrido a la derecha, izquierda, abajo y arriba | Borde suave que cruza el cuadro |
| Barrido en diagonal y en diagonal inverso | Borde suave a 45° |

**Nuevas en la 1.2.0**, con las mezclas de calidad que Rodaje dibuja en la GPU (giro, zoom con desenfoque, deslizar con desenfoque de movimiento, barrido con luz, fallo digital, quemado de película, destello, disolución por luma y empuje con rebote). En un Rodaje anterior a esas mezclas se ven como fundido cruzado.

| Transición | Cómo es |
|---|---|
| Giro rápido y Media vuelta | Una vuelta entera, o media hacia la izquierda, con acercamiento y desenfoque de movimiento |
| Zoom explosivo y Zoom suave | Acercamiento con desenfoque radial hacia el centro, fuerte o ligero |
| Latigazo a la izquierda y a la derecha | Paneo rápido: los dos clips corren con mucho desenfoque de movimiento |
| Deslizar en diagonal | El nuevo entra desde arriba a la izquierda, con desenfoque de movimiento |
| Barrido de luz dorada y de luz fría | Barrido con una franja de luz cálida o azulada en el borde |
| Fallo digital fuerte y sutil | Franjas corridas y canales de color separados |
| Quemado cálido y rojo | Manchas de luz que queman la película |
| Destello blanco y cálido | Un destello tapa el corte |
| Reloj, Iris, Nubes, Persianas y Rombo | Disolución por luma con los degradados de fábrica (el iris, con borde blanco) |
| Rebote a la izquierda y hacia arriba | El nuevo empuja al anterior, se pasa y vuelve |
| Barrido con borde blanco | Barrido nítido con una línea blanca delante del cambio |

## Instalar en Rodaje

En Rodaje, Complementos → Instalar lo baja, comprueba su firma y lo instala. A mano: descarga `rodaje-transiciones-<versión>.paquete` de las [releases](https://github.com/Dathinel/rodaje-transiciones/releases) y, en Rodaje, usa «Instalar desde archivo…» en Complementos o suéltalo sobre la biblioteca. Aparecen en Transiciones; se sueltan sobre un corte (0,5 s por defecto). Si un proyecto usa una y el paquete falta, se ve como fundido cruzado y Rodaje avisa. Más detalles en la [guía de complementos](https://github.com/Dathinel/rodaje/blob/main/docs/guia/complementos.md).

## Construir el paquete

```
powershell -NoProfile -ExecutionPolicy Bypass -File empaquetar.ps1
```

Solo hace falta Windows PowerShell 5.1. Genera las transiciones y deja `dist\rodaje-transiciones-<versión>.paquete` con orden y fecha fijos: las mismas fuentes dan el mismo archivo byte a byte. `-Salida <carpeta>` cambia dónde queda. Las 22 de la 1.1.0 salen idénticas byte a byte, así los proyectos que las usan no cambian.

| Archivo | Qué es |
|---|---|
| `paquete.json` | Manifiesto: 45 `transition` |
| `generar.ps1` | Las curvas y mezclas; escribe `transiciones/*.json` (`rodaje.preset` v2) |
| `empaquetar.ps1` | Arma el `.paquete` |

## Licencia

CC0 1.0 (dominio público), ver `LICENSE`. El logotipo de Rodaje es marca de su autor y no forma parte de este contenido ([TRADEMARK.md](https://github.com/Dathinel/rodaje/blob/main/TRADEMARK.md)).
