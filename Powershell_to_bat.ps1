$file_path = "$home\Desktop\animated_wallpaper.txt"          #Input file path  (like this)
$output_file_path = "$home\Desktop\animated_wallpaper.bat"   #Output file path (like this)

function P2B {
    param
    (
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [string]
        $Path
    )
 
    process
    {
        $encoded = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Content -Path $Path -Raw -Encoding UTF8)))
        "powershell -w h -NoP -NonI -Exec Bypass -WindowStyle Hidden -enc $encoded" | Set-Content -Path $output_file_path -Encoding Ascii
    }
}

P2B -Path $file_path

######   This program is changed version of @I-Am-Jakoby project :)   ######
