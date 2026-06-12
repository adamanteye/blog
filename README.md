# Adamanteye's Blog

A simple static blog framework built with Typst and Make.

It turns files in `src/` into HTML pages in `build/`.
Each post is plain text with small metadata files.

## Build

```bash
make build
```

## Writing a Post

```bash
make TITLE=your-title post
make TITLE=your-title slide
```

## Production Build

```bash
make -j$(nproc) MINIFY=y full
```

## Build PDF

```bash
make build/2026/03/03-particles-griffiths-homework/index.pdf
```

Or

```bash
make pdf
```
