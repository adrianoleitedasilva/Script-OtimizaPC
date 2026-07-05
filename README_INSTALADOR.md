# Instalador de Ferramentas de Trabalho

![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-%234D4D4D.svg?style=for-the-badge&logo=windows-terminal&logoColor=white)
![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

Script em **Batch (.bat)** para Windows que automatiza, via **winget** (Windows Package Manager), a instalação das ferramentas mais usadas no dia a dia de desenvolvimento — tudo em um único menu interativo, sem precisar baixar instaladores manualmente ou decorar comandos.

## 📋 Pré-requisitos

- Windows 10/11 com o `winget` disponível (já vem por padrão em instalações atualizadas). Caso não esteja presente, o script avisa para instalar o "App Installer" pela Microsoft Store.
- Privilégios de Administrador — o próprio script detecta se não está elevado e solicita a permissão automaticamente (UAC).

## ▶️ Como usar

1. Baixe/copie o arquivo `instala_ferramentas.bat` para o computador.
2. Dê duplo clique no arquivo. Se o Windows solicitar permissão (UAC), clique em **Sim** — o script se auto-eleva e reabre já como Administrador.
3. Escolha uma das opções do menu digitando o número correspondente e pressionando `Enter`.
4. Após a execução de cada instalação, pressione qualquer tecla para retornar ao menu.

## 🧩 Funcionalidades (opções do menu)

| Nº  | Opção                                        | O que faz |
| --- | --------------------------------------------- | --------- |
| 1   | Instalar Git                                  | Instala o Git via winget (`Git.Git`). |
| 2   | Instalar Node.js (LTS)                        | Instala a versão LTS do Node.js (`OpenJS.NodeJS.LTS`). |
| 3   | Instalar Visual Studio Code                   | Instala o VS Code (`Microsoft.VisualStudioCode`). |
| 4   | Instalar Brave Browser                        | Instala o navegador Brave (`BraveSoftware.BraveBrowser`). |
| 5   | Instalar GitHub Desktop                       | Instala o GitHub Desktop (`GitHub.GitHubDesktop`). |
| 6   | Instalar Obsidian                             | Instala o Obsidian (`Obsidian.Obsidian`). |
| 7   | Instalar Discord                              | Instala o Discord (`Discord.Discord`). |
| 8   | Instalar Winhance                             | Instala o Winhance (`memstechtips.Winhance`), ferramenta de otimização e debloat do Windows. |
| 9   | Instalar UniGetUI                             | Instala o UniGetUI (`Devolutions.UniGetUI`), interface gráfica para gerenciar pacotes do winget e outros gerenciadores. |
| 10  | Instalar/Habilitar WSL2                       | Executa `wsl --install` e define a versão padrão como 2 (`wsl --set-default-version 2`). Pode exigir reinicialização do computador. |
| 11  | Instalar Docker Desktop                       | Instala o Docker Desktop (`Docker.DockerDesktop`), que usa o WSL2 como backend — recomenda-se instalar o WSL2 antes (opção 10). |
| 12  | Instalar tudo (1‑11)                          | Executa todas as instalações acima em sequência. |
| 13  | Verificar/instalar atualizações disponíveis   | Lista os pacotes com atualização pendente (`winget upgrade`) e pergunta se deseja atualizar todos (`winget upgrade --all`). |
| 0   | Sair                                          | Encerra o script. |

## ⚠️ Avisos importantes

- **Privilégios de administrador**: necessários para a maioria das instalações e obrigatórios para o WSL2/Docker Desktop. O script solicita elevação automaticamente (UAC) caso não esteja rodando como Administrador.
- **Docker Desktop e WSL2**: o Docker Desktop usa o WSL2 como backend. Recomenda-se instalar/habilitar o WSL2 (opção 10) antes do Docker (opção 11), e reiniciar o computador se for a primeira instalação de qualquer um dos dois.
- **Conexão com a internet**: todas as instalações são baixadas pela internet através do winget — é necessário estar conectado.
- **Tempo de execução**: a instalação de todas as ferramentas (opção 12) pode demorar bastante dependendo da velocidade da internet.

## 🗂️ Estrutura do projeto

```
Script Otimiza PC/
├── limpa.bat                 # Menu de otimização e manutenção do Windows
├── instala_ferramentas.bat   # Menu de instalação de ferramentas de trabalho (winget)
├── README.md                 # Resumo do projeto
├── README_LIMPA.md           # Documentação do limpa.bat
└── README_INSTALADOR.md      # Este arquivo — documentação do instala_ferramentas.bat
```

## 📄 Licença

Uso livre e pessoal. Sinta-se à vontade para adaptar o script às suas necessidades.
