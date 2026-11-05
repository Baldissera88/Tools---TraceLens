I built a free, open source CMTrace alternative: Trace Lens (big files, ETL, highlights, remote logs)

Hi all,

I work with ConfigMgr and Intune every day, and I got tired of CMTrace freezing on large logs and of opening ten windows to follow one app deployment. So I built my own log viewer, Trace Lens, and I'm sharing it for free under the MIT license.

What it does:

- Opens big logs fast. Files are read in the background and only visible rows are drawn, so a 500 MB log doesn't lock up the window.
- Reads CMTrace (ConfigMgr and Intune IME), SMS trace, CBS, DISM, Panther and plain text logs, plus Windows Update ETL files directly, no Get-WindowsUpdateLog needed.
- Browse logs finds the usual folders for you: site server, MP, DP, console, client, ccmsetup, SMSTSLog, IME and Windows logs, locally or on another machine through the admin shares.
- Connect as: read logs on a server with your admin account without Run as.
- Merges several logs by time, and auto-merges rolled-over parts (.lo_, dated copies, CbsPersist, WindowsUpdate.*.etl).
- Live tail that survives rollover.
- Filters on text/regex, severity, component, thread and time. F8 jumps to the next error.
- Your own highlight rules with colours, for example Detection, Download or Exit code. F7 jumps between them.
- Explains HRESULT, Win32, MSI, WU and ConfigMgr error codes, and codes in the message are clickable.
- Line numbers, light and dark theme, and it only asks for admin rights when a log needs it.

It's a single exe with no dependencies (.NET Framework 4.5, so it runs on Windows 10/11 and Server 2016+). There's also an MSI for Intune or ConfigMgr deployment.


Heads up: the binaries are unsigned for now, so SmartScreen will warn on a downloaded copy. The source is all there if you'd rather build it yourself (build.ps1 uses the compiler that ships with .NET Framework).

I'd love feedback, especially logs that don't parse well (with private info removed) and features you miss from CMTrace or OneTrace.
