$inicio = "1 de janeiro de 2017 00:00:00"
$dataInicial = get-date $inicio 
$dataFinal = get-date -uformat %Y%m%d
$dataBaixar = (Get-Date $dataInicial).AddDays(0) | Get-Date -UFormat "%Y%m%d"
$i=0
while($dataFinal -cne $dataBaixar){
    
   	
	$dataBaixar = (Get-Date $dataInicial).AddDays($i) | Get-Date -UFormat "%Y%m%d"
    Write-Host $dataBaixar
    curl http://www.portaltransparencia.gov.br/download-de-dados/despesas/$dataBaixar -OutFile C:\Users\$env:USERNAME\Downloads\BaixarPortal\$dataBaixar.zip -ErrorAction SilentlyContinue
    Add-Type -Assembly System.IO.Compression.FileSystem
    $sourceFile = "C:\Users\$env:USERNAME\Downloads\BaixarPortal\$dataBaixar.zip"
    $zip = [IO.Compression.ZipFile]::OpenRead($sourceFile)
    $i++
    $zip.Entries | where {$_.Name -like '*_Pagamento.csv'} | foreach {[System.IO.Compression.ZipFileExtensions]::ExtractToFile($_, "C:\Users\$env:USERNAME\Downloads\BaixarPortal\gg\$i.csv", $true)}
    $zip.Dispose()
}