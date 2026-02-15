#include "mylib.h"

int main()
{
    struct MYSTREAM *stream = myfopen("test.txt", "r");
    if (!stream) 
    {
        return MY_EOF;
    }
    int c = myfgetc(stream);
    if (c == MY_EOF) 
    {
        myfclose(stream);
        return MY_EOF;
    }

    if (myfputc(c, stream) == MY_EOF) 
    {
        myfclose(stream);
        return MY_EOF;
    }

    if (myfclose(stream) == MY_EOF) 
    {
        return MY_EOF;
    }
    return 0;
}