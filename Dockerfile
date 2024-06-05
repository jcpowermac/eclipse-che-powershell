FROM quay.io/devfile/universal-developer-image:ubi8-latest

USER 0

# Register the Microsoft RedHat repository
RUN cd /tmp && \
    curl -sSL -O https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm && \
    rpm -i packages-microsoft-prod.rpm && \
    rm packages-microsoft-prod.rpm && \
    dnf install -y powershell

RUN export POWERSHELL_TELEMETRY_OPTOUT=1 && \
	pwsh -NoLogo -NoProfile -Command " \
          \$ErrorActionPreference = 'Stop' ; \
          \$ProgressPreference = 'SilentlyContinue' ; \
          Set-PSRepository -Name PSGallery -InstallationPolicy Trusted ; \
          Install-Module -Scope AllUsers VMware.PowerCLI ; \
          Install-Module -Name PSReadLine -AllowPrerelease -Scope AllUsers -Force -SkipPublisherCheck ; \
          Install-Module -Scope AllUsers posh-git ; \
          Install-Module -Scope AllUsers oh-my-posh ; \
          Set-PowerCLIConfiguration -Scope AllUsers -ParticipateInCeip:\$false -Confirm:\$false"

USER 10001
