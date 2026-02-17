# Maintenance Guide

## Directory Structure

```
config/
├── base.keymap          # Upstream base (DO NOT MODIFY)
├── combos.dtsi          # Upstream combos (DO NOT MODIFY)
├── leader.dtsi          # Upstream leader keys (DO NOT MODIFY)
├── mouse.dtsi           # Upstream mouse config (DO NOT MODIFY)
├── corne.keymap         # Corne 36-key wrapper (CUSTOM)
├── corne.conf           # Corne config (CUSTOM)
└── variants/            # Custom variants (CUSTOM)
    ├── sh_base.keymap   # Custom timing variant
    └── README.md        # Variant documentation
```

## Monthly Sync Routine

1. **Fetch upstream changes:**
   ```bash
   git fetch upstream
   ```

2. **Check what's new:**
   ```bash
   git log --oneline HEAD..upstream/main
   ```

3. **Merge upstream:**
   ```bash
   git merge upstream/main
   ```

4. **Resolve conflicts (if any):**
   - Always keep upstream versions of: `base.keymap`, `combos.dtsi`, `leader.dtsi`, `mouse.dtsi`
   - Manually merge if `variants/sh_base.keymap` conflicts
   - Test build after merge

5. **Test builds:**
   ```bash
   just build corne
   ```

6. **Commit and push:**
   ```bash
   git commit -m "chore: sync with upstream"
   git push origin main
   ```

## What's Custom vs Upstream

### From Upstream (do not modify)
- `base.keymap`, `combos.dtsi`, `leader.dtsi`, `mouse.dtsi`
- Nix/Just build system (`flake.nix`, `Justfile`)
- GitHub Actions workflows (`.github/workflows/`)
- ZMK module configuration (`west.yml` - except zmk-nodefree-config addition)

### Custom (safe to modify)
- `config/corne.keymap` and `config/corne.conf`
- `config/variants/sh_base.keymap`
- `build.yaml` (Corne build targets)
- This `MAINTAINING.md` file
- Custom sections in `README.md`

## Build System

Uses Nix + Just for reproducible builds:

- **`just init`** - Initialize West workspace (first time setup)
- **`just build corne`** - Build Corne firmware
- **`just clean`** - Clean build cache
- **`just update`** - Update ZMK dependencies
- **`just list`** - List all build targets
- **`just draw`** - Draw keymap diagram (requires keymap-drawer config)

## Troubleshooting

### Build fails with module not found
**Solution:** Run `just init` to initialize West workspace

### Merge conflict in base.keymap
**Solution:** Always use upstream version:
```bash
git checkout upstream/main -- config/base.keymap
```

### Custom timing not working
**Solution:** Verify `corne.keymap` includes `variants/sh_base.keymap` not `base.keymap`

### Firmware not building
**Solution:**
1. Clean build cache: `just clean`
2. Update dependencies: `just update`
3. Reinitialize workspace: `rm -rf .west modules zmk zephyr && just init`

## Checking for Upstream Updates

Run the sync checker script:
```bash
./scripts/check-upstream.sh
```

This will show how many commits behind upstream you are and display recent changes.

## Backup Strategy

Before any major sync or changes:
```bash
git tag -a backup-$(date +%Y%m%d) -m "Backup before changes"
git push origin backup-$(date +%Y%m%d)
```

## Contributing Back to Upstream

If you develop features that would benefit the upstream project:

1. Test thoroughly with your keyboard
2. Create a branch from latest upstream
3. Cherry-pick your changes
4. Open a PR to urob/zmk-config

Potential candidates:
- Improvements to Corne configuration
- Bug fixes in shared modules
- Documentation improvements

## Monthly Checklist

- [ ] Fetch upstream changes
- [ ] Review changelog/commits
- [ ] Merge upstream
- [ ] Test build locally
- [ ] Flash and test on hardware
- [ ] Push to origin
- [ ] Update this checklist date: Last synced [DATE]

---

**Last synced:** 2026-02-17
