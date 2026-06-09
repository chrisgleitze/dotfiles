# Dotfiles TODOs für Ubuntu WSL

## 15 Verbesserungsvorschläge

1. **Bootstrap-Skript + Makefile ergänzen**
   - `install.sh` oder `Makefile` für Paketinstallation, Submodule und Stow.
   - Erst `stow --simulate`, dann echte Installation.

2. **WSL-Konfigurations-Templates versionieren**
   - `wsl/wsl.conf.example` und `windows/.wslconfig.example` hinzufügen.
   - Beispiele: `systemd=true`, `appendWindowsPath=false`, Automount-Optionen, RAM/CPU/DNS.

3. **Linux-Dateisystem als Policy dokumentieren**
   - README-Hinweis: Projekte in `~/projects`, nicht in `/mnt/c/...`.
   - Optional zsh-Warnung bei Git/npm-Projekten unter `/mnt/c`.

4. **WSL-Backup-/Restore-Anleitung hinzufügen**
   - README-Abschnitt oder PowerShell-Beispiel mit `wsl --export` und `wsl --import`.

5. **Hardcodings entfernen**
   - `/home/chris/...` durch `$HOME`, `~`, `command -v` oder Templates ersetzen.
   - Besonders in `.zshrc`, `.gitconfig` und `local-bin/.local/bin/nvim`.

6. **`.zshrc` modularisieren**
   - Aufteilen in z. B. `env.zsh`, `path.zsh`, `aliases.zsh`, `functions.zsh`, `git.zsh`, `fzf.zsh`.

7. **`compaudit`-Override prüfen**
   - Aktuell wird `compaudit()` komplett übersprungen.
   - Besser: Startup-Optimierung beibehalten, aber Sicherheitsrisiko dokumentieren oder periodischen Audit ermöglichen.

8. **Shell-Startup messen**
   - `scripts/bench-shell.sh` ergänzen.
   - Mehrere `zsh -i -c exit`-Runs und optional `zmodload zsh/zprof` nutzen.

9. **Runtime-Manager konsolidieren**
   - Prüfen, ob `mise` NVM/Deno/Bun/andere Tool-Setups vereinfachen kann.

10. **`direnv` für Projekt-Umgebungen nutzen**
    - `eval "$(direnv hook zsh)"` am Ende der `.zshrc`.
    - Projekt-spezifische Umgebungen über `.envrc` statt globale Shell-Variablen.

11. **Shell-Skripte robuster machen**
    - `set -euo pipefail`, `read -r`, Quoting und Fehlerbehandlung ergänzen.
    - `git-push-fast.sh`: verdächtiges `popd` ohne `pushd` prüfen.
    - `git-push.sh`: Branch und Commit-Message sicherer behandeln.

12. **ShellCheck und shfmt integrieren**
    - `shellcheck` für statische Analyse.
    - `shfmt` für einheitliche Formatierung.
    - Optional `pre-commit` oder CI-Workflow hinzufügen.

13. **Neovim-Updater sicherer machen**
    - Stable als Default statt Nightly.
    - Architektur erkennen, Download in `mktemp -d`, Cleanup und Checksums ergänzen.
    - Wrapper in `local-bin/.local/bin/nvim` robuster machen.

14. **Git-Konfig erweitern**
    - Mögliche Optionen:
      - `init.defaultBranch = main`
      - `fetch.prune = true`
      - `rerere.enabled = true`
      - `pull.ff = only` oder bewusst `pull.rebase = true`
      - `safe.bareRepository = explicit`

15. **tmux ↔ Windows-Clipboard integrieren**
    - OSC52/`set-clipboard external` prüfen.
    - Alternativ WSL-spezifische Bindings mit `clip.exe`.

## Mögliche Priorisierung

1. Skripte absichern: ShellCheck, shfmt, `git-push*.sh`, Updater.
2. Reproduzierbarkeit: Makefile/Bootstrap, WSL-Templates, README.
3. Wartbarkeit: `.zshrc` modularisieren, Hardcodings entfernen.
4. Komfort: tmux-Clipboard, direnv, mise, Startup-Benchmarking.

## System-Audit vom 2026-06-09/10

### Befund

