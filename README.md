# Script Otimiza PC

![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-%234D4D4D.svg?style=for-the-badge&logo=windows-terminal&logoColor=white)
![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

Conjunto de scripts em **Batch (.bat)** para Windows que automatizam tarefas do dia a dia através de menus interativos, sem precisar decorar comandos de terminal. Ambos se auto-elevam como Administrador (solicitam UAC) quando necessário.

## 📦 Scripts

| Script                     | O que faz                                                                                                                                                       | Documentação                                    |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| `limpa.bat`                | Menu com as principais tarefas de manutenção, limpeza e diagnóstico do Windows: SFC, CHKDSK, cache DNS, arquivos temporários, cache do Windows Update, desfragmentação, logs de eventos, pontos de restauração, reinício de serviços e liberação de RAM. | [README_LIMPA.md](README_LIMPA.md)               |
| `instala_ferramentas.bat`  | Menu que instala, via **winget**, ferramentas de trabalho comuns: Git, Node.js, VS Code, Brave, GitHub Desktop, Obsidian, Discord, Winhance, UniGetUI, WSL2, Docker Desktop e FFmpeg. | [README_INSTALADOR.md](README_INSTALADOR.md)     |

## 🗂️ Estrutura do projeto

```
Script Otimiza PC/
├── limpa.bat                 # Menu de otimização e manutenção do Windows
├── instala_ferramentas.bat   # Menu de instalação de ferramentas de trabalho (winget)
├── README.md                 # Este arquivo — resumo do projeto
├── README_LIMPA.md           # Documentação do limpa.bat
└── README_INSTALADOR.md      # Documentação do instala_ferramentas.bat
```

## 📄 Licença

Uso livre e pessoal. Sinta-se à vontade para adaptar os scripts às suas necessidades.
