## Windows 7 Patch ISRG Root X1
### What is this
Windows 7 has ended its support and there is an issue when opening website that's using letsencrypt in chrome. To make sure it can open the page again in chrome this certificate is needed to be added in system https://letsencrypt.org/docs/dst-root-ca-x3-expiration-september-2021/

## How To Use
### Note
This is personal purpose and I won't update it according to your request, if it's not working I'll update it later since it's my first commit, this note will be deleted after I validate the script, thank you.

### Batch File Version
1. download this repo or just take script.bat and isrgrootx1.crt . If you're worry of the crt file included here, you can also download it directly from https://letsencrypt.org/certs/isrgrootx1.pem and rename the extension to .crt
2. Open the batch file, if error, right click, run as admin

### Zig version
1. install zig lang, any method, personally I use scoop to make my life easier a bit by using `scoop install zig`
2. download/clone the repo
3. navigate to the repo directory
4. use terminal (cmd/powershell), build the executable using `zig build-exe --strip -target i386-windows-msvc main.zig`. this will build 32 bit app to make sure it's compatible with windows 7 32-bit and 64-bit, one executable for both :D
5. run/distribute the exe anywhere you want it.