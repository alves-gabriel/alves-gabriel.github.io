# Repository Guide

This repository builds a GitHub Pages site with Jekyll.

## Architecture

- Shared HTML lives in `_layouts/` and `_includes/`.
- Site navigation is data-driven from `_data/navigation.yml`.
- Homepage news items are data-driven from `_data/news.yml`.
- Personal notes are collection metadata in `_notes/`; each note points to a PDF and cover image in `assets/`.
- Coding/tutorial posts are collection documents in `_coding/`, grouped by the `section` front matter field.
- Static images, PDFs, and legacy ray-tracer assets live in `staticfiles/`, `assets/`, and `haskell_ray_tracer/`.

## Design Constraints

- Keep the current academic site style: light background, Bootstrap grid, fixed dark header, muted blue accents, and a profile card on the homepage.
- Prefer small, direct CSS changes in `staticfiles/css/main.css`.
- Do not reintroduce jQuery-based partial loading or browser-side Markdown rendering with `zero-md`.
- Use Jekyll layouts/includes and Liquid loops instead of duplicating page shells.

## Content Rules

- Add a new PDF note by creating a file in `_notes/` with `title`, `year`, `language`, `order`, `pdf`, and `cover`.
- Add a new coding post by creating a Markdown file under `_coding/<section>/` with `title`, `section`, and `order`.
- Use `mathjax: true` in front matter for pages that need TeX rendering.
- Keep old public URLs working when reasonable; use lightweight redirect pages for renamed legacy pages.

## Verification

- Run `bundle exec jekyll build` if a bundle is available.
- Otherwise run `jekyll build` if Jekyll is installed globally.
- Check generated links under `_site/` for `/notes/`, `/coding/`, and a representative coding post.
