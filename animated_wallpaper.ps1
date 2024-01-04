$frame = $true                  # $true/$false  |  $true - additional "frame" made of "=" characters (it is longer or shorter depending on the time)
$background_color = "#121212"   # background color (in HEX)
$text_color = "#FAFAFA"         # text color (in HEX)

while($true) {
$year = (Get-Date).Year
$month = (Get-Date).Month.ToString("00")
$day = (Get-Date).Day.ToString("00")
$day_of_the_week = (Get-Date).DayOfWeek
$hour = (Get-Date).Hour.ToString("00")
$minute = (Get-Date).Minute.ToString("00")
$second = (Get-Date).Second.ToString("00")

$text = "class Now 
{
   Date {
      Day: $day;
      Day_of_the_week: $day_of_the_week;
      Month: $month;
      Year: $year;
   }

   Time {
      Hour: $hour;
      Minute: $minute;
      Second: $second;
   }
}"

$text = $text -split "`n" | ForEach-Object { "`n                                     " + $_ }
$text = "`n`n`n`n`n" + $text + "`n`n`n`n`n`n"

If($frame) {
   $value = ((((Get-Date).Hour) * 3600 + ((Get-Date).Minute) * 60 + ((Get-Date).Second)) - 0) * (104 - 0) / (86399 - 0)
   $value1 = 104 - $value

   $text = ((" " * $value1) + ("=" * $value)) + $text + ("=" * $value)
}

Add-Type -AssemblyName System.Drawing

cd $home
try { del .png } catch {}

$filename = "$home\.png" 
$bmp = new-object System.Drawing.Bitmap 1920,1080 
$font = new-object System.Drawing.Font Consolas,24 

$brushBg = New-Object System.Drawing.SolidBrush(([System.Drawing.ColorTranslator]::FromHtml($background_color)))
$brushFg = New-Object System.Drawing.SolidBrush(([System.Drawing.ColorTranslator]::FromHtml($text_color)))

$graphics = [System.Drawing.Graphics]::FromImage($bmp) 
$graphics.FillRectangle($brushBg,0,0,$bmp.Width,$bmp.Height) 
$graphics.DrawString($text,$font,$brushFg,10,10) 
$graphics.Dispose() 
$bmp.Save($filename) 

Function Set-WallPaper {
param (
    [parameter(Mandatory=$True)]
    # Provide path to image
    [string]$Image,
    # Provide wallpaper style that you would like applied
    [parameter(Mandatory=$False)]
    [ValidateSet('Fill', 'Fit', 'Stretch', 'Tile', 'Center', 'Span')]
    [string]$Style)
$WallpaperStyle = Switch ($Style) {
    "Center" {"0"}}
If($Style -eq "Tile") {
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 1 -Force
}
Else {
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -PropertyType String -Value $WallpaperStyle -Force
    New-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name TileWallpaper -PropertyType String -Value 0 -Force}
Add-Type -TypeDefinition @" 
using System; 
using System.Runtime.InteropServices;
public class Params { 
    [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
    public static extern int SystemParametersInfo (Int32 uAction, 
                                                   Int32 uParam, 
                                                   String lpvParam, 
                                                   Int32 fuWinIni);}
"@ 
    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02
    $fWinIni = $UpdateIniFile -bor $SendChangeEvent
    $ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)}

Set-WallPaper -Image $filename -Style Center
timeout 1
}