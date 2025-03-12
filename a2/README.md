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
/home/nicholas_l_le/cs131/a2/test/test_file -> misc
/home/nicholas_l_le/cs131/a2/test/test_file.mp3 -> audios
/home/nicholas_l_le/cs131/a2/test/test_file.mp4 -> videos
/home/nicholas_l_le/cs131/a2/test/test_file.pdf -> documents
/home/nicholas_l_le/cs131/a2/test/test_file.png -> images
/home/nicholas_l_le/cs131/a2/test/test_file.txt -> documents
/home/nicholas_l_le/cs131/a2/test/test_file.zip -> archives
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

Example 2: Organize a directory by file date
```bash
$ tree
.
├── README.md
├── organize.sh
└── test
    ├── month_test.txt
    └── yesterday_test.txt
1 directory, 4 files

$ ./organize.sh test date
/home/nicholas_l_le/cs131/a2/test/month_test.txt -> this_month
/home/nicholas_l_le/cs131/a2/test/yesterday_test.txt -> this_week
Files organized successfully.

$ tree
.
├── README.md
├── organize.sh
└── test
    ├── this_month
    │   └── month_test.txt
    └── this_week
        └── yesterday_test.txt
3 directories, 4 files
```

Example 3: Organize a directory by file size
```bash
$ tree
.
├── README.md
├── organize.sh
└── test
    ├── 1mb_test.txt
    └── 20mb_test.txt
1 directory, 4 files

$ ./organize.sh test size
/home/nicholas_l_le/cs131/a2/test/1mb_test.txt -> medium
/home/nicholas_l_le/cs131/a2/test/20mb_test.txt -> large
Files organized successfully.

$ tree
.
├── README.md
├── organize.sh
└── test
    ├── large
    │   └── 20mb_test.txt
    └── medium
        └── 1mb_test.txt
3 directories, 4 files
```

## Notes
- Works on both Linux and macOS
- Original file names are preserved
- Skips the organizing script itself
- Creates category folders automatically
