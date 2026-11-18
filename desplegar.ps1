
param(
    [string]$RutaPHP = 'php'
)

$archivoOrigen = Join-Path $PSScriptRoot "origen\index.php"
$archivoDestino = Join-Path $PSScriptRoot "pruebas\index.php"

# Comprobar la sintaxis del archivo PHP
& $RutaPHP -l $archivoOrigen

if ($LASTEXITCODE -ne 0) {
    Write-Host "Hay un error de sintaxis. No se publicó el cambio."
    exit 1
}

# Crear la carpeta de pruebas si no existe
New-Item -ItemType Directory -Path (Split-Path $archivoDestino) -Force | Out-Null

# Copiar el archivo validado
Copy-Item $archivoOrigen $archivoDestino -Force -ErrorAction Stop

Write-Host "Version publicada en el ambiente de pruebas."
