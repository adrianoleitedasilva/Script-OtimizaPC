# Ferramenta de Otimização do Windows

![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-%234D4D4D.svg?style=for-the-badge&logo=windows-terminal&logoColor=white)
![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

Script em **Batch (.bat)** para Windows que reúne, em um único menu interativo, as principais tarefas de manutenção, limpeza e diagnóstico do sistema. Ele foi pensado para ser executado via `cmd.exe` com privilégios de Administrador e evita que o usuário precise decorar comandos avulsos de terminal.

## 📋 Pré-requisitos

- Windows 10/11 (compatível também com versões anteriores que possuam os utilitários usados).
- Privilégios de Administrador — o próprio script detecta se não está elevado e solicita a permissão automaticamente (UAC).

## ▶️ Como usar

1. Baixe/copie o arquivo `limpa.bat` para o computador.
2. Dê duplo clique no arquivo. Se o Windows solicitar permissão (UAC), clique em **Sim** — o script se auto-eleva e reabre já como Administrador.
3. Escolha uma das opções do menu digitando o número correspondente e pressionando `Enter`.
4. Após a execução de cada tarefa, pressione qualquer tecla para retornar ao menu.

## 🧩 Funcionalidades (opções do menu)

| Nº  | Opção                                   | O que faz                                                                                                                                                                                                                    |
| --- | ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1   | Verificar integridade do sistema (SFC)  | Executa `sfc /scannow`, que varre os arquivos de sistema do Windows e restaura automaticamente qualquer arquivo protegido que esteja corrompido ou ausente.                                                                  |
| 2   | Verificar disco (CHKDSK)                | Executa `chkdsk C: /scan`, analisando a unidade `C:` em busca de erros no sistema de arquivos e em setores do disco, sem bloquear o uso da unidade durante a varredura.                                                      |
| 3   | Limpar cache DNS                        | Executa `ipconfig /flushdns`, limpando o cache de resolução de nomes DNS. Útil quando sites não carregam corretamente ou apontam para endereços antigos.                                                                     |
| 4   | Limpar arquivos temporários             | Apaga os arquivos armazenados nas pastas `%temp%` (temporários do usuário) e `%windir%\Temp` (temporários do sistema), liberando espaço em disco.                                                                            |
| 5   | Limpar cache de atualizações do Windows | Para os serviços `wuauserv` (Windows Update) e `bits`, remove a pasta `%windir%\SoftwareDistribution` (cache de atualizações baixadas) e reinicia os serviços. Ajuda a resolver falhas de instalação de atualizações.        |
| 6   | Desfragmentar/Otimizar disco (C:)       | Executa `defrag C: /O`, otimizando a unidade `C:` de acordo com o tipo de mídia (desfragmenta HDDs e faz _TRIM_ em SSDs). Pode demorar bastante dependendo do uso e tamanho do disco.                                        |
| 7   | Limpar logs de eventos antigos          | Pede confirmação explícita (`CONFIRMAR`) e, em seguida, limpa **todos** os logs do Visualizador de Eventos do Windows via `wevtutil`. Ação irreversível — pode dificultar diagnósticos futuros.                              |
| 8   | Gerenciar/Limpar Pontos de Restauração  | Abre um submenu para excluir apenas o ponto de restauração mais antigo ou **todos** os pontos de restauração (com confirmação), usando `vssadmin delete shadows`.                                                            |
| 9   | Reiniciar serviço específico            | Abre um submenu com atalhos para reiniciar serviços comuns (Spooler de Impressão, BITS, Windows Search, Windows Audio, Cliente DNS) ou permite digitar manualmente o nome de qualquer outro serviço do Windows.              |
| 10  | Liberar RAM/cache do sistema            | Executa tarefas ociosas do sistema (`ProcessIdleTasks`) e reinicia o `explorer.exe`, liberando o cache de ícones/miniaturas. **Não** é um "otimizador mágico" de memória — apenas auxilia o gerenciamento nativo do Windows. |
| 11  | Executar tarefas básicas (1‑5)          | Executa em sequência as opções 1 a 5 (SFC, CHKDSK, DNS, arquivos temporários e cache do Windows Update), útil para uma manutenção rápida e completa.                                                                         |
| 0   | Sair                                    | Encerra o script.                                                                                                                                                                                                            |

## ⚠️ Avisos importantes

- **Privilégios de administrador**: necessários para todas as tarefas. O script solicita elevação automaticamente (UAC) caso não esteja rodando como Administrador.
- **Ações irreversíveis**: as opções de limpar logs de eventos e excluir pontos de restauração pedem confirmação explícita (digitar `CONFIRMAR`) justamente por serem ações que não podem ser desfeitas.
- **Tempo de execução**: operações como SFC, CHKDSK e desfragmentação podem demorar bastante dependendo do tamanho do disco e da quantidade de arquivos.
- Este script **não substitui um antivírus** nem realiza reparos de hardware — ele apenas automatiza utilitários nativos já presentes no Windows.

## 🗂️ Estrutura do projeto

```
Script Otimiza PC/
├── limpa.bat                 # Menu de otimização e manutenção do Windows
├── instala_ferramentas.bat   # Menu de instalação de ferramentas de trabalho (winget)
├── README.md                 # Resumo do projeto
├── README_LIMPA.md           # Este arquivo — documentação do limpa.bat
└── README_INSTALADOR.md      # Documentação do instala_ferramentas.bat
```

## 📄 Licença

Uso livre e pessoal. Sinta-se à vontade para adaptar o script às suas necessidades.
