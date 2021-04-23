#!/bin/pwsh

$server = ""

Connect-VIServer -Server $server -Credential (Import-Clixml "/projects/secrets/vcenter.clixml")

