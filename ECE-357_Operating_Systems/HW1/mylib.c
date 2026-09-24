#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>
#include "mylib.h"


struct MYSTREAM *myfopen(const char *pathname, const char *mode) {
    int flags;
    int fd;
    // r for read, w for write
    if (strcmp(mode, "r") == 0) {
        flags = O_RDONLY;
    } else if (strcmp(mode, "w") == 0) {
        flags = O_WRONLY | O_CREAT | O_TRUNC;
    } else {
        errno = EINVAL;
        return NULL;
    }
    // Open the file
    fd = open(pathname, flags, 0666);
    if (fd == -1) {
        return NULL;
    }

    return myfdopen(fd, mode);
}
// If there is already an fd, use this to create a MYSTREAM
struct MYSTREAM *myfdopen(int filedesc, const char *mode) {
    if (strcmp(mode, "r") != 0 && strcmp(mode, "w") != 0) {
        errno = EINVAL;
        return NULL;
    }
    // Allocate memory for MYSTREAM
    struct MYSTREAM *stream = (struct MYSTREAM *)malloc(sizeof(struct MYSTREAM));
    if (stream == NULL) {
        return NULL;
    }
    // Allocate memory for buffer
    stream->buf = (char *)malloc(MY_BUFSIZ);
    if (stream->buf == NULL) {
        free(stream);
        return NULL;
    }
    // Pointers to initialize fields
    stream->fd = filedesc;
    stream->mode = mode[0];
    stream->bufpos = 0;
    stream->buflen = 0;

    return stream;
}
// Read a character from the stream
int myfgetc(struct MYSTREAM *stream) {
    if (stream->bufpos >= stream->buflen) {
        ssize_t bytes_read = read(stream->fd, stream->buf, MY_BUFSIZ);
        // No bytes or less than 0 indicates EOF or error
        if (bytes_read < 0) {
            return MY_EOF;
        } else if (bytes_read == 0) {
            errno = 0;
            return MY_EOF;
        }

        stream->buflen = bytes_read;
        stream->bufpos = 0;
    }

    return (unsigned char)stream->buf[stream->bufpos++];
}
// Write a character to the stream
int myfputc(int c, struct MYSTREAM *stream) {
    if (stream->bufpos >= MY_BUFSIZ) {
        ssize_t bytes_written = write(stream->fd, stream->buf, MY_BUFSIZ);

        if (bytes_written < MY_BUFSIZ) {
            return MY_EOF;
        }
        
        stream->bufpos = 0;
    }

    stream->buf[stream->bufpos++] = (char)c;
    
    return c;
}
// Close the stream and free memory
int myfclose(struct MYSTREAM *stream) {
    if (stream == NULL) {
        return MY_EOF;
    }

    if (stream->mode == 'w' && stream->bufpos > 0) {
        ssize_t bytes_written = write(stream->fd, stream->buf, stream->bufpos);
        if (bytes_written < stream->bufpos) {
            free(stream->buf);
            free(stream);
            return MY_EOF;
        }
    }

    int close_status = close(stream->fd);
    
    free(stream->buf);
    free(stream);

    return (close_status == 0) ? 0 : MY_EOF;
}