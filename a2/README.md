# Organize Command

A command-line tool that automatically organizes directories by sorting files into categorized folders.

## When to use this/Why use this?
- Quickly categorize directories with different file types
- Organize files by size
- Organize files by date

## Usage
```bash
./organize.sh <directory> <mode>
```

### Modes
- `ext`: Group by file type
  - images (jpg, png, gif, etc.)
  - documents (pdf, doc, txt, etc.)
  - code (py, js, cpp, etc.)
  - audio (mp3, wav, etc.)
  - video (mp4, avi, etc.)
  - archives (zip, tar, etc.)
  - misc (other types)

- `size`: Group by file size
  - tiny (< 1KB)
  - small (1KB - 1MB)
  - medium (1MB - 10MB)
  - large (10MB - 100MB)
  - huge (> 100MB)

- `date`: Group by modification time
  - today
  - this_week
  - this_month
  - this_year
  - over_a_year_ago

## Examples

Example 1: Organize a directory by file type
```bash
$ tree 
.
├── README.md
├── organize.sh
└── test
    ├── test_file
    ├── test_file.mp3
    ├── test_file.mp4
    ├── test_file.pdf
    ├── test_file.png
    ├── test_file.txt
    └── test_file.zip
2 directories, 9 files

$ ./organize.sh test ext
test/test_file -> misc
test/test_file.mp3 -> audios
test/test_file.mp4 -> videos
test/test_file.pdf -> documents
test/test_file.png -> images
test/test_file.txt -> documents
test/test_file.zip -> archives
Files organized successfully.

$ tree                  
.
├── README.md
├── organize.sh
└── test
    ├── archives
    │   └── test_file.zip
    ├── audios
    │   └── test_file.mp3
    ├── documents
    │   ├── test_file.pdf
    │   └── test_file.txt
    ├── images
    │   └── test_file.png
    ├── misc
    │   └── test_file
    └── videos
        └── test_file.mp4
8 directories, 9 files
```

## Notes
- Works on both Linux and macOS
- Original file names are preserved
- Skips the organizing script itself
- Creates category folders automatically