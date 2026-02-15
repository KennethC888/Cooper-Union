#ifndef MYLIB_H_
#define MYLIB_H_

#define MY_EOF (-1)
#define MY_BUFSIZ 4096 // A common buffer size, often 4K

// Custom stream structure for mylib
struct MYSTREAM {
    int fd;           // File descriptor
    char mode;        // 'r' or 'w'
    char *buf;        // Buffer pointer
    int bufpos;       // Current position in buffer
    int buflen;       // Number of valid bytes in buffer for reading
};

// Function Prototypes
struct MYSTREAM *myfopen(const char *pathname, const char *mode);
struct MYSTREAM *myfdopen(int filedesc, const char *mode);
int myfgetc(struct MYSTREAM *stream);
int myfputc(int c, struct MYSTREAM *stream);
int myfclose(struct MYSTREAM *stream);

#endif /* MYLIB_H_ */