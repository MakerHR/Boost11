$OutputEncoding = [System.Text.UTF8Encoding]::new()

function Show-Menu {
    param (
        [string]$title = 'Menu Principal'
    )
    
    cls
    Write-Host "================ $title ================"
    Write-Host "1. Opção 1: Desativar telemetria"
    Write-Host "2. Opção 2: Menu de contexto classico"
    Write-Host "3. Opção 3: Desativar Hibernar"
	Write-Host "4. Opção 4: Habilitar alto desempenho"
	Write-Host "5. Opção 5: Desativar UAC"
	Write-Host "6. Opção 6: Limpar barra de tarefas"
    Write-Host "7. Sair"
    Write-Host "======================================"
    Write-Host ""
}

function Get-Selection {
    param (
        [int]$min = 1,
        [int]$max = 7
    )
    
    $selection = Read-Host "Escolha uma opção ($min-$max)"
    while ($selection -lt $min -or $selection -gt $max) {
        Write-Host "Seleção inválida. Tente novamente."
        $selection = Read-Host "Escolha uma opção ($min-$max)"
    }
    
    return $selection
}

function Execute-Action {
    param (
        [int]$selection
    )
    
    switch ($selection) {
        1 {
            Write-Host "Desativando a telemetria do Windows"
			# Desativar Permitir que o Windows melhore os resultados de inicialização e pesquisa rastreando lançamentos de aplicativos
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value 0 -PropertyType DWORD -Force

			# Online Speech Recognition
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" -Name "HasAccepted" -Value 0 -PropertyType DWORD -Force

			# Melhore o reconhecimento de tinta e digitação
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Input\TIPC" -Name "Enabled" -Value 0 -PropertyType DWORD -Force

			# Permitir que os aplicativos usem ID de publicidade para anúncios relevantes no Windows 10
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0 -PropertyType DWORD -Force

			# Experiências personalizadas com dados de diagnóstico para usuário atual
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Value 0 -PropertyType DWORD -Force

			# Personalização de tinta e digitação
			New-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value 1 -PropertyType DWORD -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value 1 -PropertyType DWORD -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Value 0 -PropertyType DWORD -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Value 0 -PropertyType DWORD -Force

			# Envie apenas dados de diagnóstico e uso necessários
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Value 0 -PropertyType DWORD -Force
        }
        2 {
            Write-Host "Halitar menu de contexto classico"
			New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "EnableClassicShellMenu" -Value 1 -PropertyType DWORD -Force
        }
        3 {
            Write-Host "Desabilitar hibernar"
            powercfg /hibernate off 
        }
		
		  4 {
            Write-Host "Modo de energia de alto desempenho"
			powercfg -SetActive SCHEME_MIN
			powercfg -change -standby-timeout-ac 0
			powercfg -change -standby-timeout-dc 0
			powercfg -change -monitor-timeout-ac 0
			powercfg -change -monitor-timeout-dc 0
			powercfg -change -disk-timeout-ac 0
			powercfg -change -disk-timeout-dc 0
			powercfg -change -hibernate-timeout-ac 0
			powercfg -change -hibernate-timeout-dc 0
		}
		
		  5 {
            Write-Host "Desabilitar UAC"
             New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "EnableLUA" -Value 0 -PropertyType DWORD -Force
        }
        
		
		  6 {
            Write-Host "Limpar barra de tarefas"
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0
			Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0
			Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0
        }
		
		
        7 {
            Write-Host "Saindo do menu..."
        }
        default {
            Write-Host "Seleção inválida."
        }
    }
}

# Loop principal do menu
do {
    Show-Menu
    $selection = Get-Selection
    Execute-Action -selection $selection
    
    if ($selection -ne 7) {
        Write-Host ""
        Read-Host "Pressione Enter para continuar..."
    }
} while ($selection -ne 7)

Write-Host "Programa finalizado."
