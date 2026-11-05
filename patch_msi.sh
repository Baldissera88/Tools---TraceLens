#!/bin/sh
set -e
msi="$1"
work=$(mktemp -d)
cd "$work"
for t in Directory File Shortcut; do msiinfo export "$msi" $t > $t.idt; done
python3 - <<'PY'
def patch(name, fn):
    lines = open(name + '.idt', newline='').read().split('\r\n')
    out = lines[:3] + [fn(l.split('\t')) for l in lines[3:] if l] + ['']
    open(name + '.idt', 'w', newline='').write('\r\n'.join(out))
def d(c):
    if c[0] == 'INSTALLDIR': c[2] = 'TRACELNS|Trace Lens'
    return '\t'.join(c)
def f(c):
    if c[0] == 'TraceLensExe': c[2] = 'TRACELNS.EXE|TraceLens.exe'
    return '\t'.join(c)
def s(c):
    if c[0] == 'StartMenuShortcut':
        c[2] = 'TRACELNS|Trace Lens'
        c[4] = '[#TraceLensExe]'
    return '\t'.join(c)
patch('Directory', d); patch('File', f); patch('Shortcut', s)
PY
msibuild "$msi" -i Directory.idt File.idt Shortcut.idt
rm -rf "$work"
