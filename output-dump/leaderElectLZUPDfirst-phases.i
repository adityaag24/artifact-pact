
/*[]*/
typedef long unsigned int size_t;
/*[]*/
typedef __builtin_va_list __gnuc_va_list;
/*[]*/
typedef unsigned char __u_char;
/*[]*/
typedef unsigned short int __u_short;
/*[]*/
typedef unsigned int __u_int;
/*[]*/
typedef unsigned long int __u_long;
/*[]*/
typedef signed char __int8_t;
/*[]*/
typedef unsigned char __uint8_t;
/*[]*/
typedef signed short int __int16_t;
/*[]*/
typedef unsigned short int __uint16_t;
/*[]*/
typedef signed int __int32_t;
/*[]*/
typedef unsigned int __uint32_t;
/*[]*/
typedef signed long int __int64_t;
/*[]*/
typedef unsigned long int __uint64_t;
/*[]*/
typedef __int8_t __int_least8_t;
/*[]*/
typedef __uint8_t __uint_least8_t;
/*[]*/
typedef __int16_t __int_least16_t;
/*[]*/
typedef __uint16_t __uint_least16_t;
/*[]*/
typedef __int32_t __int_least32_t;
/*[]*/
typedef __uint32_t __uint_least32_t;
/*[]*/
typedef __int64_t __int_least64_t;
/*[]*/
typedef __uint64_t __uint_least64_t;
/*[]*/
typedef long int __quad_t;
/*[]*/
typedef unsigned long int __u_quad_t;
/*[]*/
typedef long int __intmax_t;
/*[]*/
typedef unsigned long int __uintmax_t;
/*[]*/
typedef unsigned long int __dev_t;
/*[]*/
typedef unsigned int __uid_t;
/*[]*/
typedef unsigned int __gid_t;
/*[]*/
typedef unsigned long int __ino_t;
/*[]*/
typedef unsigned long int __ino64_t;
/*[]*/
typedef unsigned int __mode_t;
/*[]*/
typedef unsigned long int __nlink_t;
/*[]*/
typedef long int __off_t;
/*[]*/
typedef long int __off64_t;
/*[]*/
typedef int __pid_t;
/*[]*/
struct stUn_ivp0 {
    int __val[2];
} ;
/*[]*/
typedef struct stUn_ivp0 __fsid_t;
/*[]*/
typedef long int __clock_t;
/*[]*/
typedef unsigned long int __rlim_t;
/*[]*/
typedef unsigned long int __rlim64_t;
/*[]*/
typedef unsigned int __id_t;
/*[]*/
typedef long int __time_t;
/*[]*/
typedef unsigned int __useconds_t;
/*[]*/
typedef long int __suseconds_t;
/*[]*/
typedef long int __suseconds64_t;
/*[]*/
typedef int __daddr_t;
/*[]*/
typedef int __key_t;
/*[]*/
typedef int __clockid_t;
/*[]*/
typedef void *__timer_t;
/*[]*/
typedef long int __blksize_t;
/*[]*/
typedef long int __blkcnt_t;
/*[]*/
typedef long int __blkcnt64_t;
/*[]*/
typedef unsigned long int __fsblkcnt_t;
/*[]*/
typedef unsigned long int __fsblkcnt64_t;
/*[]*/
typedef unsigned long int __fsfilcnt_t;
/*[]*/
typedef unsigned long int __fsfilcnt64_t;
/*[]*/
typedef long int __fsword_t;
/*[]*/
typedef long int __ssize_t;
/*[]*/
typedef long int __syscall_slong_t;
/*[]*/
typedef unsigned long int __syscall_ulong_t;
/*[]*/
typedef __off64_t __loff_t;
/*[]*/
typedef char *__caddr_t;
/*[]*/
typedef long int __intptr_t;
/*[]*/
typedef unsigned int __socklen_t;
/*[]*/
typedef int __sig_atomic_t;
/*[]*/
struct stUn_ivp2 {
    int __count;
    union stUn_ivp1 {
        unsigned int __wch;
        char __wchb[4];
    } __value;
} ;
/*[]*/
typedef struct stUn_ivp2 __mbstate_t;
/*[]*/
struct _G_fpos_t {
    __off_t __pos;
    __mbstate_t __state;
} ;
/*[]*/
typedef struct _G_fpos_t __fpos_t;
/*[]*/
struct _G_fpos64_t {
    __off64_t __pos;
    __mbstate_t __state;
} ;
/*[]*/
typedef struct _G_fpos64_t __fpos64_t;
/*[]*/
struct _IO_FILE ;
/*[]*/
typedef struct _IO_FILE __FILE;
/*[]*/
struct _IO_FILE ;
/*[]*/
typedef struct _IO_FILE FILE;
/*[]*/
struct _IO_FILE ;
/*[]*/
struct _IO_marker ;
/*[]*/
struct _IO_codecvt ;
/*[]*/
struct _IO_wide_data ;
/*[]*/
typedef void _IO_lock_t;
/*[]*/
struct _IO_FILE {
    int _flags;
    char *_IO_read_ptr;
    char *_IO_read_end;
    char *_IO_read_base;
    char *_IO_write_base;
    char *_IO_write_ptr;
    char *_IO_write_end;
    char *_IO_buf_base;
    char *_IO_buf_end;
    char *_IO_save_base;
    char *_IO_backup_base;
    char *_IO_save_end;
    struct _IO_marker *_markers;
    struct _IO_FILE *_chain;
    int _fileno;
    int _flags2;
    __off_t _old_offset;
    unsigned short _cur_column;
    signed char _vtable_offset;
    char _shortbuf[1];
    _IO_lock_t *_lock;
    __off64_t _offset;
    struct _IO_codecvt *_codecvt;
    struct _IO_wide_data *_wide_data;
    struct _IO_FILE *_freeres_list;
    void *_freeres_buf;
    size_t __pad5;
    int _mode;
    char _unused2[15 * sizeof(int) - 4 * sizeof(void *) - sizeof(size_t)];
} ;
/*[]*/
typedef __gnuc_va_list va_list;
/*[]*/
typedef __off_t off_t;
/*[]*/
typedef __ssize_t ssize_t;
/*[]*/
typedef __fpos_t fpos_t;
/*[]*/
extern FILE *stdin;
/*[]*/
extern FILE *stdout;
/*[]*/
extern FILE *stderr;
/*[]*/
extern int remove(const char *__filename);
/*[]*/
extern int rename(const char *__old, const char *__new);
/*[]*/
extern int renameat(int __oldfd, const char *__old , int __newfd , const char *__new);
/*[]*/
extern int fclose(FILE *__stream);
/*[]*/
extern FILE *tmpfile(void );
/*[]*/
extern char *tmpnam(char [20]);
/*[]*/
extern char *tmpnam_r(char __s[20]);
/*[]*/
extern char *tempnam(const char *__dir, const char *__pfx);
/*[]*/
extern int fflush(FILE *__stream);
/*[]*/
extern int fflush_unlocked(FILE *__stream);
/*[]*/
extern FILE *fopen(const char *__restrict __filename, const char *__restrict __modes);
/*[]*/
extern FILE *freopen(const char *__restrict __filename, const char *__restrict __modes , FILE *__restrict __stream);
/*[]*/
extern FILE *fdopen(int __fd, const char *__modes);
/*[]*/
extern FILE *fmemopen(void *__s, size_t __len , const char *__modes);
/*[]*/
extern FILE *open_memstream(char **__bufloc, size_t *__sizeloc);
/*[]*/
extern void setbuf(FILE *__restrict __stream, char *__restrict __buf);
/*[]*/
extern int setvbuf(FILE *__restrict __stream, char *__restrict __buf , int __modes , size_t __n);
/*[]*/
extern void setbuffer(FILE *__restrict __stream, char *__restrict __buf , size_t __size);
/*[]*/
extern void setlinebuf(FILE *__stream);
/*[]*/
extern int fprintf(FILE *__restrict __stream, const char *__restrict __format, ...);
/*[]*/
extern int printf(const char *__restrict __format, ...);
/*[]*/
extern int sprintf(char *__restrict __s, const char *__restrict __format, ...);
/*[]*/
extern int vfprintf(FILE *__restrict __s, const char *__restrict __format , __gnuc_va_list __arg);
/*[]*/
extern int vprintf(const char *__restrict __format, __gnuc_va_list __arg);
/*[]*/
extern int vsprintf(char *__restrict __s, const char *__restrict __format , __gnuc_va_list __arg);
/*[]*/
extern int snprintf(char *__restrict __s, size_t __maxlen , const char *__restrict __format, ...);
/*[]*/
extern int vsnprintf(char *__restrict __s, size_t __maxlen , const char *__restrict __format , __gnuc_va_list __arg);
/*[]*/
extern int vdprintf(int __fd, const char *__restrict __fmt , __gnuc_va_list __arg);
/*[]*/
extern int dprintf(int __fd, const char *__restrict __fmt, ...);
/*[]*/
extern int fscanf(FILE *__restrict __stream, const char *__restrict __format, ...);
/*[]*/
extern int scanf(const char *__restrict __format, ...);
/*[]*/
extern int sscanf(const char *__restrict __s, const char *__restrict __format, ...);
/*[]*/
extern int fscanf(FILE *__restrict __stream, const char *__restrict __format, ...);
/*[]*/
extern int scanf(const char *__restrict __format, ...);
/*[]*/
extern int sscanf(const char *__restrict __s, const char *__restrict __format, ...);
/*[]*/
extern int vfscanf(FILE *__restrict __s, const char *__restrict __format , __gnuc_va_list __arg);
/*[]*/
extern int vscanf(const char *__restrict __format, __gnuc_va_list __arg);
/*[]*/
extern int vsscanf(const char *__restrict __s, const char *__restrict __format , __gnuc_va_list __arg);
/*[]*/
extern int vfscanf(FILE *__restrict __s, const char *__restrict __format , __gnuc_va_list __arg);
/*[]*/
extern int vscanf(const char *__restrict __format, __gnuc_va_list __arg);
/*[]*/
extern int vsscanf(const char *__restrict __s, const char *__restrict __format , __gnuc_va_list __arg);
/*[]*/
extern int fgetc(FILE *__stream);
/*[]*/
extern int getc(FILE *__stream);
/*[]*/
extern int getchar(void );
/*[]*/
extern int getc_unlocked(FILE *__stream);
/*[]*/
extern int getchar_unlocked(void );
/*[]*/
extern int fgetc_unlocked(FILE *__stream);
/*[]*/
extern int fputc(int __c, FILE *__stream);
/*[]*/
extern int putc(int __c, FILE *__stream);
/*[]*/
extern int putchar(int __c);
/*[]*/
extern int fputc_unlocked(int __c, FILE *__stream);
/*[]*/
extern int putc_unlocked(int __c, FILE *__stream);
/*[]*/
extern int putchar_unlocked(int __c);
/*[]*/
extern int getw(FILE *__stream);
/*[]*/
extern int putw(int __w, FILE *__stream);
/*[]*/
extern char *fgets(char *__restrict __s, int __n , FILE *__restrict __stream);
/*[]*/
extern __ssize_t __getdelim(char **__restrict __lineptr, size_t *__restrict __n , int __delimiter , FILE *__restrict __stream);
/*[]*/
extern __ssize_t getdelim(char **__restrict __lineptr, size_t *__restrict __n , int __delimiter , FILE *__restrict __stream);
/*[]*/
extern __ssize_t getline(char **__restrict __lineptr, size_t *__restrict __n , FILE *__restrict __stream);
/*[]*/
extern int fputs(const char *__restrict __s, FILE *__restrict __stream);
/*[]*/
extern int puts(const char *__s);
/*[]*/
extern int ungetc(int __c, FILE *__stream);
/*[]*/
extern size_t fread(void *__restrict __ptr, size_t __size , size_t __n , FILE *__restrict __stream);
/*[]*/
extern size_t fwrite(const void *__restrict __ptr, size_t __size , size_t __n , FILE *__restrict __s);
/*[]*/
extern size_t fread_unlocked(void *__restrict __ptr, size_t __size , size_t __n , FILE *__restrict __stream);
/*[]*/
extern size_t fwrite_unlocked(const void *__restrict __ptr, size_t __size , size_t __n , FILE *__restrict __stream);
/*[]*/
extern int fseek(FILE *__stream, long int __off , int __whence);
/*[]*/
extern long int ftell(FILE *__stream);
/*[]*/
extern void rewind(FILE *__stream);
/*[]*/
extern int fseeko(FILE *__stream, __off_t __off , int __whence);
/*[]*/
extern __off_t ftello(FILE *__stream);
/*[]*/
extern int fgetpos(FILE *__restrict __stream, fpos_t *__restrict __pos);
/*[]*/
extern int fsetpos(FILE *__stream, const fpos_t *__pos);
/*[]*/
extern void clearerr(FILE *__stream);
/*[]*/
extern int feof(FILE *__stream);
/*[]*/
extern int ferror(FILE *__stream);
/*[]*/
extern void clearerr_unlocked(FILE *__stream);
/*[]*/
extern int feof_unlocked(FILE *__stream);
/*[]*/
extern int ferror_unlocked(FILE *__stream);
/*[]*/
extern void perror(const char *__s);
/*[]*/
extern int fileno(FILE *__stream);
/*[]*/
extern int fileno_unlocked(FILE *__stream);
/*[]*/
extern int pclose(FILE *__stream);
/*[]*/
extern FILE *popen(const char *__command, const char *__modes);
/*[]*/
extern char *ctermid(char *__s);
/*[]*/
extern void flockfile(FILE *__stream);
/*[]*/
extern int ftrylockfile(FILE *__stream);
/*[]*/
extern void funlockfile(FILE *__stream);
/*[]*/
extern int __uflow(FILE *);
/*[]*/
extern int __overflow(FILE *, int );
/*[]*/
typedef int wchar_t;
/*[]*/
struct stUn_ivp3 {
    int quot;
    int rem;
} ;
/*[]*/
typedef struct stUn_ivp3 div_t;
/*[]*/
struct stUn_ivp4 {
    long int quot;
    long int rem;
} ;
/*[]*/
typedef struct stUn_ivp4 ldiv_t;
/*[]*/
__extension__ struct stUn_ivp5 {
    long long int quot;
    long long int rem;
} ;
/*[]*/
__extension__ typedef struct stUn_ivp5 lldiv_t;
/*[]*/
extern size_t __ctype_get_mb_cur_max(void );
/*[]*/
extern double atof(const char *__nptr);
/*[]*/
extern int atoi(const char *__nptr);
/*[]*/
extern long int atol(const char *__nptr);
/*[]*/
__extension__ extern long long int atoll(const char *__nptr);
/*[]*/
extern double strtod(const char *__restrict __nptr, char **__restrict __endptr);
/*[]*/
extern float strtof(const char *__restrict __nptr, char **__restrict __endptr);
/*[]*/
extern long double strtold(const char *__restrict __nptr, char **__restrict __endptr);
/*[]*/
extern long int strtol(const char *__restrict __nptr, char **__restrict __endptr , int __base);
/*[]*/
extern unsigned long int strtoul(const char *__restrict __nptr, char **__restrict __endptr , int __base);
/*[]*/
__extension__ extern long long int strtoq(const char *__restrict __nptr, char **__restrict __endptr , int __base);
/*[]*/
__extension__ extern unsigned long long int strtouq(const char *__restrict __nptr, char **__restrict __endptr , int __base);
/*[]*/
__extension__ extern long long int strtoll(const char *__restrict __nptr, char **__restrict __endptr , int __base);
/*[]*/
__extension__ extern unsigned long long int strtoull(const char *__restrict __nptr, char **__restrict __endptr , int __base);
/*[]*/
extern char *l64a(long int __n);
/*[]*/
extern long int a64l(const char *__s);
/*[]*/
typedef __u_char u_char;
/*[]*/
typedef __u_short u_short;
/*[]*/
typedef __u_int u_int;
/*[]*/
typedef __u_long u_long;
/*[]*/
typedef __quad_t quad_t;
/*[]*/
typedef __u_quad_t u_quad_t;
/*[]*/
typedef __fsid_t fsid_t;
/*[]*/
typedef __loff_t loff_t;
/*[]*/
typedef __ino_t ino_t;
/*[]*/
typedef __dev_t dev_t;
/*[]*/
typedef __gid_t gid_t;
/*[]*/
typedef __mode_t mode_t;
/*[]*/
typedef __nlink_t nlink_t;
/*[]*/
typedef __uid_t uid_t;
/*[]*/
typedef __pid_t pid_t;
/*[]*/
typedef __id_t id_t;
/*[]*/
typedef __daddr_t daddr_t;
/*[]*/
typedef __caddr_t caddr_t;
/*[]*/
typedef __key_t key_t;
/*[]*/
typedef __clock_t clock_t;
/*[]*/
typedef __clockid_t clockid_t;
/*[]*/
typedef __time_t time_t;
/*[]*/
typedef __timer_t timer_t;
/*[]*/
typedef unsigned long int ulong;
/*[]*/
typedef unsigned short int ushort;
/*[]*/
typedef unsigned int uint;
/*[]*/
typedef __int8_t int8_t;
/*[]*/
typedef __int16_t int16_t;
/*[]*/
typedef __int32_t int32_t;
/*[]*/
typedef __int64_t int64_t;
/*[]*/
typedef __uint8_t u_int8_t;
/*[]*/
typedef __uint16_t u_int16_t;
/*[]*/
typedef __uint32_t u_int32_t;
/*[]*/
typedef __uint64_t u_int64_t;
/*[]*/
typedef int register_t;
/*[]*/
/*[]*/
static __inline __uint16_t __bswap_16(__uint16_t __bsx) {
/*[]*/
    /*[]*/
    unsigned short int _imopVarPre21;
    /*[]*/
    _imopVarPre21 = __builtin_bswap16(__bsx);
    /*[]*/
    /*[]*/
    return _imopVarPre21;
}
/*[]*/
/*[]*/
static __inline __uint32_t __bswap_32(__uint32_t __bsx) {
/*[]*/
    /*[]*/
    unsigned int _imopVarPre97;
    /*[]*/
    _imopVarPre97 = __builtin_bswap32(__bsx);
    /*[]*/
    /*[]*/
    return _imopVarPre97;
}
/*[]*/
/*[]*/
__extension__ static __inline __uint64_t __bswap_64(__uint64_t __bsx) {
/*[]*/
    /*[]*/
    unsigned long int _imopVarPre98;
    /*[]*/
    _imopVarPre98 = __builtin_bswap64(__bsx);
    /*[]*/
    /*[]*/
    return _imopVarPre98;
}
/*[]*/
/*[]*/
static __inline __uint16_t __uint16_identity(__uint16_t __x) {
/*[]*/
    /*[]*/
    return __x;
}
/*[]*/
/*[]*/
static __inline __uint32_t __uint32_identity(__uint32_t __x) {
/*[]*/
    /*[]*/
    return __x;
}
/*[]*/
/*[]*/
static __inline __uint64_t __uint64_identity(__uint64_t __x) {
/*[]*/
    /*[]*/
    return __x;
}
/*[]*/
struct stUn_ivp6 {
    unsigned long int __val[(1024 / (8 * sizeof(unsigned long int)))];
} ;
/*[]*/
typedef struct stUn_ivp6 __sigset_t;
/*[]*/
typedef __sigset_t sigset_t;
/*[]*/
struct timeval {
    __time_t tv_sec;
    __suseconds_t tv_usec;
} ;
/*[]*/
struct timespec {
    __time_t tv_sec;
    __syscall_slong_t tv_nsec;
} ;
/*[]*/
typedef __suseconds_t suseconds_t;
/*[]*/
typedef long int __fd_mask;
/*[]*/
struct stUn_ivp7 {
    __fd_mask __fds_bits[1024 / (8 * (int) sizeof(__fd_mask))];
} ;
/*[]*/
typedef struct stUn_ivp7 fd_set;
/*[]*/
typedef __fd_mask fd_mask;
/*[]*/
extern int select(int __nfds, fd_set *__restrict __readfds , fd_set *__restrict __writefds , fd_set *__restrict __exceptfds , struct timeval *__restrict __timeout);
/*[]*/
extern int pselect(int __nfds, fd_set *__restrict __readfds , fd_set *__restrict __writefds , fd_set *__restrict __exceptfds , const struct timespec *__restrict __timeout , const __sigset_t *__restrict __sigmask);
/*[]*/
typedef __blksize_t blksize_t;
/*[]*/
typedef __blkcnt_t blkcnt_t;
/*[]*/
typedef __fsblkcnt_t fsblkcnt_t;
/*[]*/
typedef __fsfilcnt_t fsfilcnt_t;
/*[]*/
union stUn_ivp9 {
    __extension__ unsigned long long int __value64;
    struct stUn_ivp8 {
        unsigned int __low;
        unsigned int __high;
    } __value32;
} ;
/*[]*/
typedef union stUn_ivp9 __atomic_wide_counter;
/*[]*/
struct __pthread_internal_list {
    struct __pthread_internal_list *__prev;
    struct __pthread_internal_list *__next;
} ;
/*[]*/
typedef struct __pthread_internal_list __pthread_list_t;
/*[]*/
struct __pthread_internal_slist {
    struct __pthread_internal_slist *__next;
} ;
/*[]*/
typedef struct __pthread_internal_slist __pthread_slist_t;
/*[]*/
struct __pthread_mutex_s {
    int __lock;
    unsigned int __count;
    int __owner;
    unsigned int __nusers;
    int __kind;
    short __spins;
    short __elision;
    __pthread_list_t __list;
} ;
/*[]*/
struct __pthread_rwlock_arch_t {
    unsigned int __readers;
    unsigned int __writers;
    unsigned int __wrphase_futex;
    unsigned int __writers_futex;
    unsigned int __pad3;
    unsigned int __pad4;
    int __cur_writer;
    int __shared;
    signed char __rwelision;
    unsigned char __pad1[7];
    unsigned long int __pad2;
    unsigned int __flags;
} ;
/*[]*/
struct __pthread_cond_s {
    __atomic_wide_counter __wseq;
    __atomic_wide_counter __g1_start;
    unsigned int __g_refs[2];
    unsigned int __g_size[2];
    unsigned int __g1_orig_size;
    unsigned int __wrefs;
    unsigned int __g_signals[2];
} ;
/*[]*/
typedef unsigned int __tss_t;
/*[]*/
typedef unsigned long int __thrd_t;
/*[]*/
struct stUn_ivp10 {
    int __data;
} ;
/*[]*/
typedef struct stUn_ivp10 __once_flag;
/*[]*/
typedef unsigned long int pthread_t;
/*[]*/
union stUn_ivp11 {
    char __size[4];
    int __align;
} ;
/*[]*/
typedef union stUn_ivp11 pthread_mutexattr_t;
/*[]*/
union stUn_ivp12 {
    char __size[4];
    int __align;
} ;
/*[]*/
typedef union stUn_ivp12 pthread_condattr_t;
/*[]*/
typedef unsigned int pthread_key_t;
/*[]*/
typedef int pthread_once_t;
/*[]*/
union pthread_attr_t {
    char __size[56];
    long int __align;
} ;
/*[]*/
typedef union pthread_attr_t pthread_attr_t;
/*[]*/
union stUn_ivp13 {
    struct __pthread_mutex_s __data;
    char __size[40];
    long int __align;
} ;
/*[]*/
typedef union stUn_ivp13 pthread_mutex_t;
/*[]*/
union stUn_ivp14 {
    struct __pthread_cond_s __data;
    char __size[48];
    __extension__ long long int __align;
} ;
/*[]*/
typedef union stUn_ivp14 pthread_cond_t;
/*[]*/
union stUn_ivp15 {
    struct __pthread_rwlock_arch_t __data;
    char __size[56];
    long int __align;
} ;
/*[]*/
typedef union stUn_ivp15 pthread_rwlock_t;
/*[]*/
union stUn_ivp16 {
    char __size[8];
    long int __align;
} ;
/*[]*/
typedef union stUn_ivp16 pthread_rwlockattr_t;
/*[]*/
typedef volatile int pthread_spinlock_t;
/*[]*/
union stUn_ivp17 {
    char __size[32];
    long int __align;
} ;
/*[]*/
typedef union stUn_ivp17 pthread_barrier_t;
/*[]*/
union stUn_ivp18 {
    char __size[4];
    int __align;
} ;
/*[]*/
typedef union stUn_ivp18 pthread_barrierattr_t;
/*[]*/
extern long int random(void );
/*[]*/
extern void srandom(unsigned int __seed);
/*[]*/
extern char *initstate(unsigned int __seed, char *__statebuf , size_t __statelen);
/*[]*/
extern char *setstate(char *__statebuf);
/*[]*/
struct random_data {
    int32_t *fptr;
    int32_t *rptr;
    int32_t *state;
    int rand_type;
    int rand_deg;
    int rand_sep;
    int32_t *end_ptr;
} ;
/*[]*/
extern int random_r(struct random_data *__restrict __buf, int32_t *__restrict __result);
/*[]*/
extern int srandom_r(unsigned int __seed, struct random_data *__buf);
/*[]*/
extern int initstate_r(unsigned int __seed, char *__restrict __statebuf , size_t __statelen , struct random_data *__restrict __buf);
/*[]*/
extern int setstate_r(char *__restrict __statebuf, struct random_data *__restrict __buf);
/*[]*/
extern int rand(void );
/*[]*/
extern void srand(unsigned int __seed);
/*[]*/
extern int rand_r(unsigned int *__seed);
/*[]*/
extern double drand48(void );
/*[]*/
extern double erand48(unsigned short int __xsubi[3]);
/*[]*/
extern long int lrand48(void );
/*[]*/
extern long int nrand48(unsigned short int __xsubi[3]);
/*[]*/
extern long int mrand48(void );
/*[]*/
extern long int jrand48(unsigned short int __xsubi[3]);
/*[]*/
extern void srand48(long int __seedval);
/*[]*/
extern unsigned short int *seed48(unsigned short int __seed16v[3]);
/*[]*/
extern void lcong48(unsigned short int __param[7]);
/*[]*/
struct drand48_data {
    unsigned short int __x[3];
    unsigned short int __old_x[3];
    unsigned short int __c;
    unsigned short int __init;
    __extension__ unsigned long long int __a;
} ;
/*[]*/
extern int drand48_r(struct drand48_data *__restrict __buffer, double *__restrict __result);
/*[]*/
extern int erand48_r(unsigned short int __xsubi[3], struct drand48_data *__restrict __buffer , double *__restrict __result);
/*[]*/
extern int lrand48_r(struct drand48_data *__restrict __buffer, long int *__restrict __result);
/*[]*/
extern int nrand48_r(unsigned short int __xsubi[3], struct drand48_data *__restrict __buffer , long int *__restrict __result);
/*[]*/
extern int mrand48_r(struct drand48_data *__restrict __buffer, long int *__restrict __result);
/*[]*/
extern int jrand48_r(unsigned short int __xsubi[3], struct drand48_data *__restrict __buffer , long int *__restrict __result);
/*[]*/
extern int srand48_r(long int __seedval, struct drand48_data *__buffer);
/*[]*/
extern int seed48_r(unsigned short int __seed16v[3], struct drand48_data *__buffer);
/*[]*/
extern int lcong48_r(unsigned short int __param[7], struct drand48_data *__buffer);
/*[]*/
extern void *malloc(size_t __size);
/*[]*/
extern void *calloc(size_t __nmemb, size_t __size);
/*[]*/
extern void *realloc(void *__ptr, size_t __size);
/*[]*/
extern void free(void *__ptr);
/*[]*/
extern void *reallocarray(void *__ptr, size_t __nmemb , size_t __size);
/*[]*/
extern void *reallocarray(void *__ptr, size_t __nmemb , size_t __size);
/*[]*/
extern void *alloca(size_t __size);
/*[]*/
extern void *valloc(size_t __size);
/*[]*/
extern int posix_memalign(void **__memptr, size_t __alignment , size_t __size);
/*[]*/
extern void *aligned_alloc(size_t __alignment, size_t __size);
/*[]*/
extern void abort(void );
/*[]*/
extern int atexit(void ( *__func )(void ));
/*[]*/
extern int at_quick_exit(void ( *__func )(void ));
/*[]*/
extern int on_exit(void ( *__func )(int __status, void *__arg), void *__arg);
/*[]*/
extern void exit(int __status);
/*[]*/
extern void quick_exit(int __status);
/*[]*/
extern void _Exit(int __status);
/*[]*/
extern char *getenv(const char *__name);
/*[]*/
extern int putenv(char *__string);
/*[]*/
extern int setenv(const char *__name, const char *__value , int __replace);
/*[]*/
extern int unsetenv(const char *__name);
/*[]*/
extern int clearenv(void );
/*[]*/
extern char *mktemp(char *__template);
/*[]*/
extern int mkstemp(char *__template);
/*[]*/
extern int mkstemps(char *__template, int __suffixlen);
/*[]*/
extern char *mkdtemp(char *__template);
/*[]*/
extern int system(const char *__command);
/*[]*/
extern char *realpath(const char *__restrict __name, char *__restrict __resolved);
/*[]*/
typedef int ( *__compar_fn_t )(const void *, const void *);
/*[]*/
extern void *bsearch(const void *__key, const void *__base , size_t __nmemb , size_t __size , __compar_fn_t __compar);
/*[]*/
extern void qsort(void *__base, size_t __nmemb , size_t __size , __compar_fn_t __compar);
/*[]*/
extern int abs(int __x);
/*[]*/
extern long int labs(long int __x);
/*[]*/
__extension__ extern long long int llabs(long long int __x);
/*[]*/
extern div_t div(int __numer, int __denom);
/*[]*/
extern ldiv_t ldiv(long int __numer, long int __denom);
/*[]*/
__extension__ extern lldiv_t lldiv(long long int __numer, long long int __denom);
/*[]*/
extern char *ecvt(double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign);
/*[]*/
extern char *fcvt(double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign);
/*[]*/
extern char *gcvt(double __value, int __ndigit , char *__buf);
/*[]*/
extern char *qecvt(long double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign);
/*[]*/
extern char *qfcvt(long double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign);
/*[]*/
extern char *qgcvt(long double __value, int __ndigit , char *__buf);
/*[]*/
extern int ecvt_r(double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign , char *__restrict __buf , size_t __len);
/*[]*/
extern int fcvt_r(double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign , char *__restrict __buf , size_t __len);
/*[]*/
extern int qecvt_r(long double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign , char *__restrict __buf , size_t __len);
/*[]*/
extern int qfcvt_r(long double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign , char *__restrict __buf , size_t __len);
/*[]*/
extern int mblen(const char *__s, size_t __n);
/*[]*/
extern int mbtowc(wchar_t *__restrict __pwc, const char *__restrict __s , size_t __n);
/*[]*/
extern int wctomb(char *__s, wchar_t __wchar);
/*[]*/
extern size_t mbstowcs(wchar_t *__restrict __pwcs, const char *__restrict __s , size_t __n);
/*[]*/
extern size_t wcstombs(char *__restrict __s, const wchar_t *__restrict __pwcs , size_t __n);
/*[]*/
extern int rpmatch(const char *__response);
/*[]*/
extern int getsubopt(char **__restrict __optionp, char *const *__restrict __tokens , char **__restrict __valuep);
/*[]*/
extern int getloadavg(double __loadavg[], int __nelem);
/*[]*/
extern void *memcpy(void *__restrict __dest, const void *__restrict __src , size_t __n);
/*[]*/
extern void *memmove(void *__dest, const void *__src , size_t __n);
/*[]*/
extern void *memccpy(void *__restrict __dest, const void *__restrict __src , int __c , size_t __n);
/*[]*/
extern void *memset(void *__s, int __c , size_t __n);
/*[]*/
extern int memcmp(const void *__s1, const void *__s2 , size_t __n);
/*[]*/
extern int __memcmpeq(const void *__s1, const void *__s2 , size_t __n);
/*[]*/
extern void *memchr(const void *__s, int __c , size_t __n);
/*[]*/
extern char *strcpy(char *__restrict __dest, const char *__restrict __src);
/*[]*/
extern char *strncpy(char *__restrict __dest, const char *__restrict __src , size_t __n);
/*[]*/
extern char *strcat(char *__restrict __dest, const char *__restrict __src);
/*[]*/
extern char *strncat(char *__restrict __dest, const char *__restrict __src , size_t __n);
/*[]*/
extern int strcmp(const char *__s1, const char *__s2);
/*[]*/
extern int strncmp(const char *__s1, const char *__s2 , size_t __n);
/*[]*/
extern int strcoll(const char *__s1, const char *__s2);
/*[]*/
extern size_t strxfrm(char *__restrict __dest, const char *__restrict __src , size_t __n);
/*[]*/
struct __locale_struct {
    struct __locale_data *__locales[13];
    const unsigned short int *__ctype_b;
    const int *__ctype_tolower;
    const int *__ctype_toupper;
    const char *__names[13];
} ;
/*[]*/
typedef struct __locale_struct *__locale_t;
/*[]*/
typedef __locale_t locale_t;
/*[]*/
extern int strcoll_l(const char *__s1, const char *__s2 , locale_t __l);
/*[]*/
extern size_t strxfrm_l(char *__dest, const char *__src , size_t __n , locale_t __l);
/*[]*/
extern char *strdup(const char *__s);
/*[]*/
extern char *strndup(const char *__string, size_t __n);
/*[]*/
extern char *strchr(const char *__s, int __c);
/*[]*/
extern char *strrchr(const char *__s, int __c);
/*[]*/
extern size_t strcspn(const char *__s, const char *__reject);
/*[]*/
extern size_t strspn(const char *__s, const char *__accept);
/*[]*/
extern char *strpbrk(const char *__s, const char *__accept);
/*[]*/
extern char *strstr(const char *__haystack, const char *__needle);
/*[]*/
extern char *strtok(char *__restrict __s, const char *__restrict __delim);
/*[]*/
extern char *__strtok_r(char *__restrict __s, const char *__restrict __delim , char **__restrict __save_ptr);
/*[]*/
extern char *strtok_r(char *__restrict __s, const char *__restrict __delim , char **__restrict __save_ptr);
/*[]*/
extern size_t strlen(const char *__s);
/*[]*/
extern size_t strnlen(const char *__string, size_t __maxlen);
/*[]*/
extern char *strerror(int __errnum);
/*[]*/
extern int strerror_r(int __errnum, char *__buf , size_t __buflen);
/*[]*/
extern char *strerror_l(int __errnum, locale_t __l);
/*[]*/
extern int bcmp(const void *__s1, const void *__s2 , size_t __n);
/*[]*/
extern void bcopy(const void *__src, void *__dest , size_t __n);
/*[]*/
extern void bzero(void *__s, size_t __n);
/*[]*/
extern char *index(const char *__s, int __c);
/*[]*/
extern char *rindex(const char *__s, int __c);
/*[]*/
extern int ffs(int __i);
/*[]*/
extern int ffsl(long int __l);
/*[]*/
__extension__ extern int ffsll(long long int __ll);
/*[]*/
extern int strcasecmp(const char *__s1, const char *__s2);
/*[]*/
extern int strncasecmp(const char *__s1, const char *__s2 , size_t __n);
/*[]*/
extern int strcasecmp_l(const char *__s1, const char *__s2 , locale_t __loc);
/*[]*/
extern int strncasecmp_l(const char *__s1, const char *__s2 , size_t __n , locale_t __loc);
/*[]*/
extern void explicit_bzero(void *__s, size_t __n);
/*[]*/
extern char *strsep(char **__restrict __stringp, const char *__restrict __delim);
/*[]*/
extern char *strsignal(int __sig);
/*[]*/
extern char *__stpcpy(char *__restrict __dest, const char *__restrict __src);
/*[]*/
extern char *stpcpy(char *__restrict __dest, const char *__restrict __src);
/*[]*/
extern char *__stpncpy(char *__restrict __dest, const char *__restrict __src , size_t __n);
/*[]*/
extern char *stpncpy(char *__restrict __dest, const char *__restrict __src , size_t __n);
/*[]*/
struct stUn_ivp19 {
    unsigned char _x[4];
} ;
/*[]*/
typedef struct stUn_ivp19 omp_lock_t;
/*[]*/
struct stUn_ivp20 {
    unsigned char _x[8 + sizeof(void *)];
} ;
/*[]*/
typedef struct stUn_ivp20 omp_nest_lock_t;
/*[]*/
enum omp_sched_t {
    omp_sched_static = 1, omp_sched_dynamic = 2 , omp_sched_guided = 3 , omp_sched_auto = 4 , omp_sched_monotonic = 0x80000000U
} ;
/*[]*/
typedef enum omp_sched_t omp_sched_t;
/*[]*/
enum omp_proc_bind_t {
    omp_proc_bind_false = 0, omp_proc_bind_true = 1 , omp_proc_bind_master = 2 , omp_proc_bind_close = 3 , omp_proc_bind_spread = 4
} ;
/*[]*/
typedef enum omp_proc_bind_t omp_proc_bind_t;
/*[]*/
enum omp_sync_hint_t {
    omp_sync_hint_none = 0, omp_lock_hint_none = omp_sync_hint_none , omp_sync_hint_uncontended = 1 , omp_lock_hint_uncontended = omp_sync_hint_uncontended , omp_sync_hint_contended = 2 , omp_lock_hint_contended = omp_sync_hint_contended , omp_sync_hint_nonspeculative = 4 , omp_lock_hint_nonspeculative = omp_sync_hint_nonspeculative , omp_sync_hint_speculative = 8 , omp_lock_hint_speculative = omp_sync_hint_speculative
} ;
/*[]*/
typedef enum omp_sync_hint_t omp_sync_hint_t;
/*[]*/
typedef omp_sync_hint_t omp_lock_hint_t;
/*[]*/
struct omp_depend_t {
    char __omp_depend_t__[2 * sizeof(void *)];
} ;
/*[]*/
typedef struct omp_depend_t omp_depend_t;
/*[]*/
enum omp_pause_resource_t {
    omp_pause_soft = 1, omp_pause_hard = 2
} ;
/*[]*/
typedef enum omp_pause_resource_t omp_pause_resource_t;
/*[]*/
typedef long unsigned int omp_uintptr_t;
/*[]*/
enum omp_memspace_handle_t {
    omp_default_mem_space = 0, omp_large_cap_mem_space = 1 , omp_const_mem_space = 2 , omp_high_bw_mem_space = 3 , omp_low_lat_mem_space = 4 , __omp_memspace_handle_t_max__ = 0xffffffffffffffffUL
} ;
/*[]*/
typedef enum omp_memspace_handle_t omp_memspace_handle_t;
/*[]*/
enum omp_allocator_handle_t {
    omp_null_allocator = 0, omp_default_mem_alloc = 1 , omp_large_cap_mem_alloc = 2 , omp_const_mem_alloc = 3 , omp_high_bw_mem_alloc = 4 , omp_low_lat_mem_alloc = 5 , omp_cgroup_mem_alloc = 6 , omp_pteam_mem_alloc = 7 , omp_thread_mem_alloc = 8 , __omp_allocator_handle_t_max__ = 0xffffffffffffffffUL
} ;
/*[]*/
typedef enum omp_allocator_handle_t omp_allocator_handle_t;
/*[]*/
enum omp_alloctrait_key_t {
    omp_atk_sync_hint = 1, omp_atk_alignment = 2 , omp_atk_access = 3 , omp_atk_pool_size = 4 , omp_atk_fallback = 5 , omp_atk_fb_data = 6 , omp_atk_pinned = 7 , omp_atk_partition = 8
} ;
/*[]*/
typedef enum omp_alloctrait_key_t omp_alloctrait_key_t;
/*[]*/
enum omp_alloctrait_value_t {
    omp_atv_default = (long unsigned int) -1, omp_atv_false = 0 , omp_atv_true = 1 , omp_atv_contended = 3 , omp_atv_uncontended = 4 , omp_atv_serialized = 5 , omp_atv_sequential = omp_atv_serialized , omp_atv_private = 6 , omp_atv_all = 7 , omp_atv_thread = 8 , omp_atv_pteam = 9 , omp_atv_cgroup = 10 , omp_atv_default_mem_fb = 11 , omp_atv_null_fb = 12 , omp_atv_abort_fb = 13 , omp_atv_allocator_fb = 14 , omp_atv_environment = 15 , omp_atv_nearest = 16 , omp_atv_blocked = 17 , omp_atv_interleaved = 18
} ;
/*[]*/
typedef enum omp_alloctrait_value_t omp_alloctrait_value_t;
/*[]*/
struct omp_alloctrait_t {
    omp_alloctrait_key_t key;
    omp_uintptr_t value;
} ;
/*[]*/
typedef struct omp_alloctrait_t omp_alloctrait_t;
/*[]*/
enum omp_event_handle_t {
    __omp_event_handle_t_max__ = 0xffffffffffffffffUL
} ;
/*[]*/
typedef enum omp_event_handle_t omp_event_handle_t;
/*[]*/
extern void omp_set_num_threads(int );
/*[]*/
extern int omp_get_num_threads(void );
/*[]*/
extern int omp_get_max_threads(void );
/*[]*/
extern int omp_get_thread_num(void );
/*[]*/
extern int omp_get_num_procs(void );
/*[]*/
extern int omp_in_parallel(void );
/*[]*/
extern void omp_set_dynamic(int );
/*[]*/
extern int omp_get_dynamic(void );
/*[]*/
extern void omp_set_nested(int );
/*[]*/
extern int omp_get_nested(void );
/*[]*/
extern void omp_init_lock(omp_lock_t *);
/*[]*/
extern void omp_init_lock_with_hint(omp_lock_t *, omp_sync_hint_t );
/*[]*/
extern void omp_destroy_lock(omp_lock_t *);
/*[]*/
extern void omp_set_lock(omp_lock_t *);
/*[]*/
extern void omp_unset_lock(omp_lock_t *);
/*[]*/
extern int omp_test_lock(omp_lock_t *);
/*[]*/
extern void omp_init_nest_lock(omp_nest_lock_t *);
/*[]*/
extern void omp_init_nest_lock_with_hint(omp_nest_lock_t *, omp_sync_hint_t );
/*[]*/
extern void omp_destroy_nest_lock(omp_nest_lock_t *);
/*[]*/
extern void omp_set_nest_lock(omp_nest_lock_t *);
/*[]*/
extern void omp_unset_nest_lock(omp_nest_lock_t *);
/*[]*/
extern int omp_test_nest_lock(omp_nest_lock_t *);
/*[]*/
extern double omp_get_wtime(void );
/*[]*/
extern double omp_get_wtick(void );
/*[]*/
extern void omp_set_schedule(omp_sched_t , int );
/*[]*/
extern void omp_get_schedule(omp_sched_t *, int *);
/*[]*/
extern int omp_get_thread_limit(void );
/*[]*/
extern void omp_set_max_active_levels(int );
/*[]*/
extern int omp_get_max_active_levels(void );
/*[]*/
extern int omp_get_supported_active_levels(void );
/*[]*/
extern int omp_get_level(void );
/*[]*/
extern int omp_get_ancestor_thread_num(int );
/*[]*/
extern int omp_get_team_size(int );
/*[]*/
extern int omp_get_active_level(void );
/*[]*/
extern int omp_in_final(void );
/*[]*/
extern int omp_get_cancellation(void );
/*[]*/
extern omp_proc_bind_t omp_get_proc_bind(void );
/*[]*/
extern int omp_get_num_places(void );
/*[]*/
extern int omp_get_place_num_procs(int );
/*[]*/
extern void omp_get_place_proc_ids(int , int *);
/*[]*/
extern int omp_get_place_num(void );
/*[]*/
extern int omp_get_partition_num_places(void );
/*[]*/
extern void omp_get_partition_place_nums(int *);
/*[]*/
extern void omp_set_default_device(int );
/*[]*/
extern int omp_get_default_device(void );
/*[]*/
extern int omp_get_num_devices(void );
/*[]*/
extern int omp_get_num_teams(void );
/*[]*/
extern int omp_get_team_num(void );
/*[]*/
extern int omp_is_initial_device(void );
/*[]*/
extern int omp_get_initial_device(void );
/*[]*/
extern int omp_get_max_task_priority(void );
/*[]*/
extern void omp_fulfill_event(omp_event_handle_t );
/*[]*/
extern void *omp_target_alloc(long unsigned int , int );
/*[]*/
extern void omp_target_free(void *, int );
/*[]*/
extern int omp_target_is_present(const void *, int );
/*[]*/
extern int omp_target_memcpy(void *, const void * , long unsigned int  , long unsigned int  , long unsigned int  , int  , int );
/*[]*/
extern int omp_target_memcpy_rect(void *, const void * , long unsigned int  , int  , const long unsigned int * , const long unsigned int * , const long unsigned int * , const long unsigned int * , const long unsigned int * , int  , int );
/*[]*/
extern int omp_target_associate_ptr(const void *, const void * , long unsigned int  , long unsigned int  , int );
/*[]*/
extern int omp_target_disassociate_ptr(const void *, int );
/*[]*/
extern void omp_set_affinity_format(const char *);
/*[]*/
extern long unsigned int omp_get_affinity_format(char *, long unsigned int );
/*[]*/
extern void omp_display_affinity(const char *);
/*[]*/
extern long unsigned int omp_capture_affinity(char *, long unsigned int  , const char *);
/*[]*/
extern int omp_pause_resource(omp_pause_resource_t , int );
/*[]*/
extern int omp_pause_resource_all(omp_pause_resource_t );
/*[]*/
extern omp_allocator_handle_t omp_init_allocator(omp_memspace_handle_t , int  , const omp_alloctrait_t []);
/*[]*/
extern void omp_destroy_allocator(omp_allocator_handle_t );
/*[]*/
extern void omp_set_default_allocator(omp_allocator_handle_t );
/*[]*/
extern omp_allocator_handle_t omp_get_default_allocator(void );
/*[]*/
extern void *omp_alloc(long unsigned int , omp_allocator_handle_t );
/*[]*/
extern void omp_free(void *, omp_allocator_handle_t );
/*[]*/
enum typeClsr {
    NORMAL, WAIT , DONE
} ;
/*[]*/
struct Clsr ;
/*[]*/
struct master_env ;
/*[]*/
struct WaitClsr {
    void ( *waitFunction )(struct Clsr *);
} ;
/*[]*/
struct Clsr {
    void ( *fptr )(struct Clsr *);
    enum typeClsr typeClosure;
    int iteration;
    struct master_env *environment;
    struct WaitClsr *waitClosure;
} ;
/*[]*/
struct Clsr **readyWorkList;
/*[]*/
int startRange_ivp17;
/*[]*/
int endRange_ivp17;
/*[]*/
int nThreads_ivp17;
/*[]*/
int *leftPointer;
/*[]*/
int *rightPointer;
/*[]*/
struct Clsr *createClosure(enum typeClsr , void ( *fptr )(struct Clsr *) , int );
/*[]*/
void myWaitAll(int );
/*[]*/
void mWaitAll(struct Clsr *);
/*[]*/
/*[]*/
void lastFunction(struct Clsr *closure) {
/*[]*/
    /*[]*/
    closure->typeClosure = DONE;
}
/*[]*/
struct Clsr *createClosure(enum typeClsr type, void ( *fptr )(struct Clsr *) , int currentIteration) {
/*[]*/
    /*[]*/
    unsigned long int _imopVarPre102;
    /*[]*/
    void *_imopVarPre103;
    /*[]*/
    _imopVarPre102 = sizeof(struct Clsr);
    /*[]*/
    _imopVarPre103 = malloc(_imopVarPre102);
    /*[]*/
    /*[]*/
    struct Clsr *closure = (struct Clsr *) _imopVarPre103;
    /*[]*/
    closure->typeClosure = type;
    /*[]*/
    closure->fptr = fptr;
    /*[]*/
    closure->iteration = currentIteration;
    /*[]*/
    return closure;
}
/*[]*/
void executeReadyWorkList() {
/*[]*/
    /*[]*/
    int _imopVarPre104;
    /*[]*/
    _imopVarPre104 = omp_get_thread_num();
    /*[]*/
    /*[]*/
    int tid = _imopVarPre104;
    /*[]*/
    int leftPtr = leftPointer[tid];
    /*[]*/
    int rightPtr = rightPointer[tid];
    /*[]*/
    int i;
    /*[]*/
    int chunkSize = rightPtr - leftPtr + 1;
    /*[]*/
    /*[]*/
    while (1) {
    /*[]*/
        /*[]*/
        int done = 0;
        /*[]*/
        /*[]*/
        /*[]*/
        /*[]*/
        for (i = leftPtr; i <= rightPtr; i++) {
        /*[]*/
            /*[]*/
            struct Clsr *closure = readyWorkList[i];
            /*[]*/
            /*[]*/
            if (closure->typeClosure == NORMAL) {
            /*[]*/
                /*[]*/
                void ( *_imopVarPre106 )(struct Clsr *);
                /*[]*/
                _imopVarPre106 = closure->fptr;
                /*[]*/
                _imopVarPre106(closure);
                /*[]*/
            } else {
            /*[]*/
                /*[]*/
                /*[]*/
                if (closure->typeClosure == WAIT) {
                /*[]*/
                    /*[]*/
                    struct WaitClsr *waitClosure = closure->waitClosure;
                    /*[]*/
                    void ( *_imopVarPre108 )(struct Clsr *);
                    /*[]*/
                    _imopVarPre108 = waitClosure->waitFunction;
                    /*[]*/
                    _imopVarPre108(closure);
                    /*[]*/
                }
            }
            /*[]*/
            /*[]*/
            if (closure->typeClosure == DONE) {
            /*[]*/
                /*[]*/
                done++;
            }
        }
        /*[]*/
        /*[]*/
        if (done == chunkSize) {
        /*[]*/
            /*[]*/
            break;
        }
    }
}
/*[1]*/
/*[1]*/
void myWaitAll(int x) {
/*[1]*/
    /*[1]*/
    return;
}
/*[]*/
/*[]*/
void mWaitAll(struct Clsr *closure) {
/*[]*/
    /*[]*/
    int _imopVarPre109;
    /*[]*/
    _imopVarPre109 = omp_get_thread_num();
    /*[]*/
    /*[]*/
    int tid = _imopVarPre109;
    /*[]*/
    int currentIteration = closure->iteration;
    /*[]*/
    /*[]*/
    if (currentIteration == rightPointer[tid]) {
    /*[]*/
        /*[]*/
        // #pragma omp dummyFlush BARRIER_START
        /*[]*/
#pragma omp barrier
        /*[]*/
        closure->typeClosure = NORMAL;
    } else {
    /*[]*/
        /*[]*/
        closure->typeClosure = NORMAL;
    }
}
/*[]*/
char input_file[100];
/*[]*/
char output_file[100];
/*[]*/
struct Process {
    int id;
    int send;
    int leaderId;
    int receivedId;
    int status;
} ;
/*[]*/
int processes;
/*[]*/
int *IdStore;
/*[]*/
struct Process *processSet;
/*[]*/
int step;
/*[]*/
void init() {
/*[]*/
    /*[]*/
    int i;
    /*[]*/
    /*[]*/
    /*[]*/
    /*[]*/
    for (i = 0; i < processes; i++) {
    /*[]*/
        /*[]*/
        int pt = i;
        /*[]*/
        processSet[i].id = IdStore[pt];
        /*[]*/
        processSet[i].leaderId = processSet[i].id;
        /*[]*/
        processSet[i].send = processSet[i].id;
        /*[]*/
        processSet[i].status = 0;
    }
}
/*[]*/
void transmitLeader() {
/*[]*/
    /*[]*/
    int lead = 0;
    /*[]*/
    int tmp = 0;
    /*[]*/
    int i;
    /*[]*/
    /*[]*/
    /*[]*/
    /*[]*/
    for (i = 0; i < processes; i++) {
    /*[]*/
        /*[]*/
        int check = 0;
        /*[]*/
        /*[]*/
        if (processSet[i].status) {
        /*[]*/
            /*[]*/
            check = 1;
        }
        /*[]*/
        tmp = check;
        /*[]*/
        /*[]*/
        if (tmp == 1) {
        /*[]*/
            /*[]*/
            lead = i;
        }
    }
    /*[]*/
    int pt = lead;
    /*[]*/
    int j;
    /*[]*/
    /*[]*/
    /*[]*/
    /*[]*/
    for (j = 0; j < processes; j++) {
    /*[]*/
        /*[]*/
        int pt_loc = lead;
        /*[]*/
        /*[]*/
        if (pt == processes - 1) {
        /*[]*/
            /*[]*/
            pt = 0;
        } else {
        /*[]*/
            /*[]*/
            pt = pt + 1;
        }
        /*[]*/
        processSet[pt].leaderId = pt_loc;
    }
    /*[]*/
    int lindex = lead;
    /*[]*/
    int pt_loc = lindex;
    /*[]*/
    processSet[lindex].leaderId = pt_loc;
}
/*[]*/
void outputVerifier() {
/*[]*/
    /*[]*/
    int max = (-0x7fffffff - 1);
    /*[]*/
    int i;
    /*[]*/
    /*[]*/
    /*[]*/
    /*[]*/
    for (i = 0; i < processes; i++) {
    /*[]*/
        /*[]*/
        /*[]*/
        if (max < IdStore[i]) {
        /*[]*/
            /*[]*/
            max = IdStore[i];
        }
    }
    /*[]*/
    int p = 0;
    /*[]*/
    int lead = processSet[p].leaderId;
    /*[]*/
    int q = lead;
    /*[]*/
    lead = processSet[q].id;
    /*[]*/
    /*[]*/
    if (max == lead) {
    /*[]*/
        /*[]*/
        fprintf(stderr, "Output verified\n");
        /*[]*/
    } else {
    /*[]*/
        /*[]*/
        fprintf(stderr, "Output not verified\n");
        /*[]*/
    }
}
/*[]*/
/*[]*/
/*[]*/
int main(int argc, char *argv[]) {
/*[]*/
    /*[]*/
    strcpy(input_file, "inputlcr.txt");
    /*[]*/
    /*[]*/
    strcpy(output_file, "outputlcr.txt");
    /*[]*/
    /*[]*/
    int verify = 0;
    /*[]*/
    double itime;
    /*[]*/
    double ftime;
    /*[]*/
    int i;
    /*[]*/
    char *_imopVarPre111;
    /*[]*/
    struct _IO_FILE *_imopVarPre112;
    /*[]*/
    _imopVarPre111 = argv[1];
    /*[]*/
    _imopVarPre112 = fopen(_imopVarPre111, "r");
    /*[]*/
    /*[]*/
    FILE *input = _imopVarPre112;
    /*[]*/
    /*[]*/
    if (input == ((void *) 0)) {
    /*[]*/
        /*[]*/
        fprintf(stderr, "Error opening input file\n");
        /*[]*/
        /*[]*/
        exit(0);
        /*[]*/
    }
    /*[]*/
    int *_imopVarPre114;
    /*[]*/
    _imopVarPre114 = &processes;
    /*[]*/
    fscanf(input, "%d", _imopVarPre114);
    /*[]*/
    /*[]*/
    unsigned long int _imopVarPre116;
    /*[]*/
    void *_imopVarPre117;
    /*[]*/
    _imopVarPre116 = sizeof(int);
    /*[]*/
    _imopVarPre117 = calloc(processes, _imopVarPre116);
    /*[]*/
    /*[]*/
    IdStore = _imopVarPre117;
    /*[]*/
    /*[]*/
    /*[]*/
    /*[]*/
    for (i = 0; i < processes; i++) {
    /*[]*/
        /*[]*/
        int *_imopVarPre119;
        /*[]*/
        _imopVarPre119 = &IdStore[i];
        /*[]*/
        fscanf(input, "%d", _imopVarPre119);
        /*[]*/
    }
    /*[]*/
    unsigned long int _imopVarPre121;
    /*[]*/
    void *_imopVarPre122;
    /*[]*/
    _imopVarPre121 = sizeof(struct Process);
    /*[]*/
    _imopVarPre122 = calloc(processes, _imopVarPre121);
    /*[]*/
    /*[]*/
    processSet = _imopVarPre122;
    /*[]*/
    init();
    /*[]*/
    /*[]*/
    itime = omp_get_wtime();
    /*[]*/
    /*[1]*/
#pragma omp parallel
    {
    /*[1]*/
        /*[1]*/
        int i;
        /*[1]*/
        int pt;
        /*[1]*/
        int p;
        /*[1]*/
        int sval;
        /*[1]*/
#pragma omp for private(i) nowait
        /*[1]*/
        /*[1]*/
        /*[1]*/
        for (i = 0; i < processes; i++) {
        /*[1]*/
            /*[1]*/
            /*[1]*/
            while (step < processes) {
            /*[1]*/
                /*[1]*/
                pt = i;
                /*[1]*/
                pt = (pt + 1) % processes;
                /*[1]*/
                p = pt;
                /*[1]*/
                sval = processSet[i].send;
                /*[1]*/
                processSet[p].receivedId = sval;
                /*[1]*/
                int wxyz = 0;
                /*[1]*/
                myWaitAll(1);
                /*[1]*/
                /*[1]*/
                /*[1]*/
                if (processSet[i].receivedId > processSet[i].leaderId) {
                /*[1]*/
                    /*[1]*/
                    processSet[i].send = processSet[i].receivedId;
                    /*[1]*/
                    processSet[i].leaderId = processSet[i].receivedId;
                } else {
                /*[1]*/
                    /*[1]*/
                    /*[1]*/
                    if (processSet[i].receivedId == processSet[i].id) {
                    /*[1]*/
                        /*[1]*/
                        processSet[i].status = 1;
                        /*[1]*/
                        processSet[i].leaderId = processSet[i].id;
                    }
                }
                /*[1]*/
                /*[1]*/
                if (i == 1) {
                /*[1]*/
                    /*[1]*/
                    step++;
                }
                {
                /*[1]*/
                    /*[1]*/
                    int wxyz = 0;
                    /*[1]*/
                    myWaitAll(1);
                    /*[1]*/
                }
            }
        }
        /*[1]*/
        // #pragma omp dummyFlush BARRIER_START
        /*[1]*/
#pragma omp barrier
    }
    /*[]*/
    transmitLeader();
    /*[]*/
    /*[]*/
    ftime = omp_get_wtime();
    /*[]*/
    /*[]*/
    fprintf(stderr, "Estimated time = ");
    /*[]*/
    /*[]*/
    double _imopVarPre124;
    /*[]*/
    _imopVarPre124 = (ftime - itime);
    /*[]*/
    fprintf(stderr, "%lf\n", _imopVarPre124);
    /*[]*/
    /*[]*/
    /*[]*/
    if (verify) {
    /*[]*/
        /*[]*/
        outputVerifier();
        /*[]*/
    }
    /*[]*/
    return 0;
}
