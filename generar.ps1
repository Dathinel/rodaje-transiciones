# Genera las transiciones de rodaje-transiciones (rodaje.preset v2) en <Destino>\transiciones\, deterministas: la
# misma salida byte a byte en cualquier equipo. Lo llama empaquetar.ps1; sin -Destino escribe en la carpeta del script.
# Cada transición son curvas de la transformación del clip que sale y del que entra (en píxeles de 1920 × 1080,
# 0,5 s que Rodaje estira a la duración real) más una mezcla del motor: fundido cruzado, barrido o fundido a un color.
# Las de deslizar y empujar van lineales para que el borde del barrido coincida con el del clip en movimiento; el
# ángulo del barrido va en sentido horario con y hacia abajo (0 = hacia la derecha, 90 = hacia abajo).
param([string]$Destino = '')

$ErrorActionPreference = 'Stop'
$inv = [System.Globalization.CultureInfo]::InvariantCulture
$D = 0.5
$W = 1920
$H = 1080

function K([double]$t, [double]$v, [string]$i = 'linear') { [ordered]@{ t = $t; value = $v; interp = $i } }
function Curva([double]$desde, [double]$hasta, [string]$i = 'linear') { @((K 0 $desde $i), (K $D $hasta)) }

function T([string]$id, [string]$nombre, [string]$descripcion, [string]$mezcla, $parametros, $sale, $entra) {
    $t = [ordered]@{
        format = 'rodaje.preset'; version = 2; id = $id; name = $nombre; description = $descripcion
        kind = 'transition'; durationSeconds = $D; mix = $mezcla
    }
    if ($parametros) { $t.mixParameters = $parametros }
    $t.reference = [ordered]@{ width = $W; height = $H }
    if ($sale) { $t.outgoing = $sale }
    if ($entra) { $t.incoming = $entra }
    $t
}

function Barrido([double]$angulo, [double]$suave) { [ordered]@{ angle = $angulo; softness = $suave } }
function Color([double]$r, [double]$g, [double]$b) { [ordered]@{ red = $r; green = $g; blue = $b } }

