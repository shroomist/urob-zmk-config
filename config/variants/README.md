# Keymap Variants

This directory contains alternative keymap configurations that build on upstream's base.keymap.

## sh_base.keymap

Custom variant with shorter tap timing for faster typing:
- **Tapping term**: 200ms (vs upstream's 280ms)
- **Layer structure**: 8 layers including Unicode layer
- **Features**: Greek/German unicode chars, custom combos
- **Target users**: Those who prefer more responsive key timing

To use this variant, configure your keyboard's .keymap file to include:
```c
#include "variants/sh_base.keymap"
```

## Customization Strategy

Variants should:
1. Import behaviors and modules from upstream
2. Override specific timing/behavior parameters
3. Document differences clearly
4. Remain compatible with upstream updates
