# Vessle

A simple "bind shell" written in x86 assembly for Linux.


## About

A bind shell is a program which creates a network-accessible shell such that commands can be executed remotely on the target machine. Bind shells are often used as part of malware payloads, however they also have benign uses. This particular implementation listens for connections on `tcp://0.0.0.0:1234` and is unauthenticated.


## Compile And Run

Compile it with NASM.

```sh
$ nasm -f elf32 -o vessle.o vessle.asm
$ ld -m elf_i386 vessle.o -o vessle
$ rm vessle.o
```

Run it.

```sh
$ ./vessle
```

Connect to the shell on port 1234.

```sh
$ nc -v [target IP] 1234
```
