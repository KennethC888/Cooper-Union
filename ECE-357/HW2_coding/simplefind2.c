// To compile program: gcc simplefind2.c -o simplefind2
// To run program: 
// ./simplefind2
// ./simplefind2 -l
// ./simplefind2 -n "*.c"
// ./simplefind2 -l /etc

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>      // for system calls
#include <sys/stat.h>    // for file info (stat, lstat)
#include <dirent.h>      // for directory traversal
#include <pwd.h>         // for user info
#include <grp.h>         // for group info
#include <time.h>        
#include <fnmatch.h>     // for filename pattern matching
#include <sys/types.h>
#include <sys/sysmacros.h> // for device numbers
#include <errno.h>       

// Structure to hold options from the command line
typedef struct {
    int show_all;        // -l option
    int stay_on_device;  // -x option
    char *name_pattern;  // -n option
    dev_t start_dev;     // device id of starting path
} Options;


void format_mode(mode_t mode, char str[11]) 
{
    strcpy(str, "----------"); 

    if (S_ISDIR(mode))
    {
        str[0] = 'd';   // directory
    } 
    if (S_ISLNK(mode))
    {
        str[0] = 'l';   // symlink
    } 
    if (S_ISCHR(mode))
    {
        str[0] = 'c';   // character device
    } 
    if (S_ISBLK(mode))
    {
        str[0] = 'b';   // block device
    } 
    if (S_ISSOCK(mode))
    {
        str[0] = 's';   // socket
    } 
    if (S_ISFIFO(mode)) 
    {
        str[0] = 'p';  // pipe (FIFO)
    }

    // User permissions
    if (mode & S_IRUSR)
    {
        str[1] = 'r';
    } 
    if (mode & S_IWUSR)
    {
        str[2] = 'w';
    } 
    if (mode & S_IXUSR)
    {
        str[3] = 'x';
    } 

    // Group permissions
    if (mode & S_IRGRP)
    {
        str[4] = 'r';

    } 
    if (mode & S_IWGRP)
    {
        str[5] = 'w';

    } 
    if (mode & S_IXGRP)
    {
        str[6] = 'x';
    } 
    // Others (world) permissions
    if (mode & S_IROTH)
    {
        str[7] = 'r';
    } 
    if (mode & S_IWOTH)
    {
        str[8] = 'w';
    } 
    if (mode & S_IXOTH)
    {
        str[9] = 'x';
    }

    if (mode & S_ISVTX) //STICKY BIT
    {
        str[9] =  't'; 
    }
}


void print_file_info(const char *path, const struct stat *info) {
    // 1. Inode and Blocks (blocks are 512 bytes → /2 for KB)
    printf("%-8ld %-4ld ", (long)info->st_ino, (long)info->st_blocks / 2);

    // 2. Permissions 
    char mode_str[11];
    format_mode(info->st_mode, mode_str);
    printf("%s ", mode_str);

    // 3. Number of links
    printf("%2ld ", (long)info->st_nlink);

    // 4. Owner and group names
    struct passwd *pw = getpwuid(info->st_uid);
    struct group *gr = getgrgid(info->st_gid);

    if (pw != NULL)
    {
        printf("%-8s ", pw->pw_name);
    }
    else
    {
        printf("%-8d ", info->st_uid);
    }

    if (gr != NULL)
    {
        printf("%-8s ", gr->gr_name);
    }
    else
    {
        printf("%-8d ", info->st_gid);
    }

    // 5. Size or device major/minor
    if (S_ISCHR(info->st_mode) || S_ISBLK(info->st_mode))
    {
        printf("%4d, %4d ", major(info->st_rdev), minor(info->st_rdev));
    } 
    else 
    {
        printf("%8ld ", (long)info->st_size);
    }

    // 6. Last modified time
    char time_buf[80];
    strftime(time_buf, sizeof(time_buf), "%b %e %H:%M", localtime(&info->st_mtime));
    printf("%s ", time_buf);

    // 7. File path
    printf("%s", path);

    // 8. If symlink, print target
    if (S_ISLNK(info->st_mode)) 
    {
        char link_target[1024];
        ssize_t len = readlink(path, link_target, sizeof(link_target) - 1);
        if (len != -1) 
        {
            link_target[len] = '\0';
            printf(" -> %s", link_target);
        }
    }

    printf("\n");
}

//RECURSION
void list_directory(const char *path, const Options *opts) 
{
    DIR *dir;
    struct dirent *entry;

    dir = opendir(path);
    if (dir == NULL) 
    {
        if (errno != ENOTDIR) 
        {
            perror(path); 
        }
        return;
    }

    while ((entry = readdir(dir)) != NULL) 
    {
        // skip "." and ".."
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) 
        {
            continue;
        }
        char full_path[4096];
        snprintf(full_path, sizeof(full_path), "%s/%s", path, entry->d_name);

        struct stat info;
        if (lstat(full_path, &info) == -1) 
        {
            perror(full_path); 
            continue;
        }

        // skip files from other devices if -x given
        if (opts->stay_on_device && info.st_dev != opts->start_dev) 
        {
            continue;
        }

        // check filename match (-n option)
        int name_ok = 1;
        if (opts->name_pattern != NULL) 
        {
            if (fnmatch(opts->name_pattern, entry->d_name, 0) != 0) 
            {
                name_ok = 0;
            }
        }
        // print if matches
        if (name_ok) 
        {
            if (opts->show_all) 
            {
                print_file_info(full_path, &info);
            } 
            else 
            {
                printf("%s\n", full_path);
            }
        }
        // if it is a directory, recurse into it
        if (S_ISDIR(info.st_mode)) 
        {
            list_directory(full_path, opts);
        }
    }
    closedir(dir);
}

int main(int argc, char *argv[]) 
{
    Options opts;
    opts.show_all = 0;
    opts.stay_on_device = 0;
    opts.name_pattern = NULL;
    opts.start_dev = 0;

    int opt;
    char *start_path = "."; // default to current directory

    // parse options
    while ((opt = getopt(argc, argv, "lxn:")) != -1) 
    {
        switch (opt) 
        {
            case 'l':
                opts.show_all = 1;
                break;
            case 'x':
                opts.stay_on_device = 1;
                break;
            case 'n':
                opts.name_pattern = optarg;
                break;
            default:
                fprintf(stderr, "Usage: %s [-l] [-x] [-n pattern] [path]\n", argv[0]);
                exit(EXIT_FAILURE);
        }
    }

    // check if user gave a path
    if (optind < argc) 
    {
        start_path = argv[optind];
    }

    // get info about starting path
    struct stat start_info;
    if (lstat(start_path, &start_info) == -1) 
    {
        perror(start_path);
        exit(EXIT_FAILURE);
    }

    if (opts.stay_on_device) 
    {
        opts.start_dev = start_info.st_dev;
    }

    // check if starting path matches name pattern
    int name_ok = 1;
    if (opts.name_pattern != NULL) 
    {
        const char *base = strrchr(start_path, '/');
        if (base == NULL) 
        {
            base = start_path;
        }
        else 
        {
            base++;
        }

        if (fnmatch(opts.name_pattern, base, 0) != 0) 
        {
            name_ok = 0;
        }
    }

    // print starting path if it matches
    if (name_ok) 
    {
        if (opts.show_all) 
        {
            print_file_info(start_path, &start_info);
        } 
        else 
        {
            printf("%s\n", start_path);
        }
    }

    // if starting path is a directory, explore it
    if (S_ISDIR(start_info.st_mode)) 
    {
        list_directory(start_path, &opts);
    }

    return 0;
}
