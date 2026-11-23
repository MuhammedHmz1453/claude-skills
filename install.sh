#!/usr/bin/env bash
# Disaridan indirilen skill'ler ve gerektirdikleri araclar.
# Her oturum acilisinda ortamin kurulum betigi tarafindan calistirilir.
# Kendi skill'leriniz icin burayi degil, skills/ klasorunu kullanin.
SK="${SK:-${HOME:-/root}/.claude/skills}"; mkdir -p "$SK"
NPM=$(command -v npm || echo /opt/node22/bin/npm)

# GitHub deposunun bir klasorunu sabit commit'ten indirip skill olarak kurar.
# kullanim: github_skill <depo-url> <commit> <depodaki-klasor> <skill-adi>
github_skill() {
  local T; T=$(mktemp -d)
  if git -C "$T" init -q && git -C "$T" fetch -q --depth 1 "$1" "$2" && git -C "$T" checkout -q FETCH_HEAD; then
    rm -rf "$SK/$4"; cp -r "$T/$3" "$SK/$4"
  fi
  rm -rf "$T"
}

# caveman (sabit commit a192894)
for s in caveman ultracave megacave; do
  github_skill https://github.com/juliusbrussee/caveman.git a192894723a8f47e7f504c7b5041967ff1f18e55 "skills/$s" "$s"
done

# agent-browser (sabit surum 0.43.0; hazir Chromium'u kullanir)
if "$NPM" install -g agent-browser@0.43.0 >/dev/null 2>&1; then
  AB="${HOME:-/root}/.agent-browser"; mkdir -p "$AB"
  [ -x /opt/pw-browsers/chromium ] && printf '{\n  "executablePath": "/opt/pw-browsers/chromium"\n}\n' > "$AB/config.json"
  rm -rf "$SK/agent-browser"; cp -r "$("$NPM" root -g)/agent-browser/skills/agent-browser" "$SK/agent-browser"
fi

# seo-audit + seomator CLI (sabit commit f43ba12, CLI 8.0.1)
# Not: bulut oturumlarinda denetim calismaz (arac proxy kullanmiyor).
"$NPM" install -g @seomator/seo-audit@8.0.1 >/dev/null 2>&1
github_skill https://github.com/seo-skills/seo-audit-skill.git f43ba12d65898cea8f043ec2d87fc413c4ca9e0c skill seo-audit
rm -f "$SK/seo-audit/README.md"

true
