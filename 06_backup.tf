resource "azurerm_recovery_services_vault" "backup-vault" { # '백업 자격 증명 모음'으로 backup policy를 위해 필요한 부분
  name                = "recovery-vault"
  location            = azurerm_resource_group.backup_rg.location # Azure Disk 백업에서 지역 간 백업 및 복원은 지원되지 않는다.
  resource_group_name = azurerm_resource_group.backup_rg.name # 같은 구독 내, 백업 대상 리소스가 있는 다른 리소스 그룹에 따로 생성하기를 권장함
  sku                 = "Standard" # 콘솔에는 설정 부분 없음

  soft_delete_enabled = false # default = true, 바로 삭제 안되는 문제가 있어서 false로 설정해줌
}

resource "azurerm_backup_policy_vm" "backup-policy" {
  name                = "recovery-vault-policy"
  resource_group_name = azurerm_resource_group.backup_rg.name
  recovery_vault_name = azurerm_recovery_services_vault.backup-vault.name

  timezone = "Korea Standard Time" # https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/ 에서 사용가능한 타임존 리스트 확인 가능

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {# 일일 백업 지점 보존 기간. 7~9999 가능
    count = 7
  }
/*
  retention_weekly { # 주간 백업 지점 보존 기간
    count    = 42
    weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
  }

  retention_monthly {# 월간 백업 지점 보존 기간
    count    = 7
    weekdays = ["Sunday", "Wednesday"]
    weeks    = ["First", "Last"]
  }

  retention_yearly {# 연간 백업 지점 보존 기간
    count    = 77
    weekdays = ["Sunday"]
    weeks    = ["Last"] # 몇 번째 성공한 백업 지점을 보존하겠다
    months   = ["January"]
  }
  선택한 자격 증명 모음에 전역 중복 설정이 되어있어도 disk backup은 스냅샷 데이터 스토리지만 지원한다.
  모든 백업은 구독의 리소스 그룹에 저장, 백업 자격 증명 모음 스토리지로 복사 되지 않는다
  
  }
  */
}