- Ubuntu `24.04.4 LTS` unter WSL2 läuft grundsätzlich sauber.
- `systemd` ist aktiv; keine fehlgeschlagenen Units gefunden.
- `tmux 3.6b`, Git `2.54.0`, GitHub CLI `2.93.0`, Docker Engine `29.5.3` und DDEV `1.25.2` sind aktuell bzw. unauffällig.
- Shell-Startzeit ist gut: ca. `0.08–0.15s` für `zsh -i -c exit`.
- Linux-Dateisystem hat viel freien Platz: ca. `36G / 1007G` belegt.
- Windows-Laufwerke auffällig:
  - `/mnt/d`: ca. `94%` belegt.
  - `/mnt/f`: ca. `98%` belegt.

### Priorisierte Verbesserungen

1. **Node.js auf aktuelle LTS-Version aktualisieren**
   - Aktuell: `node v18.20.7`.
   - Node 18 ist EOL; auf Node 24 LTS wechseln.
   - Beispiel:
     ```sh
     nvm install 24
     nvm alias default 24
     ```
   - Node 18 nur für Altprojekte behalten, falls nötig.

2. **Docker-Altlasten bereinigen**
   - Befund:
     - Images: ca. `7.765GB`, davon ca. `1.752GB` reclaimable.
     - 15 gestoppte Container, teils 3–10 Monate alt.
     - Build Cache: ca. `2.251GB`.
   - Sicherer erster Schritt:
     ```sh
     docker container prune
     docker image prune
     ```
   - Vorsicht mit Volumes, da dort DDEV-/Datenbankdaten liegen können.

3. **Apache nur aktiv lassen, wenn wirklich benötigt**
   - Apache lauscht auf `*:80`.
   - Falls nicht gebraucht:
     ```sh
     sudo systemctl disable --now apache2
     ```

4. **Next.js-Dev-Server prüfen**
   - Offene Ports: `*:3001`, `*:3002`, `*:3003`.
   - Falls nur lokal benötigt, möglichst an `127.0.0.1` binden statt an `*`.

5. **WSL-PATH entschlacken**
   - Aktuell `appendWindowsPath=true`; PATH enthält ca. 45 Einträge und viele Windows-Pfade.
   - Option für `/etc/wsl.conf`:
     ```ini
     [interop]
     appendWindowsPath=false
     ```
   - Danach nur benötigte Windows-Tools gezielt ergänzen.

6. **Caches aufräumen**
   - Große Kandidaten:
     - `~/.npm`: ca. `7.0G`
     - `~/.npm/_cacache`: ca. `6.7G`
     - `~/.cache`: ca. `2.6G`
     - `~/.rustup`: ca. `2.6G`
     - `~/.nvm`: ca. `3.2G`
   - Mögliche Befehle:
     ```sh
     npm cache verify
     npm cache clean --force
     rm -rf ~/.npm/_npx/*
     rustup toolchain list
     rustup toolchain uninstall 1.82
     ```
   - Rust-Toolchain `1.82` nur entfernen, wenn kein Projekt sie benötigt.

7. **Neovim Nightly bewusst machen**
   - Aktuell: `NVIM v0.13.0-dev`.
   - Wenn Stabilität wichtiger ist: Updater auf Stable als Default umstellen.
   - Wenn Nightly bewusst genutzt wird: im Dotfiles-README dokumentieren.

8. **apt Phased Updates nicht erzwingen**
   - Zurückgestellt waren:
     - `alsa-ucm-conf`
     - `libxmlb2`
   - Empfehlung: später normal erneut aktualisieren; nicht erzwingen.

9. **`apt autoremove` vorsichtig behandeln**
   - Simulation würde u. a. `xxd` entfernen.
   - Falls `xxd` bleiben soll:
     ```sh
     sudo apt-mark manual xxd
     ```

10. **Ubuntu Pro optional prüfen**
    - System ist nicht an Ubuntu Pro angebunden.
    - Für normale Nutzung nicht zwingend; kann aber zusätzliche Security Updates für Universe-Pakete liefern.

### Nächste sinnvolle Reihenfolge

1. Node 24 LTS installieren und als Default setzen.
2. Docker-Container und ungenutzte Images bereinigen.
3. Apache deaktivieren, falls nicht gebraucht.
4. npm-/npx-Caches bereinigen.
5. `xxd` als manuell installiert markieren, bevor irgendwann `apt autoremove` läuft.
6. WSL-PATH/Interop-Policy in Dotfiles dokumentieren und ggf. anpassen.
