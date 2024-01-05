$frame = $true                  # $true/$false  |  $true - additional "frame" made of "=" characters (it is longer or shorter depending on the time)
$background_color = "#121212"   # background color (in HEX)
$text_color = "#FAFAFA"         # text color (eg. '{' character) (in HEX)
$class_color = "#01B391"        # 'class' word color (in HEX)
$class_name_color = "#94007D"   # name of class color (in HEX)
$date_time_color = "#0195B3"    # 'Date' and 'Time' text color (in HEX)
$words_color = "#FFA64D"        # 'Year', 'Month', etc. words color (in HEX)
$digits_color = "#CCE0FF"       # Digits color (in HEX)

function make_wallpaper {
$year = (Get-Date).Year
$month = (Get-Date).Month.ToString("00")
$day = (Get-Date).Day.ToString("00")
$day_of_the_week = (Get-Date).DayOfWeek
$hour = (Get-Date).Hour.ToString("00")
$minute = (Get-Date).Minute.ToString("00")
$second = (Get-Date).Second.ToString("00")


$text = $text -split "`n" | ForEach-Object { "`n`n`n`n`n`n                                     " + $_ }
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

$brushBg =          New-Object System.Drawing.SolidBrush(([System.Drawing.ColorTranslator]::FromHtml($background_color)))
$text_color =       New-Object System.Drawing.SolidBrush(([System.Drawing.ColorTranslator]::FromHtml($text_color)))
$class_color =      New-Object System.Drawing.SolidBrush(([System.Drawing.ColorTranslator]::FromHtml($class_color)))
$class_name_color = New-Object System.Drawing.SolidBrush(([System.Drawing.ColorTranslator]::FromHtml($class_name_color)))
$date_time_color =  New-Object System.Drawing.SolidBrush(([System.Drawing.ColorTranslator]::FromHtml($date_time_color)))
$words_color =      New-Object System.Drawing.SolidBrush(([System.Drawing.ColorTranslator]::FromHtml($words_color)))
$digits_color =     New-Object System.Drawing.SolidBrush(([System.Drawing.ColorTranslator]::FromHtml($digits_color)))

$graphics = [System.Drawing.Graphics]::FromImage($bmp) 
$graphics.FillRectangle($brushBg,0,0,$bmp.Width,$bmp.Height) 

$graphics.DrawString("`n`n`n`n`n`n                                     class",                                             $font, $class_color, 10, 10)      # class Now
$graphics.DrawString("`n`n`n`n`n`n                                           Now",                                         $font, $class_name_color, 10, 10) # 
$graphics.DrawString("`n`n`n`n`n`n`n                                     {",                                               $font, $text_color, 10, 10)       # {
$graphics.DrawString("`n`n`n`n`n`n`n`n                                        Date",                                       $font, $date_time_color, 10, 10)  #    Date {
$graphics.DrawString("`n`n`n`n`n`n`n`n                                             {",                                     $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n                                           Day",                                   $font, $words_color, 10, 10)      #       Day: XX;
$graphics.DrawString("`n`n`n`n`n`n`n`n`n                                              :",                                  $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n                                                $day",                             $font, $digits_color, 10, 10)     #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n                                                  ;",                              $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n                                           Day_of_the_week",                     $font, $words_color, 10, 10)      #       Day_of_the_week: XXXXXXXXXXX;
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n                                                          :",                    $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n                                                            $day_of_the_week",   $font, $digits_color, 10, 10)     #
#$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n                                                                           ;",  $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n                                           Month",                             $font, $words_color, 10, 10)      #       Month: XX;
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n                                                :",                            $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n                                                  $month",                     $font, $digits_color, 10, 10)     #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n                                                    ;",                        $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n                                           Year",                            $font, $words_color, 10, 10)      #       Year: XXXX;
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n                                               :",                           $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n                                                 $year",                     $font, $digits_color, 10, 10)     #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n                                                     ;",                     $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n                                        }",                                $font, $text_color, 10, 10)       #    }
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                     ",                                  $font, $text_color, 10, 10)       # 
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                        Time",                         $font, $date_time_color, 10, 10)  #    Time {
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                             {",                       $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                           Hour",                    $font, $words_color, 10, 10)      #       Hour: XX;
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                               :",                   $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                                 $hour",             $font, $digits_color, 10, 10)     #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                                   ;",               $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                           Minute",                $font, $words_color, 10, 10)      #       Minute: XX;
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                                 :",               $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                                   $minute",       $font, $digits_color, 10, 10)     #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                                     ;",           $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                           Second",              $font, $words_color, 10, 10)      #       Second: XX;
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                                 :",             $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                                   $second",     $font, $digits_color, 10, 10)     #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                                     ;",         $font, $text_color, 10, 10)       #
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                        }",                    $font, $text_color, 10, 10)       #    }
$graphics.DrawString("`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n                                     }",                     $font, $text_color, 10, 10)       # }


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
}


while($true) {
   make_wallpaper
   timeout 1
}