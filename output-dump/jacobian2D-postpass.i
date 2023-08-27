typedef long unsigned int size_t;
typedef __builtin_va_list __gnuc_va_list;
typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;
typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;
typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;
typedef __int8_t __int_least8_t;
typedef __uint8_t __uint_least8_t;
typedef __int16_t __int_least16_t;
typedef __uint16_t __uint_least16_t;
typedef __int32_t __int_least32_t;
typedef __uint32_t __uint_least32_t;
typedef __int64_t __int_least64_t;
typedef __uint64_t __uint_least64_t;
typedef long int __quad_t;
typedef unsigned long int __u_quad_t;
typedef long int __intmax_t;
typedef unsigned long int __uintmax_t;
typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
struct stUn_ivp0 {
    int __val[2];
} ;
typedef struct stUn_ivp0 __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;
typedef long int __suseconds64_t;
typedef int __daddr_t;
typedef int __key_t;
typedef int __clockid_t;
typedef void *__timer_t;
typedef long int __blksize_t;
typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;
typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;
typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;
typedef long int __fsword_t;
typedef long int __ssize_t;
typedef long int __syscall_slong_t;
typedef unsigned long int __syscall_ulong_t;
typedef __off64_t __loff_t;
typedef char *__caddr_t;
typedef long int __intptr_t;
typedef unsigned int __socklen_t;
typedef int __sig_atomic_t;
struct stUn_ivp2 {
    int __count;
    union stUn_ivp1 {
        unsigned int __wch;
        char __wchb[4];
    } __value;
} ;
typedef struct stUn_ivp2 __mbstate_t;
struct _G_fpos_t {
    __off_t __pos;
    __mbstate_t __state;
} ;
typedef struct _G_fpos_t __fpos_t;
struct _G_fpos64_t {
    __off64_t __pos;
    __mbstate_t __state;
} ;
typedef struct _G_fpos64_t __fpos64_t;
struct _IO_FILE ;
typedef struct _IO_FILE __FILE;
struct _IO_FILE ;
typedef struct _IO_FILE FILE;
struct _IO_FILE ;
struct _IO_marker ;
struct _IO_codecvt ;
struct _IO_wide_data ;
typedef void _IO_lock_t;
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
typedef __gnuc_va_list va_list;
typedef __off_t off_t;
typedef __ssize_t ssize_t;
typedef __fpos_t fpos_t;
extern FILE *stdin;
extern FILE *stdout;
extern FILE *stderr;
extern int remove(const char *__filename);
extern int rename(const char *__old, const char *__new);
extern int renameat(int __oldfd, const char *__old , int __newfd , const char *__new);
extern int fclose(FILE *__stream);
extern FILE *tmpfile(void );
extern char *tmpnam(char [20]);
extern char *tmpnam_r(char __s[20]);
extern char *tempnam(const char *__dir, const char *__pfx);
extern int fflush(FILE *__stream);
extern int fflush_unlocked(FILE *__stream);
extern FILE *fopen(const char *__restrict __filename, const char *__restrict __modes);
extern FILE *freopen(const char *__restrict __filename, const char *__restrict __modes , FILE *__restrict __stream);
extern FILE *fdopen(int __fd, const char *__modes);
extern FILE *fmemopen(void *__s, size_t __len , const char *__modes);
extern FILE *open_memstream(char **__bufloc, size_t *__sizeloc);
extern void setbuf(FILE *__restrict __stream, char *__restrict __buf);
extern int setvbuf(FILE *__restrict __stream, char *__restrict __buf , int __modes , size_t __n);
extern void setbuffer(FILE *__restrict __stream, char *__restrict __buf , size_t __size);
extern void setlinebuf(FILE *__stream);
extern int fprintf(FILE *__restrict __stream, const char *__restrict __format, ...);
extern int printf(const char *__restrict __format, ...);
extern int sprintf(char *__restrict __s, const char *__restrict __format, ...);
extern int vfprintf(FILE *__restrict __s, const char *__restrict __format , __gnuc_va_list __arg);
extern int vprintf(const char *__restrict __format, __gnuc_va_list __arg);
extern int vsprintf(char *__restrict __s, const char *__restrict __format , __gnuc_va_list __arg);
extern int snprintf(char *__restrict __s, size_t __maxlen , const char *__restrict __format, ...);
extern int vsnprintf(char *__restrict __s, size_t __maxlen , const char *__restrict __format , __gnuc_va_list __arg);
extern int vdprintf(int __fd, const char *__restrict __fmt , __gnuc_va_list __arg);
extern int dprintf(int __fd, const char *__restrict __fmt, ...);
extern int fscanf(FILE *__restrict __stream, const char *__restrict __format, ...);
extern int scanf(const char *__restrict __format, ...);
extern int sscanf(const char *__restrict __s, const char *__restrict __format, ...);
extern int fscanf(FILE *__restrict __stream, const char *__restrict __format, ...);
extern int scanf(const char *__restrict __format, ...);
extern int sscanf(const char *__restrict __s, const char *__restrict __format, ...);
extern int vfscanf(FILE *__restrict __s, const char *__restrict __format , __gnuc_va_list __arg);
extern int vscanf(const char *__restrict __format, __gnuc_va_list __arg);
extern int vsscanf(const char *__restrict __s, const char *__restrict __format , __gnuc_va_list __arg);
extern int vfscanf(FILE *__restrict __s, const char *__restrict __format , __gnuc_va_list __arg);
extern int vscanf(const char *__restrict __format, __gnuc_va_list __arg);
extern int vsscanf(const char *__restrict __s, const char *__restrict __format , __gnuc_va_list __arg);
extern int fgetc(FILE *__stream);
extern int getc(FILE *__stream);
extern int getchar(void );
extern int getc_unlocked(FILE *__stream);
extern int getchar_unlocked(void );
extern int fgetc_unlocked(FILE *__stream);
extern int fputc(int __c, FILE *__stream);
extern int putc(int __c, FILE *__stream);
extern int putchar(int __c);
extern int fputc_unlocked(int __c, FILE *__stream);
extern int putc_unlocked(int __c, FILE *__stream);
extern int putchar_unlocked(int __c);
extern int getw(FILE *__stream);
extern int putw(int __w, FILE *__stream);
extern char *fgets(char *__restrict __s, int __n , FILE *__restrict __stream);
extern __ssize_t __getdelim(char **__restrict __lineptr, size_t *__restrict __n , int __delimiter , FILE *__restrict __stream);
extern __ssize_t getdelim(char **__restrict __lineptr, size_t *__restrict __n , int __delimiter , FILE *__restrict __stream);
extern __ssize_t getline(char **__restrict __lineptr, size_t *__restrict __n , FILE *__restrict __stream);
extern int fputs(const char *__restrict __s, FILE *__restrict __stream);
extern int puts(const char *__s);
extern int ungetc(int __c, FILE *__stream);
extern size_t fread(void *__restrict __ptr, size_t __size , size_t __n , FILE *__restrict __stream);
extern size_t fwrite(const void *__restrict __ptr, size_t __size , size_t __n , FILE *__restrict __s);
extern size_t fread_unlocked(void *__restrict __ptr, size_t __size , size_t __n , FILE *__restrict __stream);
extern size_t fwrite_unlocked(const void *__restrict __ptr, size_t __size , size_t __n , FILE *__restrict __stream);
extern int fseek(FILE *__stream, long int __off , int __whence);
extern long int ftell(FILE *__stream);
extern void rewind(FILE *__stream);
extern int fseeko(FILE *__stream, __off_t __off , int __whence);
extern __off_t ftello(FILE *__stream);
extern int fgetpos(FILE *__restrict __stream, fpos_t *__restrict __pos);
extern int fsetpos(FILE *__stream, const fpos_t *__pos);
extern void clearerr(FILE *__stream);
extern int feof(FILE *__stream);
extern int ferror(FILE *__stream);
extern void clearerr_unlocked(FILE *__stream);
extern int feof_unlocked(FILE *__stream);
extern int ferror_unlocked(FILE *__stream);
extern void perror(const char *__s);
extern int fileno(FILE *__stream);
extern int fileno_unlocked(FILE *__stream);
extern int pclose(FILE *__stream);
extern FILE *popen(const char *__command, const char *__modes);
extern char *ctermid(char *__s);
extern void flockfile(FILE *__stream);
extern int ftrylockfile(FILE *__stream);
extern void funlockfile(FILE *__stream);
extern int __uflow(FILE *);
extern int __overflow(FILE *, int );
typedef int wchar_t;
struct stUn_ivp3 {
    int quot;
    int rem;
} ;
typedef struct stUn_ivp3 div_t;
struct stUn_ivp4 {
    long int quot;
    long int rem;
} ;
typedef struct stUn_ivp4 ldiv_t;
__extension__ struct stUn_ivp5 {
    long long int quot;
    long long int rem;
} ;
__extension__ typedef struct stUn_ivp5 lldiv_t;
extern size_t __ctype_get_mb_cur_max(void );
extern double atof(const char *__nptr);
extern int atoi(const char *__nptr);
extern long int atol(const char *__nptr);
__extension__ extern long long int atoll(const char *__nptr);
extern double strtod(const char *__restrict __nptr, char **__restrict __endptr);
extern float strtof(const char *__restrict __nptr, char **__restrict __endptr);
extern long double strtold(const char *__restrict __nptr, char **__restrict __endptr);
extern long int strtol(const char *__restrict __nptr, char **__restrict __endptr , int __base);
extern unsigned long int strtoul(const char *__restrict __nptr, char **__restrict __endptr , int __base);
__extension__ extern long long int strtoq(const char *__restrict __nptr, char **__restrict __endptr , int __base);
__extension__ extern unsigned long long int strtouq(const char *__restrict __nptr, char **__restrict __endptr , int __base);
__extension__ extern long long int strtoll(const char *__restrict __nptr, char **__restrict __endptr , int __base);
__extension__ extern unsigned long long int strtoull(const char *__restrict __nptr, char **__restrict __endptr , int __base);
extern char *l64a(long int __n);
extern long int a64l(const char *__s);
typedef __u_char u_char;
typedef __u_short u_short;
typedef __u_int u_int;
typedef __u_long u_long;
typedef __quad_t quad_t;
typedef __u_quad_t u_quad_t;
typedef __fsid_t fsid_t;
typedef __loff_t loff_t;
typedef __ino_t ino_t;
typedef __dev_t dev_t;
typedef __gid_t gid_t;
typedef __mode_t mode_t;
typedef __nlink_t nlink_t;
typedef __uid_t uid_t;
typedef __pid_t pid_t;
typedef __id_t id_t;
typedef __daddr_t daddr_t;
typedef __caddr_t caddr_t;
typedef __key_t key_t;
typedef __clock_t clock_t;
typedef __clockid_t clockid_t;
typedef __time_t time_t;
typedef __timer_t timer_t;
typedef unsigned long int ulong;
typedef unsigned short int ushort;
typedef unsigned int uint;
typedef __int8_t int8_t;
typedef __int16_t int16_t;
typedef __int32_t int32_t;
typedef __int64_t int64_t;
typedef __uint8_t u_int8_t;
typedef __uint16_t u_int16_t;
typedef __uint32_t u_int32_t;
typedef __uint64_t u_int64_t;
typedef int register_t;
static __inline __uint16_t __bswap_16(__uint16_t __bsx) {
    unsigned short int _imopVarPre22;
    _imopVarPre22 = __builtin_bswap16(__bsx);
    return _imopVarPre22;
}
static __inline __uint32_t __bswap_32(__uint32_t __bsx) {
    unsigned int _imopVarPre98;
    _imopVarPre98 = __builtin_bswap32(__bsx);
    return _imopVarPre98;
}
__extension__ static __inline __uint64_t __bswap_64(__uint64_t __bsx) {
    unsigned long int _imopVarPre99;
    _imopVarPre99 = __builtin_bswap64(__bsx);
    return _imopVarPre99;
}
static __inline __uint16_t __uint16_identity(__uint16_t __x) {
    return __x;
}
static __inline __uint32_t __uint32_identity(__uint32_t __x) {
    return __x;
}
static __inline __uint64_t __uint64_identity(__uint64_t __x) {
    return __x;
}
struct stUn_ivp6 {
    unsigned long int __val[(1024 / (8 * sizeof(unsigned long int)))];
} ;
typedef struct stUn_ivp6 __sigset_t;
typedef __sigset_t sigset_t;
struct timeval {
    __time_t tv_sec;
    __suseconds_t tv_usec;
} ;
struct timespec {
    __time_t tv_sec;
    __syscall_slong_t tv_nsec;
} ;
typedef __suseconds_t suseconds_t;
typedef long int __fd_mask;
struct stUn_ivp7 {
    __fd_mask __fds_bits[1024 / (8 * (int) sizeof(__fd_mask))];
} ;
typedef struct stUn_ivp7 fd_set;
typedef __fd_mask fd_mask;
extern int select(int __nfds, fd_set *__restrict __readfds , fd_set *__restrict __writefds , fd_set *__restrict __exceptfds , struct timeval *__restrict __timeout);
extern int pselect(int __nfds, fd_set *__restrict __readfds , fd_set *__restrict __writefds , fd_set *__restrict __exceptfds , const struct timespec *__restrict __timeout , const __sigset_t *__restrict __sigmask);
typedef __blksize_t blksize_t;
typedef __blkcnt_t blkcnt_t;
typedef __fsblkcnt_t fsblkcnt_t;
typedef __fsfilcnt_t fsfilcnt_t;
union stUn_ivp9 {
    __extension__ unsigned long long int __value64;
    struct stUn_ivp8 {
        unsigned int __low;
        unsigned int __high;
    } __value32;
} ;
typedef union stUn_ivp9 __atomic_wide_counter;
struct __pthread_internal_list {
    struct __pthread_internal_list *__prev;
    struct __pthread_internal_list *__next;
} ;
typedef struct __pthread_internal_list __pthread_list_t;
struct __pthread_internal_slist {
    struct __pthread_internal_slist *__next;
} ;
typedef struct __pthread_internal_slist __pthread_slist_t;
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
struct __pthread_cond_s {
    __atomic_wide_counter __wseq;
    __atomic_wide_counter __g1_start;
    unsigned int __g_refs[2];
    unsigned int __g_size[2];
    unsigned int __g1_orig_size;
    unsigned int __wrefs;
    unsigned int __g_signals[2];
} ;
typedef unsigned int __tss_t;
typedef unsigned long int __thrd_t;
struct stUn_ivp10 {
    int __data;
} ;
typedef struct stUn_ivp10 __once_flag;
typedef unsigned long int pthread_t;
union stUn_ivp11 {
    char __size[4];
    int __align;
} ;
typedef union stUn_ivp11 pthread_mutexattr_t;
union stUn_ivp12 {
    char __size[4];
    int __align;
} ;
typedef union stUn_ivp12 pthread_condattr_t;
typedef unsigned int pthread_key_t;
typedef int pthread_once_t;
union pthread_attr_t {
    char __size[56];
    long int __align;
} ;
typedef union pthread_attr_t pthread_attr_t;
union stUn_ivp13 {
    struct __pthread_mutex_s __data;
    char __size[40];
    long int __align;
} ;
typedef union stUn_ivp13 pthread_mutex_t;
union stUn_ivp14 {
    struct __pthread_cond_s __data;
    char __size[48];
    __extension__ long long int __align;
} ;
typedef union stUn_ivp14 pthread_cond_t;
union stUn_ivp15 {
    struct __pthread_rwlock_arch_t __data;
    char __size[56];
    long int __align;
} ;
typedef union stUn_ivp15 pthread_rwlock_t;
union stUn_ivp16 {
    char __size[8];
    long int __align;
} ;
typedef union stUn_ivp16 pthread_rwlockattr_t;
typedef volatile int pthread_spinlock_t;
union stUn_ivp17 {
    char __size[32];
    long int __align;
} ;
typedef union stUn_ivp17 pthread_barrier_t;
union stUn_ivp18 {
    char __size[4];
    int __align;
} ;
typedef union stUn_ivp18 pthread_barrierattr_t;
extern long int random(void );
extern void srandom(unsigned int __seed);
extern char *initstate(unsigned int __seed, char *__statebuf , size_t __statelen);
extern char *setstate(char *__statebuf);
struct random_data {
    int32_t *fptr;
    int32_t *rptr;
    int32_t *state;
    int rand_type;
    int rand_deg;
    int rand_sep;
    int32_t *end_ptr;
} ;
extern int random_r(struct random_data *__restrict __buf, int32_t *__restrict __result);
extern int srandom_r(unsigned int __seed, struct random_data *__buf);
extern int initstate_r(unsigned int __seed, char *__restrict __statebuf , size_t __statelen , struct random_data *__restrict __buf);
extern int setstate_r(char *__restrict __statebuf, struct random_data *__restrict __buf);
extern int rand(void );
extern void srand(unsigned int __seed);
extern int rand_r(unsigned int *__seed);
extern double drand48(void );
extern double erand48(unsigned short int __xsubi[3]);
extern long int lrand48(void );
extern long int nrand48(unsigned short int __xsubi[3]);
extern long int mrand48(void );
extern long int jrand48(unsigned short int __xsubi[3]);
extern void srand48(long int __seedval);
extern unsigned short int *seed48(unsigned short int __seed16v[3]);
extern void lcong48(unsigned short int __param[7]);
struct drand48_data {
    unsigned short int __x[3];
    unsigned short int __old_x[3];
    unsigned short int __c;
    unsigned short int __init;
    __extension__ unsigned long long int __a;
} ;
extern int drand48_r(struct drand48_data *__restrict __buffer, double *__restrict __result);
extern int erand48_r(unsigned short int __xsubi[3], struct drand48_data *__restrict __buffer , double *__restrict __result);
extern int lrand48_r(struct drand48_data *__restrict __buffer, long int *__restrict __result);
extern int nrand48_r(unsigned short int __xsubi[3], struct drand48_data *__restrict __buffer , long int *__restrict __result);
extern int mrand48_r(struct drand48_data *__restrict __buffer, long int *__restrict __result);
extern int jrand48_r(unsigned short int __xsubi[3], struct drand48_data *__restrict __buffer , long int *__restrict __result);
extern int srand48_r(long int __seedval, struct drand48_data *__buffer);
extern int seed48_r(unsigned short int __seed16v[3], struct drand48_data *__buffer);
extern int lcong48_r(unsigned short int __param[7], struct drand48_data *__buffer);
extern void *malloc(size_t __size);
extern void *calloc(size_t __nmemb, size_t __size);
extern void *realloc(void *__ptr, size_t __size);
extern void free(void *__ptr);
extern void *reallocarray(void *__ptr, size_t __nmemb , size_t __size);
extern void *reallocarray(void *__ptr, size_t __nmemb , size_t __size);
extern void *alloca(size_t __size);
extern void *valloc(size_t __size);
extern int posix_memalign(void **__memptr, size_t __alignment , size_t __size);
extern void *aligned_alloc(size_t __alignment, size_t __size);
extern void abort(void );
extern int atexit(void ( *__func )(void ));
extern int at_quick_exit(void ( *__func )(void ));
extern int on_exit(void ( *__func )(int __status, void *__arg), void *__arg);
extern void exit(int __status);
extern void quick_exit(int __status);
extern void _Exit(int __status);
extern char *getenv(const char *__name);
extern int putenv(char *__string);
extern int setenv(const char *__name, const char *__value , int __replace);
extern int unsetenv(const char *__name);
extern int clearenv(void );
extern char *mktemp(char *__template);
extern int mkstemp(char *__template);
extern int mkstemps(char *__template, int __suffixlen);
extern char *mkdtemp(char *__template);
extern int system(const char *__command);
extern char *realpath(const char *__restrict __name, char *__restrict __resolved);
typedef int ( *__compar_fn_t )(const void *, const void *);
extern void *bsearch(const void *__key, const void *__base , size_t __nmemb , size_t __size , __compar_fn_t __compar);
extern void qsort(void *__base, size_t __nmemb , size_t __size , __compar_fn_t __compar);
extern int abs(int __x);
extern long int labs(long int __x);
__extension__ extern long long int llabs(long long int __x);
extern div_t div(int __numer, int __denom);
extern ldiv_t ldiv(long int __numer, long int __denom);
__extension__ extern lldiv_t lldiv(long long int __numer, long long int __denom);
extern char *ecvt(double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign);
extern char *fcvt(double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign);
extern char *gcvt(double __value, int __ndigit , char *__buf);
extern char *qecvt(long double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign);
extern char *qfcvt(long double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign);
extern char *qgcvt(long double __value, int __ndigit , char *__buf);
extern int ecvt_r(double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign , char *__restrict __buf , size_t __len);
extern int fcvt_r(double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign , char *__restrict __buf , size_t __len);
extern int qecvt_r(long double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign , char *__restrict __buf , size_t __len);
extern int qfcvt_r(long double __value, int __ndigit , int *__restrict __decpt , int *__restrict __sign , char *__restrict __buf , size_t __len);
extern int mblen(const char *__s, size_t __n);
extern int mbtowc(wchar_t *__restrict __pwc, const char *__restrict __s , size_t __n);
extern int wctomb(char *__s, wchar_t __wchar);
extern size_t mbstowcs(wchar_t *__restrict __pwcs, const char *__restrict __s , size_t __n);
extern size_t wcstombs(char *__restrict __s, const wchar_t *__restrict __pwcs , size_t __n);
extern int rpmatch(const char *__response);
extern int getsubopt(char **__restrict __optionp, char *const *__restrict __tokens , char **__restrict __valuep);
extern int getloadavg(double __loadavg[], int __nelem);
struct stUn_ivp19 {
    unsigned char _x[4];
} ;
typedef struct stUn_ivp19 omp_lock_t;
struct stUn_ivp20 {
    unsigned char _x[8 + sizeof(void *)];
} ;
typedef struct stUn_ivp20 omp_nest_lock_t;
enum omp_sched_t {
    omp_sched_static = 1, omp_sched_dynamic = 2 , omp_sched_guided = 3 , omp_sched_auto = 4 , omp_sched_monotonic = 0x80000000U
} ;
typedef enum omp_sched_t omp_sched_t;
enum omp_proc_bind_t {
    omp_proc_bind_false = 0, omp_proc_bind_true = 1 , omp_proc_bind_master = 2 , omp_proc_bind_close = 3 , omp_proc_bind_spread = 4
} ;
typedef enum omp_proc_bind_t omp_proc_bind_t;
enum omp_sync_hint_t {
    omp_sync_hint_none = 0, omp_lock_hint_none = omp_sync_hint_none , omp_sync_hint_uncontended = 1 , omp_lock_hint_uncontended = omp_sync_hint_uncontended , omp_sync_hint_contended = 2 , omp_lock_hint_contended = omp_sync_hint_contended , omp_sync_hint_nonspeculative = 4 , omp_lock_hint_nonspeculative = omp_sync_hint_nonspeculative , omp_sync_hint_speculative = 8 , omp_lock_hint_speculative = omp_sync_hint_speculative
} ;
typedef enum omp_sync_hint_t omp_sync_hint_t;
typedef omp_sync_hint_t omp_lock_hint_t;
struct omp_depend_t {
    char __omp_depend_t__[2 * sizeof(void *)];
} ;
typedef struct omp_depend_t omp_depend_t;
enum omp_pause_resource_t {
    omp_pause_soft = 1, omp_pause_hard = 2
} ;
typedef enum omp_pause_resource_t omp_pause_resource_t;
typedef long unsigned int omp_uintptr_t;
enum omp_memspace_handle_t {
    omp_default_mem_space = 0, omp_large_cap_mem_space = 1 , omp_const_mem_space = 2 , omp_high_bw_mem_space = 3 , omp_low_lat_mem_space = 4 , __omp_memspace_handle_t_max__ = 0xffffffffffffffffUL
} ;
typedef enum omp_memspace_handle_t omp_memspace_handle_t;
enum omp_allocator_handle_t {
    omp_null_allocator = 0, omp_default_mem_alloc = 1 , omp_large_cap_mem_alloc = 2 , omp_const_mem_alloc = 3 , omp_high_bw_mem_alloc = 4 , omp_low_lat_mem_alloc = 5 , omp_cgroup_mem_alloc = 6 , omp_pteam_mem_alloc = 7 , omp_thread_mem_alloc = 8 , __omp_allocator_handle_t_max__ = 0xffffffffffffffffUL
} ;
typedef enum omp_allocator_handle_t omp_allocator_handle_t;
enum omp_alloctrait_key_t {
    omp_atk_sync_hint = 1, omp_atk_alignment = 2 , omp_atk_access = 3 , omp_atk_pool_size = 4 , omp_atk_fallback = 5 , omp_atk_fb_data = 6 , omp_atk_pinned = 7 , omp_atk_partition = 8
} ;
typedef enum omp_alloctrait_key_t omp_alloctrait_key_t;
enum omp_alloctrait_value_t {
    omp_atv_default = (long unsigned int) -1, omp_atv_false = 0 , omp_atv_true = 1 , omp_atv_contended = 3 , omp_atv_uncontended = 4 , omp_atv_serialized = 5 , omp_atv_sequential = omp_atv_serialized , omp_atv_private = 6 , omp_atv_all = 7 , omp_atv_thread = 8 , omp_atv_pteam = 9 , omp_atv_cgroup = 10 , omp_atv_default_mem_fb = 11 , omp_atv_null_fb = 12 , omp_atv_abort_fb = 13 , omp_atv_allocator_fb = 14 , omp_atv_environment = 15 , omp_atv_nearest = 16 , omp_atv_blocked = 17 , omp_atv_interleaved = 18
} ;
typedef enum omp_alloctrait_value_t omp_alloctrait_value_t;
struct omp_alloctrait_t {
    omp_alloctrait_key_t key;
    omp_uintptr_t value;
} ;
typedef struct omp_alloctrait_t omp_alloctrait_t;
enum omp_event_handle_t {
    __omp_event_handle_t_max__ = 0xffffffffffffffffUL
} ;
typedef enum omp_event_handle_t omp_event_handle_t;
extern void omp_set_num_threads(int );
extern int omp_get_num_threads(void );
extern int omp_get_max_threads(void );
extern int omp_get_thread_num(void );
extern int omp_get_num_procs(void );
extern int omp_in_parallel(void );
extern void omp_set_dynamic(int );
extern int omp_get_dynamic(void );
extern void omp_set_nested(int );
extern int omp_get_nested(void );
extern void omp_init_lock(omp_lock_t *);
extern void omp_init_lock_with_hint(omp_lock_t *, omp_sync_hint_t );
extern void omp_destroy_lock(omp_lock_t *);
extern void omp_set_lock(omp_lock_t *);
extern void omp_unset_lock(omp_lock_t *);
extern int omp_test_lock(omp_lock_t *);
extern void omp_init_nest_lock(omp_nest_lock_t *);
extern void omp_init_nest_lock_with_hint(omp_nest_lock_t *, omp_sync_hint_t );
extern void omp_destroy_nest_lock(omp_nest_lock_t *);
extern void omp_set_nest_lock(omp_nest_lock_t *);
extern void omp_unset_nest_lock(omp_nest_lock_t *);
extern int omp_test_nest_lock(omp_nest_lock_t *);
extern double omp_get_wtime(void );
extern double omp_get_wtick(void );
extern void omp_set_schedule(omp_sched_t , int );
extern void omp_get_schedule(omp_sched_t *, int *);
extern int omp_get_thread_limit(void );
extern void omp_set_max_active_levels(int );
extern int omp_get_max_active_levels(void );
extern int omp_get_supported_active_levels(void );
extern int omp_get_level(void );
extern int omp_get_ancestor_thread_num(int );
extern int omp_get_team_size(int );
extern int omp_get_active_level(void );
extern int omp_in_final(void );
extern int omp_get_cancellation(void );
extern omp_proc_bind_t omp_get_proc_bind(void );
extern int omp_get_num_places(void );
extern int omp_get_place_num_procs(int );
extern void omp_get_place_proc_ids(int , int *);
extern int omp_get_place_num(void );
extern int omp_get_partition_num_places(void );
extern void omp_get_partition_place_nums(int *);
extern void omp_set_default_device(int );
extern int omp_get_default_device(void );
extern int omp_get_num_devices(void );
extern int omp_get_num_teams(void );
extern int omp_get_team_num(void );
extern int omp_is_initial_device(void );
extern int omp_get_initial_device(void );
extern int omp_get_max_task_priority(void );
extern void omp_fulfill_event(omp_event_handle_t );
extern void *omp_target_alloc(long unsigned int , int );
extern void omp_target_free(void *, int );
extern int omp_target_is_present(const void *, int );
extern int omp_target_memcpy(void *, const void * , long unsigned int  , long unsigned int  , long unsigned int  , int  , int );
extern int omp_target_memcpy_rect(void *, const void * , long unsigned int  , int  , const long unsigned int * , const long unsigned int * , const long unsigned int * , const long unsigned int * , const long unsigned int * , int  , int );
extern int omp_target_associate_ptr(const void *, const void * , long unsigned int  , long unsigned int  , int );
extern int omp_target_disassociate_ptr(const void *, int );
extern void omp_set_affinity_format(const char *);
extern long unsigned int omp_get_affinity_format(char *, long unsigned int );
extern void omp_display_affinity(const char *);
extern long unsigned int omp_capture_affinity(char *, long unsigned int  , const char *);
extern int omp_pause_resource(omp_pause_resource_t , int );
extern int omp_pause_resource_all(omp_pause_resource_t );
extern omp_allocator_handle_t omp_init_allocator(omp_memspace_handle_t , int  , const omp_alloctrait_t []);
extern void omp_destroy_allocator(omp_allocator_handle_t );
extern void omp_set_default_allocator(omp_allocator_handle_t );
extern omp_allocator_handle_t omp_get_default_allocator(void );
extern void *omp_alloc(long unsigned int , omp_allocator_handle_t );
extern void omp_free(void *, omp_allocator_handle_t );
enum typeClsr {
    NORMAL, REDUCTION , WAIT
} ;
struct Clsr ;
struct WaitClsr {
    int currentIteration;
    int expr;
    int n_iters;
    int start;
    int startRange;
    int endRange;
    int *waitIterations;
    void ( *waitFunction )(struct Clsr *);
} ;
struct Msg {
    void *message;
} ;
struct master_env ;
struct Clsr {
    void ( *fptr )(struct Clsr *);
    void ( *tfptr )(struct Clsr *);
    enum typeClsr typeClosure;
    struct master_env *environment;
    struct WaitClsr *waitClosure;
    struct Clsr *continuation;
} ;
struct ClsrNode {
    struct Clsr *closure;
    struct ClsrNode *next;
} ;
struct WLQueue {
    struct ClsrNode *front, *rear;
} ;
struct HashNode {
    int key;
    int value;
    omp_lock_t lock;
    struct HashNode *next;
} ;
struct HashTable {
    struct HashNode **table;
    int tSize;
    int cSize;
} ;
struct HashNode *createHashNode(int key, int value) {
    unsigned long int _imopVarPre102;
    void *_imopVarPre103;
    _imopVarPre102 = sizeof(struct HashNode);
    _imopVarPre103 = malloc(_imopVarPre102);
    struct HashNode *tempNode = (struct HashNode *) _imopVarPre103;
    tempNode->key = key;
    tempNode->value = value;
    tempNode->next = (void *) 0;
    struct stUn_ivp19 *_imopVarPre105;
    _imopVarPre105 = &(tempNode->lock);
    omp_init_lock(_imopVarPre105);
    return tempNode;
}
struct HashTable *createHashTable() {
    unsigned long int _imopVarPre108;
    void *_imopVarPre109;
    _imopVarPre108 = sizeof(struct HashTable);
    _imopVarPre109 = malloc(_imopVarPre108);
    struct HashTable *table = (struct HashTable *) _imopVarPre109;
    unsigned long int _imopVarPre112;
    void *_imopVarPre113;
    _imopVarPre112 = 4 * sizeof(struct HashNode *);
    _imopVarPre113 = malloc(_imopVarPre112);
    table->table = (struct HashNode **) _imopVarPre113;
    table->tSize = 4;
    table->cSize = 0;
    int i;
    for (i = 0; i < 4; i++) {
        table->table[i] = (void *) 0;
    }
    return table;
}
int hashFunction(int key, int tSize) {
    return (key % tSize);
}
void insert(struct HashTable *table, int key , int value) {
    int tSize = table->tSize;
    int _imopVarPre114;
    _imopVarPre114 = hashFunction(key, tSize);
    int hashIndex = _imopVarPre114;
    struct HashNode *_imopVarPre115;
    _imopVarPre115 = createHashNode(key, value);
    struct HashNode *newNode = _imopVarPre115;
    newNode->next = table->table[hashIndex];
    table->table[hashIndex] = newNode;
    table->cSize++;
}
struct HashNode *search(struct HashTable *table, int key) {
    int tSize = table->tSize;
    int _imopVarPre116;
    _imopVarPre116 = hashFunction(key, tSize);
    int hashIndex = _imopVarPre116;
    struct HashNode *ptr = table->table[hashIndex];
    if (ptr == (void *) 0) {
        return (void *) 0;
    } else {
        struct stUn_ivp19 *_imopVarPre118;
        _imopVarPre118 = &(ptr->lock);
        omp_set_lock(_imopVarPre118);
        while (ptr != (void *) 0) {
            if (ptr->key == key) {
                struct stUn_ivp19 *_imopVarPre120;
                _imopVarPre120 = &(ptr->lock);
                omp_unset_lock(_imopVarPre120);
                return ptr;
            }
            ptr = ptr->next;
        }
        struct stUn_ivp19 *_imopVarPre122;
        _imopVarPre122 = &(ptr->lock);
        omp_unset_lock(_imopVarPre122);
        return (void *) 0;
    }
}
struct WLQueue *globalWorklist;
int K;
int threadStatus[2048];
int startRange_ivp17;
int endRange_ivp17;
void ( *continuationFunctionPointer )(struct Clsr *);
struct Clsr *createClosure(enum typeClsr , void ( *fptr )(struct Clsr *));
void incrementCounter(struct HashTable *, int );
int decrementCounter(struct HashTable *, int );
int testAndDecPostbox(int , int );
void postMessage(int , int  , void *);
void initialisePostBox(int );
void mySignalAll(int , int  , int );
void mySignal(int , int  , int *);
void mSignalAll(int , int  , void * , int  , int  , struct Clsr *);
void mSignal(int , int  , void * , int  , int * , struct Clsr *);
void myWaitAll(int , int  , int );
void myWait(int , int  , int *);
void mWaitAll(struct Clsr *);
void mWait(struct Clsr *);
void createWaitClosureAll(int , void *( *combine )(struct Msg *, struct Msg *) , void ( *copy )(void *, void *) , void ( *alloc )(struct Msg *) , void * , void * , int  , int  , struct Clsr ** , int );
void createWaitClosure(int , void *( *combine )(struct Msg *, struct Msg *) , void ( *copy )(void *, void *) , void ( *alloc )(struct Msg *) , void * , void * , int  , int  , int * , struct Clsr ** , int );
struct WLQueue *createWorklistQueue();
struct ClsrNode *createClosureNode(struct Clsr *);
int isEmptyWorklist(struct WLQueue *);
void enqueueClosure(struct WLQueue *, struct Clsr *);
struct Clsr *dequeueClosure(struct WLQueue *);
int checkThreadStatus(int *);
void executeReadyWorkList(struct WLQueue *);
void scheduler(struct WLQueue *, int );
void lastFunction(struct Clsr *closure) {
    if (closure != (void *) 0) {
        free(closure);
        closure = (void *) 0;
    }
}
struct Clsr *createClosure(enum typeClsr type, void ( *fptr )(struct Clsr *)) {
    unsigned long int _imopVarPre126;
    void *_imopVarPre127;
    _imopVarPre126 = sizeof(struct Clsr);
    _imopVarPre127 = malloc(_imopVarPre126);
    struct Clsr *closure = (struct Clsr *) _imopVarPre127;
    closure->typeClosure = type;
    closure->fptr = fptr;
    return closure;
}
struct WLQueue *createWorklistQueue() {
    unsigned long int _imopVarPre130;
    void *_imopVarPre131;
    _imopVarPre130 = sizeof(struct WLQueue);
    _imopVarPre131 = malloc(_imopVarPre130);
    struct WLQueue *workListQueue = (struct WLQueue *) _imopVarPre131;
    workListQueue->front = ((void *) 0);
    workListQueue->rear = ((void *) 0);
    return workListQueue;
}
struct ClsrNode *createClosureNode(struct Clsr *closure) {
    unsigned long int _imopVarPre134;
    void *_imopVarPre135;
    _imopVarPre134 = sizeof(struct ClsrNode);
    _imopVarPre135 = malloc(_imopVarPre134);
    struct ClsrNode *closureNode = (struct ClsrNode *) _imopVarPre135;
    closureNode->closure = closure;
    closureNode->next = ((void *) 0);
    return closureNode;
}
int isEmptyWorklist(struct WLQueue *workListQueue) {
    if (workListQueue->front == (void *) 0) {
        return 1;
    }
    return 0;
}
void enqueueClosure(struct WLQueue *queue, struct Clsr *closure) {
    struct ClsrNode *_imopVarPre136;
    _imopVarPre136 = createClosureNode(closure);
    struct ClsrNode *closureNode = _imopVarPre136;
    int _imopVarPre137;
    _imopVarPre137 = isEmptyWorklist(queue);
    if (_imopVarPre137) {
        queue->front = closureNode;
        queue->rear = closureNode;
        return;
    }
    queue->rear->next = closureNode;
    queue->rear = closureNode;
}
struct Clsr *dequeueClosure(struct WLQueue *queue) {
    int _imopVarPre138;
    _imopVarPre138 = isEmptyWorklist(queue);
    if (_imopVarPre138) {
        return ((void *) 0);
    }
    struct ClsrNode *closureNode = queue->front;
    struct Clsr *closure = closureNode->closure;
    if (queue->front == queue->rear) {
        queue->front = queue->rear = (void *) 0;
    } else {
        queue->front = queue->front->next;
    }
    return closure;
}
void executeReadyWorkList(struct WLQueue *readyWorkList) {
    int _imopVarPre140;
    _imopVarPre140 = isEmptyWorklist(readyWorkList);
    while (!_imopVarPre140) {
        struct Clsr *_imopVarPre141;
        _imopVarPre141 = dequeueClosure(readyWorkList);
        struct Clsr *closure = _imopVarPre141;
        if (closure == ((void *) 0)) {
            return;
        }
        if (closure->typeClosure == NORMAL) {
            void ( *_imopVarPre143 )(struct Clsr *);
            _imopVarPre143 = closure->fptr;
            _imopVarPre143(closure);
        } else {
            if (closure->typeClosure == WAIT) {
                struct WaitClsr *waitClsr = closure->waitClosure;
                void ( *_imopVarPre145 )(struct Clsr *);
                _imopVarPre145 = waitClsr->waitFunction;
                _imopVarPre145(closure);
            }
        }
        _imopVarPre140 = isEmptyWorklist(readyWorkList);
    }
}
void scheduler(struct WLQueue *readyWorklist, int K) {
    while (1) {
        int _imopVarPre146;
        _imopVarPre146 = isEmptyWorklist(globalWorklist);
        int isEmptyGlobalWorklist = _imopVarPre146;
        if (isEmptyGlobalWorklist) {
            break;
        } else {
            int count = K;
            int clsrPushed = 0;
            while (count--) {
                struct Clsr *closure;
#pragma omp critical
                {
                    closure = dequeueClosure(globalWorklist);
                }
                if (closure == ((void *) 0)) {
                    break;
                }
                clsrPushed = 1;
                enqueueClosure(readyWorklist, closure);
            }
            if (clsrPushed) {
                executeReadyWorkList(readyWorklist);
            } else {
                break;
            }
        }
    }
}
struct HashTable **postbox_ivp17;
void incrementCounter(struct HashTable *table, int key) {
    struct HashNode *_imopVarPre147;
    _imopVarPre147 = search(table, key);
    struct HashNode *ptr = _imopVarPre147;
    if (ptr == (void *) 0) {
        insert(table, key, 1);
    } else {
        struct stUn_ivp19 *_imopVarPre149;
        _imopVarPre149 = &(ptr->lock);
        omp_set_lock(_imopVarPre149);
        (ptr->value)++;
        struct stUn_ivp19 *_imopVarPre151;
        _imopVarPre151 = &(ptr->lock);
        omp_unset_lock(_imopVarPre151);
    }
}
int decrementCounter(struct HashTable *table, int key) {
    struct HashNode *_imopVarPre152;
    _imopVarPre152 = search(table, key);
    struct HashNode *ptr = _imopVarPre152;
    if (ptr == (void *) 0) {
        return 0;
    } else {
        struct stUn_ivp19 *_imopVarPre154;
        _imopVarPre154 = &(ptr->lock);
        omp_set_lock(_imopVarPre154);
        if (ptr->value == 0) {
            struct stUn_ivp19 *_imopVarPre156;
            _imopVarPre156 = &(ptr->lock);
            omp_unset_lock(_imopVarPre156);
            return 0;
        } else {
            (ptr->value)--;
            struct stUn_ivp19 *_imopVarPre158;
            _imopVarPre158 = &(ptr->lock);
            omp_unset_lock(_imopVarPre158);
            return 1;
        }
    }
}
int testAndDecPostbox(int currentIteration, int waitIteration) {
    struct HashTable *hashTable = postbox_ivp17[currentIteration];
    int _imopVarPre159;
    _imopVarPre159 = decrementCounter(hashTable, waitIteration);
    return _imopVarPre159;
}
void postMessage(int from, int to , void *message) {
    struct HashTable *hashTable = postbox_ivp17[to];
    int tSize = hashTable->tSize;
    incrementCounter(hashTable, from);
}
void initialisePostBox(int i) {
    struct HashTable *_imopVarPre160;
    _imopVarPre160 = createHashTable();
    postbox_ivp17[i] = _imopVarPre160;
}
typedef float float_t;
typedef double double_t;
extern int __fpclassify(double __value);
extern int __signbit(double __value);
extern int __isinf(double __value);
extern int __finite(double __value);
extern int __isnan(double __value);
extern int __iseqsig(double __x, double __y);
extern int __issignaling(double __value);
extern double acos(double __x);
extern double __acos(double __x);
extern double asin(double __x);
extern double __asin(double __x);
extern double atan(double __x);
extern double __atan(double __x);
extern double atan2(double __y, double __x);
extern double __atan2(double __y, double __x);
extern double cos(double __x);
extern double __cos(double __x);
extern double sin(double __x);
extern double __sin(double __x);
extern double tan(double __x);
extern double __tan(double __x);
extern double cosh(double __x);
extern double __cosh(double __x);
extern double sinh(double __x);
extern double __sinh(double __x);
extern double tanh(double __x);
extern double __tanh(double __x);
extern double acosh(double __x);
extern double __acosh(double __x);
extern double asinh(double __x);
extern double __asinh(double __x);
extern double atanh(double __x);
extern double __atanh(double __x);
extern double exp(double __x);
extern double __exp(double __x);
extern double frexp(double __x, int *__exponent);
extern double __frexp(double __x, int *__exponent);
extern double ldexp(double __x, int __exponent);
extern double __ldexp(double __x, int __exponent);
extern double log(double __x);
extern double __log(double __x);
extern double log10(double __x);
extern double __log10(double __x);
extern double modf(double __x, double *__iptr);
extern double __modf(double __x, double *__iptr);
extern double expm1(double __x);
extern double __expm1(double __x);
extern double log1p(double __x);
extern double __log1p(double __x);
extern double logb(double __x);
extern double __logb(double __x);
extern double exp2(double __x);
extern double __exp2(double __x);
extern double log2(double __x);
extern double __log2(double __x);
extern double pow(double __x, double __y);
extern double __pow(double __x, double __y);
extern double sqrt(double __x);
extern double __sqrt(double __x);
extern double hypot(double __x, double __y);
extern double __hypot(double __x, double __y);
extern double cbrt(double __x);
extern double __cbrt(double __x);
extern double ceil(double __x);
extern double __ceil(double __x);
extern double fabs(double __x);
extern double __fabs(double __x);
extern double floor(double __x);
extern double __floor(double __x);
extern double fmod(double __x, double __y);
extern double __fmod(double __x, double __y);
extern int isinf(double __value);
extern int finite(double __value);
extern double drem(double __x, double __y);
extern double __drem(double __x, double __y);
extern double significand(double __x);
extern double __significand(double __x);
extern double copysign(double __x, double __y);
extern double __copysign(double __x, double __y);
extern double nan(const char *__tagb);
extern double __nan(const char *__tagb);
extern int isnan(double __value);
extern double j0(double );
extern double __j0(double );
extern double j1(double );
extern double __j1(double );
extern double jn(int , double );
extern double __jn(int , double );
extern double y0(double );
extern double __y0(double );
extern double y1(double );
extern double __y1(double );
extern double yn(int , double );
extern double __yn(int , double );
extern double erf(double );
extern double __erf(double );
extern double erfc(double );
extern double __erfc(double );
extern double lgamma(double );
extern double __lgamma(double );
extern double tgamma(double );
extern double __tgamma(double );
extern double gamma(double );
extern double __gamma(double );
extern double lgamma_r(double , int *__signgamp);
extern double __lgamma_r(double , int *__signgamp);
extern double rint(double __x);
extern double __rint(double __x);
extern double nextafter(double __x, double __y);
extern double __nextafter(double __x, double __y);
extern double nexttoward(double __x, long double __y);
extern double __nexttoward(double __x, long double __y);
extern double remainder(double __x, double __y);
extern double __remainder(double __x, double __y);
extern double scalbn(double __x, int __n);
extern double __scalbn(double __x, int __n);
extern int ilogb(double __x);
extern int __ilogb(double __x);
extern double scalbln(double __x, long int __n);
extern double __scalbln(double __x, long int __n);
extern double nearbyint(double __x);
extern double __nearbyint(double __x);
extern double round(double __x);
extern double __round(double __x);
extern double trunc(double __x);
extern double __trunc(double __x);
extern double remquo(double __x, double __y , int *__quo);
extern double __remquo(double __x, double __y , int *__quo);
extern long int lrint(double __x);
extern long int __lrint(double __x);
__extension__ extern long long int llrint(double __x);
extern long long int __llrint(double __x);
extern long int lround(double __x);
extern long int __lround(double __x);
__extension__ extern long long int llround(double __x);
extern long long int __llround(double __x);
extern double fdim(double __x, double __y);
extern double __fdim(double __x, double __y);
extern double fmax(double __x, double __y);
extern double __fmax(double __x, double __y);
extern double fmin(double __x, double __y);
extern double __fmin(double __x, double __y);
extern double fma(double __x, double __y , double __z);
extern double __fma(double __x, double __y , double __z);
extern double scalb(double __x, double __n);
extern double __scalb(double __x, double __n);
extern int __fpclassifyf(float __value);
extern int __signbitf(float __value);
extern int __isinff(float __value);
extern int __finitef(float __value);
extern int __isnanf(float __value);
extern int __iseqsigf(float __x, float __y);
extern int __issignalingf(float __value);
extern float acosf(float __x);
extern float __acosf(float __x);
extern float asinf(float __x);
extern float __asinf(float __x);
extern float atanf(float __x);
extern float __atanf(float __x);
extern float atan2f(float __y, float __x);
extern float __atan2f(float __y, float __x);
extern float cosf(float __x);
extern float __cosf(float __x);
extern float sinf(float __x);
extern float __sinf(float __x);
extern float tanf(float __x);
extern float __tanf(float __x);
extern float coshf(float __x);
extern float __coshf(float __x);
extern float sinhf(float __x);
extern float __sinhf(float __x);
extern float tanhf(float __x);
extern float __tanhf(float __x);
extern float acoshf(float __x);
extern float __acoshf(float __x);
extern float asinhf(float __x);
extern float __asinhf(float __x);
extern float atanhf(float __x);
extern float __atanhf(float __x);
extern float expf(float __x);
extern float __expf(float __x);
extern float frexpf(float __x, int *__exponent);
extern float __frexpf(float __x, int *__exponent);
extern float ldexpf(float __x, int __exponent);
extern float __ldexpf(float __x, int __exponent);
extern float logf(float __x);
extern float __logf(float __x);
extern float log10f(float __x);
extern float __log10f(float __x);
extern float modff(float __x, float *__iptr);
extern float __modff(float __x, float *__iptr);
extern float expm1f(float __x);
extern float __expm1f(float __x);
extern float log1pf(float __x);
extern float __log1pf(float __x);
extern float logbf(float __x);
extern float __logbf(float __x);
extern float exp2f(float __x);
extern float __exp2f(float __x);
extern float log2f(float __x);
extern float __log2f(float __x);
extern float powf(float __x, float __y);
extern float __powf(float __x, float __y);
extern float sqrtf(float __x);
extern float __sqrtf(float __x);
extern float hypotf(float __x, float __y);
extern float __hypotf(float __x, float __y);
extern float cbrtf(float __x);
extern float __cbrtf(float __x);
extern float ceilf(float __x);
extern float __ceilf(float __x);
extern float fabsf(float __x);
extern float __fabsf(float __x);
extern float floorf(float __x);
extern float __floorf(float __x);
extern float fmodf(float __x, float __y);
extern float __fmodf(float __x, float __y);
extern int isinff(float __value);
extern int finitef(float __value);
extern float dremf(float __x, float __y);
extern float __dremf(float __x, float __y);
extern float significandf(float __x);
extern float __significandf(float __x);
extern float copysignf(float __x, float __y);
extern float __copysignf(float __x, float __y);
extern float nanf(const char *__tagb);
extern float __nanf(const char *__tagb);
extern int isnanf(float __value);
extern float j0f(float );
extern float __j0f(float );
extern float j1f(float );
extern float __j1f(float );
extern float jnf(int , float );
extern float __jnf(int , float );
extern float y0f(float );
extern float __y0f(float );
extern float y1f(float );
extern float __y1f(float );
extern float ynf(int , float );
extern float __ynf(int , float );
extern float erff(float );
extern float __erff(float );
extern float erfcf(float );
extern float __erfcf(float );
extern float lgammaf(float );
extern float __lgammaf(float );
extern float tgammaf(float );
extern float __tgammaf(float );
extern float gammaf(float );
extern float __gammaf(float );
extern float lgammaf_r(float , int *__signgamp);
extern float __lgammaf_r(float , int *__signgamp);
extern float rintf(float __x);
extern float __rintf(float __x);
extern float nextafterf(float __x, float __y);
extern float __nextafterf(float __x, float __y);
extern float nexttowardf(float __x, long double __y);
extern float __nexttowardf(float __x, long double __y);
extern float remainderf(float __x, float __y);
extern float __remainderf(float __x, float __y);
extern float scalbnf(float __x, int __n);
extern float __scalbnf(float __x, int __n);
extern int ilogbf(float __x);
extern int __ilogbf(float __x);
extern float scalblnf(float __x, long int __n);
extern float __scalblnf(float __x, long int __n);
extern float nearbyintf(float __x);
extern float __nearbyintf(float __x);
extern float roundf(float __x);
extern float __roundf(float __x);
extern float truncf(float __x);
extern float __truncf(float __x);
extern float remquof(float __x, float __y , int *__quo);
extern float __remquof(float __x, float __y , int *__quo);
extern long int lrintf(float __x);
extern long int __lrintf(float __x);
__extension__ extern long long int llrintf(float __x);
extern long long int __llrintf(float __x);
extern long int lroundf(float __x);
extern long int __lroundf(float __x);
__extension__ extern long long int llroundf(float __x);
extern long long int __llroundf(float __x);
extern float fdimf(float __x, float __y);
extern float __fdimf(float __x, float __y);
extern float fmaxf(float __x, float __y);
extern float __fmaxf(float __x, float __y);
extern float fminf(float __x, float __y);
extern float __fminf(float __x, float __y);
extern float fmaf(float __x, float __y , float __z);
extern float __fmaf(float __x, float __y , float __z);
extern float scalbf(float __x, float __n);
extern float __scalbf(float __x, float __n);
extern int __fpclassifyl(long double __value);
extern int __signbitl(long double __value);
extern int __isinfl(long double __value);
extern int __finitel(long double __value);
extern int __isnanl(long double __value);
extern int __iseqsigl(long double __x, long double __y);
extern int __issignalingl(long double __value);
extern long double acosl(long double __x);
extern long double __acosl(long double __x);
extern long double asinl(long double __x);
extern long double __asinl(long double __x);
extern long double atanl(long double __x);
extern long double __atanl(long double __x);
extern long double atan2l(long double __y, long double __x);
extern long double __atan2l(long double __y, long double __x);
extern long double cosl(long double __x);
extern long double __cosl(long double __x);
extern long double sinl(long double __x);
extern long double __sinl(long double __x);
extern long double tanl(long double __x);
extern long double __tanl(long double __x);
extern long double coshl(long double __x);
extern long double __coshl(long double __x);
extern long double sinhl(long double __x);
extern long double __sinhl(long double __x);
extern long double tanhl(long double __x);
extern long double __tanhl(long double __x);
extern long double acoshl(long double __x);
extern long double __acoshl(long double __x);
extern long double asinhl(long double __x);
extern long double __asinhl(long double __x);
extern long double atanhl(long double __x);
extern long double __atanhl(long double __x);
extern long double expl(long double __x);
extern long double __expl(long double __x);
extern long double frexpl(long double __x, int *__exponent);
extern long double __frexpl(long double __x, int *__exponent);
extern long double ldexpl(long double __x, int __exponent);
extern long double __ldexpl(long double __x, int __exponent);
extern long double logl(long double __x);
extern long double __logl(long double __x);
extern long double log10l(long double __x);
extern long double __log10l(long double __x);
extern long double modfl(long double __x, long double *__iptr);
extern long double __modfl(long double __x, long double *__iptr);
extern long double expm1l(long double __x);
extern long double __expm1l(long double __x);
extern long double log1pl(long double __x);
extern long double __log1pl(long double __x);
extern long double logbl(long double __x);
extern long double __logbl(long double __x);
extern long double exp2l(long double __x);
extern long double __exp2l(long double __x);
extern long double log2l(long double __x);
extern long double __log2l(long double __x);
extern long double powl(long double __x, long double __y);
extern long double __powl(long double __x, long double __y);
extern long double sqrtl(long double __x);
extern long double __sqrtl(long double __x);
extern long double hypotl(long double __x, long double __y);
extern long double __hypotl(long double __x, long double __y);
extern long double cbrtl(long double __x);
extern long double __cbrtl(long double __x);
extern long double ceill(long double __x);
extern long double __ceill(long double __x);
extern long double fabsl(long double __x);
extern long double __fabsl(long double __x);
extern long double floorl(long double __x);
extern long double __floorl(long double __x);
extern long double fmodl(long double __x, long double __y);
extern long double __fmodl(long double __x, long double __y);
extern int isinfl(long double __value);
extern int finitel(long double __value);
extern long double dreml(long double __x, long double __y);
extern long double __dreml(long double __x, long double __y);
extern long double significandl(long double __x);
extern long double __significandl(long double __x);
extern long double copysignl(long double __x, long double __y);
extern long double __copysignl(long double __x, long double __y);
extern long double nanl(const char *__tagb);
extern long double __nanl(const char *__tagb);
extern int isnanl(long double __value);
extern long double j0l(long double );
extern long double __j0l(long double );
extern long double j1l(long double );
extern long double __j1l(long double );
extern long double jnl(int , long double );
extern long double __jnl(int , long double );
extern long double y0l(long double );
extern long double __y0l(long double );
extern long double y1l(long double );
extern long double __y1l(long double );
extern long double ynl(int , long double );
extern long double __ynl(int , long double );
extern long double erfl(long double );
extern long double __erfl(long double );
extern long double erfcl(long double );
extern long double __erfcl(long double );
extern long double lgammal(long double );
extern long double __lgammal(long double );
extern long double tgammal(long double );
extern long double __tgammal(long double );
extern long double gammal(long double );
extern long double __gammal(long double );
extern long double lgammal_r(long double , int *__signgamp);
extern long double __lgammal_r(long double , int *__signgamp);
extern long double rintl(long double __x);
extern long double __rintl(long double __x);
extern long double nextafterl(long double __x, long double __y);
extern long double __nextafterl(long double __x, long double __y);
extern long double nexttowardl(long double __x, long double __y);
extern long double __nexttowardl(long double __x, long double __y);
extern long double remainderl(long double __x, long double __y);
extern long double __remainderl(long double __x, long double __y);
extern long double scalbnl(long double __x, int __n);
extern long double __scalbnl(long double __x, int __n);
extern int ilogbl(long double __x);
extern int __ilogbl(long double __x);
extern long double scalblnl(long double __x, long int __n);
extern long double __scalblnl(long double __x, long int __n);
extern long double nearbyintl(long double __x);
extern long double __nearbyintl(long double __x);
extern long double roundl(long double __x);
extern long double __roundl(long double __x);
extern long double truncl(long double __x);
extern long double __truncl(long double __x);
extern long double remquol(long double __x, long double __y , int *__quo);
extern long double __remquol(long double __x, long double __y , int *__quo);
extern long int lrintl(long double __x);
extern long int __lrintl(long double __x);
__extension__ extern long long int llrintl(long double __x);
extern long long int __llrintl(long double __x);
extern long int lroundl(long double __x);
extern long int __lroundl(long double __x);
__extension__ extern long long int llroundl(long double __x);
extern long long int __llroundl(long double __x);
extern long double fdiml(long double __x, long double __y);
extern long double __fdiml(long double __x, long double __y);
extern long double fmaxl(long double __x, long double __y);
extern long double __fmaxl(long double __x, long double __y);
extern long double fminl(long double __x, long double __y);
extern long double __fminl(long double __x, long double __y);
extern long double fmal(long double __x, long double __y , long double __z);
extern long double __fmal(long double __x, long double __y , long double __z);
extern long double scalbl(long double __x, long double __n);
extern long double __scalbl(long double __x, long double __n);
extern int __fpclassifyf128(_Float128 __value);
extern int __signbitf128(_Float128 __value);
extern int __isinff128(_Float128 __value);
extern int __finitef128(_Float128 __value);
extern int __isnanf128(_Float128 __value);
extern int __iseqsigf128(_Float128 __x, _Float128 __y);
extern int __issignalingf128(_Float128 __value);
extern int signgam;
enum enum_ivp21 {
    FP_NAN = 0, FP_INFINITE = 1 , FP_ZERO = 2 , FP_SUBNORMAL = 3 , FP_NORMAL = 4
} ;
void myWaitAll(int x, int start , int end) {
    return;
}
void myWait(int x, int N , int *p) {
    return;
}
void mWaitAll(struct Clsr *closure) {
    int i;
    struct WaitClsr *waitClosure = closure->waitClosure;
    int currentIteration = waitClosure->currentIteration;
    int startRange = waitClosure->startRange;
    int endRange = waitClosure->endRange;
    int check = 1;
    for (i = startRange; i <= endRange; i++) {
        int waitIteration = i;
        int _imopVarPre161;
        _imopVarPre161 = testAndDecPostbox(currentIteration, waitIteration);
        int checkWaitItrPostBox = _imopVarPre161;
        if (checkWaitItrPostBox == 0) {
            check = 0;
            break;
        }
    }
    if (check == 0) {
        closure->waitClosure->startRange = i;
#pragma omp critical
        {
            enqueueClosure(globalWorklist, closure);
        }
    } else {
        closure->typeClosure = NORMAL;
        closure->waitClosure->startRange = startRange_ivp17;
        void ( *_imopVarPre163 )(struct Clsr *);
        _imopVarPre163 = closure->fptr;
        _imopVarPre163(closure);
    }
}
void mWait(struct Clsr *closure) {
    int i;
    struct WaitClsr *waitClosure = closure->waitClosure;
    int check = 1;
    int start = waitClosure->start;
    int nIters = waitClosure->n_iters;
    int *waitIterations = waitClosure->waitIterations;
    int currentIteration = waitClosure->currentIteration;
    for (i = start; i < nIters; i++) {
        int waitIteration = waitIterations[i];
        int _imopVarPre164;
        _imopVarPre164 = waitIteration < startRange_ivp17;
        if (!_imopVarPre164) {
            _imopVarPre164 = waitIteration > endRange_ivp17;
        }
        if (_imopVarPre164) {
            continue;
        }
        int _imopVarPre165;
        _imopVarPre165 = testAndDecPostbox(currentIteration, waitIteration);
        int checkWaitItrPostBox = _imopVarPre165;
        if (checkWaitItrPostBox == 0) {
            check = 0;
            break;
        }
    }
    if (check == 0) {
        closure->waitClosure->start = i;
#pragma omp critical
        {
            enqueueClosure(globalWorklist, closure);
        }
    } else {
        closure->typeClosure = NORMAL;
        closure->waitClosure->start = 0;
        void ( *_imopVarPre167 )(struct Clsr *);
        _imopVarPre167 = closure->fptr;
        _imopVarPre167(closure);
    }
}
void createWaitClosureAll(int currentIteration, void *( *combine )(struct Msg *, struct Msg *) , void ( *copy )(void *, void *) , void ( *alloc )(struct Msg *) , void *resultVariable , void *initialValue , int startRange , int endRange , struct Clsr **closure , int expr) {
    int n_iters = endRange - startRange + 1;
    unsigned long int _imopVarPre175;
    void *_imopVarPre176;
    _imopVarPre175 = sizeof(struct WaitClsr);
    _imopVarPre176 = malloc(_imopVarPre175);
    struct WaitClsr *waitClosure = (struct WaitClsr *) _imopVarPre176;
    waitClosure->currentIteration = currentIteration;
    waitClosure->expr = expr;
    waitClosure->startRange = startRange;
    waitClosure->endRange = endRange;
    waitClosure->n_iters = n_iters;
    waitClosure->waitFunction = &mWaitAll;
    (*closure)->waitClosure = waitClosure;
    (*closure)->typeClosure = WAIT;
    void ( *_imopVarPre179 )(struct Clsr *);
    struct Clsr *_imopVarPre180;
    _imopVarPre179 = (*closure)->waitClosure->waitFunction;
    _imopVarPre180 = *closure;
    _imopVarPre179(_imopVarPre180);
}
void createWaitClosure(int currentIteration, void *( *combine )(struct Msg *, struct Msg *) , void ( *copy )(void *, void *) , void ( *alloc )(struct Msg *) , void *resultVariable , void *initialValue , int start , int n_iters , int *waitIterations , struct Clsr **closure , int expr) {
    unsigned long int _imopVarPre188;
    void *_imopVarPre189;
    _imopVarPre188 = sizeof(struct WaitClsr);
    _imopVarPre189 = malloc(_imopVarPre188);
    struct WaitClsr *waitClosure = (struct WaitClsr *) _imopVarPre189;
    waitClosure->currentIteration = currentIteration;
    waitClosure->start = start;
    waitClosure->expr = expr;
    waitClosure->n_iters = n_iters;
    waitClosure->waitIterations = waitIterations;
    waitClosure->waitFunction = &mWait;
    (*closure)->waitClosure = waitClosure;
    (*closure)->typeClosure = WAIT;
    void ( *_imopVarPre192 )(struct Clsr *);
    struct Clsr *_imopVarPre193;
    _imopVarPre192 = (*closure)->waitClosure->waitFunction;
    _imopVarPre193 = *closure;
    _imopVarPre192(_imopVarPre193);
}
void mySignalAll(int expr, int start , int end) {
    return;
}
void mySignal(int e, int N , int *p) {
    return;
}
void mSignalAll(int expr, int from , void *message , int start , int end , struct Clsr *closure) {
    int i;
    for (i = start; i <= end; i++) {
        postMessage(from, i, message);
    }
    void ( *_imopVarPre195 )(struct Clsr *);
    _imopVarPre195 = closure->fptr;
    _imopVarPre195(closure);
}
void mSignal(int expr, int from , void *message , int n_iters , int *signalIterations , struct Clsr *closure) {
    if (!expr) {
        void ( *_imopVarPre197 )(struct Clsr *);
        _imopVarPre197 = closure->fptr;
        _imopVarPre197(closure);
    } else {
        int i;
        for (i = 0; i < n_iters; i++) {
            int signalIteration = signalIterations[i];
            int _imopVarPre198;
            _imopVarPre198 = signalIteration < startRange_ivp17;
            if (!_imopVarPre198) {
                _imopVarPre198 = signalIteration > endRange_ivp17;
            }
            if (_imopVarPre198) {
                continue;
            }
            postMessage(from, signalIteration, message);
        }
        void ( *_imopVarPre200 )(struct Clsr *);
        _imopVarPre200 = closure->fptr;
        _imopVarPre200(closure);
    }
}
double **A;
double **B;
void init() {
    printf("======2D Jacobian======\n");
    printf("Input Array Size: %d\n\n", 4096);
    printf("Input Time Steps: %d\n\n", 20);
    int i;
    int j;
    for (i = 0; i < 4096; i++) {
        unsigned long int _imopVarPre202;
        void *_imopVarPre203;
        _imopVarPre202 = sizeof(double);
        _imopVarPre203 = calloc(4096, _imopVarPre202);
        A[i] = _imopVarPre203;
        unsigned long int _imopVarPre205;
        void *_imopVarPre206;
        _imopVarPre205 = sizeof(double);
        _imopVarPre206 = calloc(4096, _imopVarPre205);
        B[i] = _imopVarPre206;
        for (j = 0; j < 4096; j++) {
            A[i][j] = (((double) i) * (j + 2) + 2) / 4096;
            B[i][j] = (((double) i) * (j + 3) + 3) / 4096;
        }
    }
}
int main(int argc, char **argv) {
    unsigned long int _imopVarPre208;
    void *_imopVarPre209;
    _imopVarPre208 = sizeof(double);
    _imopVarPre209 = calloc(4096, _imopVarPre208);
    A = _imopVarPre209;
    unsigned long int _imopVarPre211;
    void *_imopVarPre212;
    _imopVarPre211 = sizeof(double);
    _imopVarPre212 = calloc(4096, _imopVarPre211);
    B = _imopVarPre212;
    init();
    int i;
    int j;
    double itime;
    double ftime;
    double time;
    itime = omp_get_wtime();
#pragma omp parallel private(i)
    {
        int t = 0;
#pragma omp for private(j) nowait
        for (i = 1; i < 4096 - 1; i++) {
            while (t < 20) {
                for (j = 1; j < 4096 - 1; j++) {
                    B[i][j] = 0.2 * (A[i][j] + A[i][j - 1] + A[i][j + 1] + A[i + 1][j] + A[i - 1][j]);
                }
                int wxyz = 0;
                if (1) {
                    int p[] = {i - 1, i + 1};
                    int n_iters = sizeof (p) / sizeof (p[0]);
                    unsigned long int _imopVarPre215;
                    void *_imopVarPre216;
                    _imopVarPre215 = n_iters * sizeof(int);
                    _imopVarPre216 = malloc(_imopVarPre215);
                    int *q_ivp = (int *) _imopVarPre216;
                    int i_ivp = 0;
                    for (i_ivp = 0; i_ivp < n_iters; i_ivp++) {
                        q_ivp[i_ivp] = p[i_ivp];
                    }
                    mySignal(1, n_iters, q_ivp);
                }
                {
                    int wxyz = 0;
                    if (1) {
                        int p[] = {i - 1, i + 1};
                        int n_iters = sizeof (p) / sizeof (p[0]);
                        unsigned long int _imopVarPre219;
                        void *_imopVarPre220;
                        _imopVarPre219 = n_iters * sizeof(int);
                        _imopVarPre220 = malloc(_imopVarPre219);
                        int *q = (int *) _imopVarPre220;
                        int i_ivp = 0;
                        for (i_ivp = 0; i_ivp < n_iters; i_ivp++) {
                            q[i_ivp] = p[i_ivp];
                        }
                        myWait(1, n_iters, q);
                    }
                }
                for (j = 1; j < 4096 - 1; j++) {
                    A[i][j] = B[i][j];
                }
                {
                    int wxyz = 0;
                    if (1) {
                        int p[] = {i - 1, i + 1};
                        int n_iters = sizeof (p) / sizeof (p[0]);
                        unsigned long int _imopVarPre223;
                        void *_imopVarPre224;
                        _imopVarPre223 = n_iters * sizeof(int);
                        _imopVarPre224 = malloc(_imopVarPre223);
                        int *q_ivp = (int *) _imopVarPre224;
                        int i_ivp = 0;
                        for (i_ivp = 0; i_ivp < n_iters; i_ivp++) {
                            q_ivp[i_ivp] = p[i_ivp];
                        }
                        mySignal(1, n_iters, q_ivp);
                    }
                }
                {
                    int wxyz = 0;
                    if (1) {
                        int p[] = {i - 1, i + 1};
                        int n_iters = sizeof (p) / sizeof (p[0]);
                        unsigned long int _imopVarPre227;
                        void *_imopVarPre228;
                        _imopVarPre227 = n_iters * sizeof(int);
                        _imopVarPre228 = malloc(_imopVarPre227);
                        int *q = (int *) _imopVarPre228;
                        int i_ivp = 0;
                        for (i_ivp = 0; i_ivp < n_iters; i_ivp++) {
                            q[i_ivp] = p[i_ivp];
                        }
                        myWait(1, n_iters, q);
                    }
                }
                t++;
            }
        }
// #pragma omp dummyFlush BARRIER_START
#pragma omp barrier
    }
    ftime = omp_get_wtime();
    time = ftime - itime;
    fprintf(stdout, "Runtime = %lf\n", time);
}
