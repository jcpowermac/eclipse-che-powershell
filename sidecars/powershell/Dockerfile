FROM mcr.microsoft.com/powershell:lts-centos-8

RUN dnf upgrade --refresh -y && \
    dnf install git curl wget grep sed -y

RUN export POWERSHELL_TELEMETRY_OPTOUT=1 && \
	pwsh -NoLogo -NoProfile -Command " \
          \$ErrorActionPreference = 'Stop' ; \
          \$ProgressPreference = 'SilentlyContinue' ; \
          Set-PSRepository -Name PSGallery -InstallationPolicy Trusted ; \
          Install-Module -Scope AllUsers VMware.PowerCLI ; \
          Install-Module -Name PSReadLine -AllowPrerelease -Scope AllUsers -Force -SkipPublisherCheck ; \
          Install-Module -Scope AllUsers posh-git ; \
          Install-Module -Scope AllUsers oh-my-posh ; \
          Install-Module -Scope AllUsers UniversalDashboard ; \
          Install-PSUServer -LatestVersion"

ENV HOME=/home/theia

RUN mkdir /projects ${HOME} && \
    # Change permissions to let any arbitrary user
    for f in "${HOME}" "/etc/passwd" "/projects"; do \
      echo "Changing permissions on ${f}" && chgrp -R 0 ${f} && \
      chmod -R g+rwX ${f}; \
    done

RUN mkdir ${HOME}/.dotnet && chmod -R 777 ${HOME}/.dotnet \
    && chmod -R 777 ${HOME}

WORKDIR /projects

ADD etc/entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ${PLUGIN_REMOTE_ENDPOINT_EXECUTABLE}


