# claude-skills

Claude Code bulut oturumlarimda kullandigim skill'ler. Ortamin kurulum betigi
her yeni oturumda bu depoyu indirir ve icindeki her seyi kurar.

## Yeni skill eklemek

**Kendi skill'iniz (yalnizca talimat dosyalari):** `skills/` altina bir klasor
ekleyin. Klasorde en az bir `SKILL.md` olmali:

```
skills/
  benim-skill/
    SKILL.md
    references/...   (istege bagli)
```

Klasor adi skill'in adi olur. `SKILL.md` olmayan klasorler atlanir.

**Baska bir GitHub deposundaki skill ya da arac gerektiren skill:**
`install.sh` dosyasina bir satir ekleyin. Ornek:

```bash
github_skill https://github.com/sahip/depo.git <commit> <depodaki-klasor> <skill-adi>
"$NPM" install -g paket@surum >/dev/null 2>&1
```

Degisiklik bir sonraki **yeni** oturumda gecerli olur.

## Dikkat

- Depo **herkese acik**. Icine sifre, token veya gizli bilgi koymayin.
- `install.sh` her oturum acilisinda root olarak calisir; yalnizca guvendiginiz
  komutlari ekleyin.