$transiciones = @(
    # 1.0.0
    (T 'deslizar-izquierda' 'Deslizar a la izquierda' 'El clip nuevo entra desde la derecha y tapa al anterior.' 'rodaje.wipe' (Barrido 180 0) $null `
        ([ordered]@{ x = Curva $W 0 })),
    (T 'deslizar-derecha' 'Deslizar a la derecha' 'El clip nuevo entra desde la izquierda y tapa al anterior.' 'rodaje.wipe' (Barrido 0 0) $null `
        ([ordered]@{ x = Curva (-$W) 0 })),
    (T 'deslizar-arriba' 'Deslizar hacia arriba' 'El clip nuevo sube desde abajo y tapa al anterior.' 'rodaje.wipe' (Barrido 270 0) $null `
        ([ordered]@{ y = Curva $H 0 })),
    (T 'deslizar-abajo' 'Deslizar hacia abajo' 'El clip nuevo baja desde arriba y tapa al anterior.' 'rodaje.wipe' (Barrido 90 0) $null `
        ([ordered]@{ y = Curva (-$H) 0 })),
    (T 'empujar' 'Empujar' 'El clip nuevo entra por la derecha y empuja al anterior fuera del cuadro.' 'rodaje.wipe' (Barrido 180 0) `
        ([ordered]@{ x = Curva 0 (-$W) }) ([ordered]@{ x = Curva $W 0 })),
    (T 'acercar' 'Acercar' 'Fundido mientras la cámara se acerca.' 'rodaje.crossfade' $null `
        ([ordered]@{ scale = Curva 1 1.5 'easeIn' }) ([ordered]@{ scale = Curva 0.85 1 'easeOut' })),
    (T 'alejar' 'Alejar' 'Fundido mientras la cámara se aleja.' 'rodaje.crossfade' $null `
        ([ordered]@{ scale = Curva 1 0.7 'easeIn' }) ([ordered]@{ scale = Curva 1.4 1 'easeOut' })),
    (T 'girar' 'Girar' 'Un cuarto de vuelta con fundido.' 'rodaje.crossfade' $null `
        ([ordered]@{ rotation = Curva 0 90 'easeIn'; scale = Curva 1 1.3 'easeIn' }) ([ordered]@{ rotation = Curva (-90) 0 'easeOut'; scale = Curva 1.3 1 'easeOut' })),

    # 1.1.0
    (T 'empujar-derecha' 'Empujar a la derecha' 'El clip nuevo entra por la izquierda y empuja al anterior fuera del cuadro.' 'rodaje.wipe' (Barrido 0 0) `
        ([ordered]@{ x = Curva 0 $W }) ([ordered]@{ x = Curva (-$W) 0 })),
    (T 'empujar-arriba' 'Empujar hacia arriba' 'El clip nuevo sube desde abajo y empuja al anterior fuera del cuadro.' 'rodaje.wipe' (Barrido 270 0) `
        ([ordered]@{ y = Curva 0 (-$H) }) ([ordered]@{ y = Curva $H 0 })),
    (T 'empujar-abajo' 'Empujar hacia abajo' 'El clip nuevo baja desde arriba y empuja al anterior fuera del cuadro.' 'rodaje.wipe' (Barrido 90 0) `
        ([ordered]@{ y = Curva 0 $H }) ([ordered]@{ y = Curva (-$H) 0 })),
    (T 'fundido-negro' 'Fundido a negro' 'El clip se funde a negro y el nuevo sale del negro.' 'rodaje.dip' (Color 0 0 0) $null $null),
    (T 'fundido-blanco' 'Fundido a blanco' 'El clip se funde a blanco y el nuevo sale del blanco, como un destello.' 'rodaje.dip' (Color 1 1 1) $null $null),
    (T 'fundido-desenfocado' 'Fundido desenfocado' 'Fundido cruzado a través de un desenfoque.' 'rodaje.blur-dissolve' ([ordered]@{ radius = 40 }) $null $null),
    (T 'barrido-derecha' 'Barrido a la derecha' 'Un borde suave cruza de izquierda a derecha.' 'rodaje.wipe' (Barrido 0 0.15) $null $null),
    (T 'barrido-izquierda' 'Barrido a la izquierda' 'Un borde suave cruza de derecha a izquierda.' 'rodaje.wipe' (Barrido 180 0.15) $null $null),
    (T 'barrido-abajo' 'Barrido hacia abajo' 'Un borde suave baja de arriba abajo.' 'rodaje.wipe' (Barrido 90 0.15) $null $null),
    (T 'barrido-arriba' 'Barrido hacia arriba' 'Un borde suave sube de abajo arriba.' 'rodaje.wipe' (Barrido 270 0.15) $null $null),
    (T 'barrido-diagonal' 'Barrido en diagonal' 'Un borde suave cruza en diagonal, de arriba a la izquierda hacia abajo a la derecha.' 'rodaje.wipe' (Barrido 45 0.2) $null $null),
    (T 'barrido-diagonal-inverso' 'Barrido en diagonal inverso' 'Un borde suave cruza en diagonal, de abajo a la derecha hacia arriba a la izquierda.' 'rodaje.wipe' (Barrido 225 0.2) $null $null),
    (T 'atravesar' 'Atravesar' 'La cámara atraviesa el clip: el anterior crece mucho y el nuevo llega desde atrás, con fundido.' 'rodaje.crossfade' $null `
        ([ordered]@{ scale = Curva 1 2.5 'easeIn' }) ([ordered]@{ scale = Curva 0.6 1 'easeOut' })),
    (T 'girar-empujar' 'Girar y empujar' 'El clip nuevo empuja al anterior hacia la izquierda con un leve giro.' 'rodaje.wipe' (Barrido 180 0.05) `
        ([ordered]@{ x = Curva 0 (-$W); rotation = Curva 0 (-5) 'easeIn'; scale = Curva 1 1.2 'easeIn' }) `
        ([ordered]@{ x = Curva $W 0; rotation = Curva 5 0 'easeOut'; scale = Curva 1.2 1 'easeOut' }))
)

function Json($v, [string]$sangria = '') {
    $mas = $sangria + '  '
    if ($null -eq $v) { return 'null' }
    if ($v -is [bool]) { if ($v) { return 'true' } else { return 'false' } }
    if ($v -is [string]) { return '"' + $v.Replace('\', '\\').Replace('"', '\"') + '"' }
    if ($v -is [int] -or $v -is [long] -or $v -is [double] -or $v -is [decimal]) { return ([double]$v).ToString('R', $inv) }
    if ($v -is [System.Collections.IDictionary]) {
        $partes = foreach ($k in $v.Keys) { $mas + '"' + $k + '": ' + (Json $v[$k] $mas) }
        return "{`n" + ($partes -join ",`n") + "`n$sangria}"
    }
    if ($v -is [System.Collections.IEnumerable]) {
        $lista = @($v)
        if ($lista.Count -eq 0) { return '[]' }
        $simples = -not ($lista | Where-Object { $_ -is [System.Collections.IDictionary] })
        if ($simples) { return '[' + (($lista | ForEach-Object { Json $_ $mas }) -join ', ') + ']' }
        $partes = foreach ($x in $lista) { $mas + (Json $x $mas) }
        return "[`n" + ($partes -join ",`n") + "`n$sangria]"
    }
    throw "Tipo sin JSON: $($v.GetType().FullName)"
}

if (-not $Destino) { $Destino = $PSScriptRoot }
$carpeta = Join-Path ([System.IO.Path]::GetFullPath($Destino)) 'transiciones'
[System.IO.Directory]::CreateDirectory($carpeta) | Out-Null
$utf8 = New-Object System.Text.UTF8Encoding($false)
foreach ($t in $transiciones) {
    [System.IO.File]::WriteAllText((Join-Path $carpeta "$($t.id).json"), (Json $t) + "`n", $utf8)
}
Write-Host "  $($transiciones.Count) transiciones en $carpeta"
