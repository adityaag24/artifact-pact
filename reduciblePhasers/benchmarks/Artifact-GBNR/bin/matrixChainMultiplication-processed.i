struct internal_tf_ivp30 ;
int nIters_ivp4;
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
    unsigned short int _imopVarPre21;
    _imopVarPre21 = __builtin_bswap16(__bsx);
    return _imopVarPre21;
}
static __inline __uint32_t __bswap_32(__uint32_t __bsx) {
    unsigned int _imopVarPre97;
    _imopVarPre97 = __builtin_bswap32(__bsx);
    return _imopVarPre97;
}
__extension__ static __inline __uint64_t __bswap_64(__uint64_t __bsx) {
    unsigned long int _imopVarPre98;
    _imopVarPre98 = __builtin_bswap64(__bsx);
    return _imopVarPre98;
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
    NORMAL, WAIT , DONE
} ;
struct Clsr ;
struct master_env ;
struct WaitClsr {
    void ( *waitFunction )(struct Clsr *);
} ;
struct Clsr {
    void ( *fptr )(struct Clsr *);
    enum typeClsr typeClosure;
    int iteration;
    struct master_env *environment;
    struct WaitClsr *waitClosure;
} ;
struct Clsr **readyWorkList;
int startRange_ivp17;
int endRange_ivp17;
int nThreads_ivp17;
int *leftPointer;
int *rightPointer;
struct Clsr *createClosure(enum typeClsr , void ( *fptr )(struct Clsr *) , int );
void myWaitAll(int );
void mWaitAll(struct Clsr *);
void lastFunction(struct Clsr *closure) {
    closure->typeClosure = DONE;
}
struct Clsr *createClosure(enum typeClsr type, void ( *fptr )(struct Clsr *) , int currentIteration) {
    unsigned long int _imopVarPre102;
    void *_imopVarPre103;
    _imopVarPre102 = sizeof(struct Clsr);
    _imopVarPre103 = malloc(_imopVarPre102);
    struct Clsr *closure = (struct Clsr *) _imopVarPre103;
    closure->typeClosure = type;
    closure->fptr = fptr;
    closure->iteration = currentIteration;
    return closure;
}
void executeReadyWorkList() {
    int _imopVarPre104;
    _imopVarPre104 = omp_get_thread_num();
    int tid = _imopVarPre104;
    int leftPtr = leftPointer[tid];
    int rightPtr = rightPointer[tid];
    int i;
    int chunkSize = rightPtr - leftPtr + 1;
    while (1) {
        int done = 0;
        for (i = leftPtr; i <= rightPtr; i++) {
            struct Clsr *closure = readyWorkList[i];
            if (closure->typeClosure == NORMAL) {
                void ( *_imopVarPre106 )(struct Clsr *);
                _imopVarPre106 = closure->fptr;
                _imopVarPre106(closure);
            } else {
                if (closure->typeClosure == WAIT) {
                    struct WaitClsr *waitClosure = closure->waitClosure;
                    void ( *_imopVarPre108 )(struct Clsr *);
                    _imopVarPre108 = waitClosure->waitFunction;
                    _imopVarPre108(closure);
                }
            }
            if (closure->typeClosure == DONE) {
                done++;
            }
        }
        if (done == chunkSize) {
            break;
        }
    }
}
void myWaitAll(int x) {
    return;
}
void mWaitAll(struct Clsr *closure) {
    int _imopVarPre109;
    _imopVarPre109 = omp_get_thread_num();
    int tid = _imopVarPre109;
    int currentIteration = closure->iteration;
    if (currentIteration == rightPointer[tid]) {
// #pragma omp dummyFlush BARRIER_START
#pragma omp barrier
        closure->typeClosure = NORMAL;
    } else {
        closure->typeClosure = NORMAL;
    }
}
int N;
int *P;
int **M;
int print_val() {
    int i;
    int j;
    for (i = 0; i <= N; i++) {
        for (j = 0; j <= N; j++) {
            int _imopVarPre113;
            _imopVarPre113 = M[i][j];
            printf("%d\t", _imopVarPre113);
        }
        printf("\n");
    }
}
struct Clsr *clsr_v_ivp1;
struct ENV_PRIVATE_ivp8 {
    int i;
} ;
struct master_env {
    struct internal_tf_ivp30 *internal_vf_ivp31;
    struct internal_t_ivp33 *internal_v_ivp32;
    struct internal_t_ivp35 *internal_v_ivp34;
} ;
struct internal_tf_ivp30 {
    void ( *continuation )(struct Clsr *);
    struct ENV_PRIVATE_ivp8 *envp_c_ivp3;
    int i_ivp14;
} ;
void ompfor_ivp36(struct Clsr *clsr_v_ivp1);
struct internal_t_ivp33 {
    void ( *continuation )(struct Clsr *);
    int i;
    int l;
} ;
void matrix_paranth_for_len_ivp64(int i, int l , struct Clsr *clsr_v_ivp1);
struct internal_t_ivp35 {
    void ( *continuation )(struct Clsr *);
    int i;
    int l;
    int j;
    int k;
    int v;
    int _imopVarPre111;
} ;
void fun_ivp28_ivp67(int i, int l , struct Clsr *clsr_v_ivp1);
void clsr_ivp76(struct Clsr *clsr_v_ivp1);
int main(int argc, char **argv) {
    double itime;
    double ftime;
    double time;
    FILE *fp;
    if (argc > 1) {
        char *_imopVarPre115;
        struct _IO_FILE *_imopVarPre116;
        _imopVarPre115 = argv[1];
        _imopVarPre116 = fopen(_imopVarPre115, "r");
        fp = _imopVarPre116;
        if (fp == ((void *) 0)) {
            char *_imopVarPre118;
            _imopVarPre118 = argv[1];
            printf("[ERROR] : Failed to read file named '%s'.\n", _imopVarPre118);
            exit(1);
        }
    } else {
        char *_imopVarPre120;
        _imopVarPre120 = argv[0];
        printf("USAGE : %s [filename].\n", _imopVarPre120);
        exit(1);
    }
    int *_imopVarPre122;
    _imopVarPre122 = &N;
    fscanf(fp, "%d", _imopVarPre122);
    int i;
    unsigned long int _imopVarPre125;
    int _imopVarPre126;
    void *_imopVarPre127;
    _imopVarPre125 = sizeof(int);
    _imopVarPre126 = N + 1;
    _imopVarPre127 = calloc(_imopVarPre126, _imopVarPre125);
    P = _imopVarPre127;
    for (i = 0; i <= N; i++) {
        int *_imopVarPre129;
        _imopVarPre129 = &P[i];
        fscanf(fp, "%d", _imopVarPre129);
    }
    unsigned long int _imopVarPre133;
    int _imopVarPre134;
    void *_imopVarPre135;
    _imopVarPre133 = sizeof(int *);
    _imopVarPre134 = N + 1;
    _imopVarPre135 = calloc(_imopVarPre134, _imopVarPre133);
    M = (int **) _imopVarPre135;
    for (i = 0; i <= N; i++) {
        unsigned long int _imopVarPre139;
        int _imopVarPre140;
        void *_imopVarPre141;
        _imopVarPre139 = sizeof(int);
        _imopVarPre140 = N + 1;
        _imopVarPre141 = calloc(_imopVarPre140, _imopVarPre139);
        M[i] = (int *) _imopVarPre141;
    }
    for (i = 0; i <= N; i++) {
        M[i][i] = 0;
    }
    itime = omp_get_wtime();
#pragma omp parallel
    {
        int _imopVarPre63;
        struct ENV_PRIVATE_ivp8 *env_p_ivp9;
        void *env_p_ivp12;
        int tempSize_ivp13 = sizeof(struct ENV_PRIVATE_ivp8);
        env_p_ivp12 = malloc(tempSize_ivp13);
        env_p_ivp9 = (struct ENV_PRIVATE_ivp8 *) env_p_ivp12;
        int i;
        i = (env_p_ivp9->i);
#pragma omp single nowait
        {
            startRange_ivp17 = 1;
            endRange_ivp17 = N;
            nThreads_ivp17 = omp_get_num_threads();
            nIters_ivp4 = endRange_ivp17 - startRange_ivp17 + 1;
            unsigned long int _imopVarPre17;
            void *_imopVarPre18;
            _imopVarPre17 = nThreads_ivp17 * sizeof(int);
            _imopVarPre18 = malloc(_imopVarPre17);
            leftPointer = (int *) _imopVarPre18;
            unsigned long int _imopVarPre21;
            void *_imopVarPre22;
            _imopVarPre21 = nThreads_ivp17 * sizeof(int);
            _imopVarPre22 = malloc(_imopVarPre21);
            rightPointer = (int *) _imopVarPre22;
            unsigned long int _imopVarPre25;
            void *_imopVarPre26;
            _imopVarPre25 = (nIters_ivp4 + startRange_ivp17) * sizeof(struct Clsr *);
            _imopVarPre26 = malloc(_imopVarPre25);
            readyWorkList = (struct Clsr **) _imopVarPre26;
        }
// #pragma omp dummyFlush BARRIER_START
#pragma omp barrier
        _imopVarPre63 = omp_get_thread_num();
        int tid_ivp17 = _imopVarPre63;
        leftPointer[tid_ivp17] = nIters_ivp4 + startRange_ivp17;
        rightPointer[tid_ivp17] = -1;
#pragma omp for nowait
        for (i = 1; i <= N; i++) {
            struct ENV_PRIVATE_ivp8 *envp_c_ivp3;
            void *envp_t_ivp10;
            int tempSize_ivp11 = sizeof(struct ENV_PRIVATE_ivp8);
            envp_t_ivp10 = malloc(tempSize_ivp11);
            envp_c_ivp3 = (struct ENV_PRIVATE_ivp8 *) envp_t_ivp10;
            envp_c_ivp3->i = (env_p_ivp9->i);
            envp_c_ivp3->i = i;
            void ( *_imopVarPre39 )(struct Clsr *clsr_v_ivp1);
            struct Clsr *_imopVarPre40;
            _imopVarPre39 = &ompfor_ivp36;
            _imopVarPre40 = createClosure(NORMAL, _imopVarPre39, i);
            struct Clsr *clsr_v_ivp1 = _imopVarPre40;
            unsigned long int _imopVarPre43;
            void *_imopVarPre44;
            _imopVarPre43 = sizeof(struct master_env);
            _imopVarPre44 = malloc(_imopVarPre43);
            clsr_v_ivp1->environment = (struct master_env *) _imopVarPre44;
            unsigned long int _imopVarPre47;
            void *_imopVarPre48;
            _imopVarPre47 = sizeof(struct internal_tf_ivp30);
            _imopVarPre48 = malloc(_imopVarPre47);
            clsr_v_ivp1->environment->internal_vf_ivp31 = (struct internal_tf_ivp30 *) _imopVarPre48;
            clsr_v_ivp1->environment->internal_vf_ivp31->continuation = &lastFunction;
            int _imopVarPre50;
            _imopVarPre50 = omp_get_thread_num();
            if (i < leftPointer[_imopVarPre50]) {
                int _imopVarPre51;
                _imopVarPre51 = omp_get_thread_num();
                leftPointer[_imopVarPre51] = i;
            }
            int _imopVarPre53;
            _imopVarPre53 = omp_get_thread_num();
            if (i > rightPointer[_imopVarPre53]) {
                int _imopVarPre54;
                _imopVarPre54 = omp_get_thread_num();
                rightPointer[_imopVarPre54] = i;
            }
            readyWorkList[i] = clsr_v_ivp1;
            unsigned long int _imopVarPre57;
            void *_imopVarPre58;
            _imopVarPre57 = sizeof(struct internal_t_ivp33);
            _imopVarPre58 = malloc(_imopVarPre57);
            clsr_v_ivp1->environment->internal_v_ivp32 = (struct internal_t_ivp33 *) _imopVarPre58;
            unsigned long int _imopVarPre61;
            void *_imopVarPre62;
            _imopVarPre61 = sizeof(struct internal_t_ivp35);
            _imopVarPre62 = malloc(_imopVarPre61);
            clsr_v_ivp1->environment->internal_v_ivp34 = (struct internal_t_ivp35 *) _imopVarPre62;
            clsr_v_ivp1->environment->internal_vf_ivp31->envp_c_ivp3 = envp_c_ivp3;
        }
// #pragma omp dummyFlush BARRIER_START
#pragma omp barrier
        executeReadyWorkList();
    }
    ftime = omp_get_wtime();
    time = ftime - itime;
    fprintf(stderr, "Run time = ");
    fprintf(stderr, "%lf seconds\n", time);
    return 0;
}
void ompfor_ivp36(struct Clsr *clsr_v_ivp1) {
    clsr_v_ivp1->environment->internal_vf_ivp31->i_ivp14 = (clsr_v_ivp1->environment->internal_vf_ivp31->envp_c_ivp3->i);
    int i_ivp14_ivp37;
    i_ivp14_ivp37 = clsr_v_ivp1->environment->internal_vf_ivp31->i_ivp14;
    clsr_v_ivp1->environment->internal_v_ivp32->continuation = clsr_v_ivp1->environment->internal_vf_ivp31->continuation;
    matrix_paranth_for_len_ivp64(i_ivp14_ivp37, 2, clsr_v_ivp1);
}
void matrix_paranth_for_len_ivp64(int i, int l , struct Clsr *clsr_v_ivp1) {
    clsr_v_ivp1->environment->internal_v_ivp32->i = i;
    clsr_v_ivp1->environment->internal_v_ivp32->l = l;
    if (clsr_v_ivp1->environment->internal_v_ivp32->l <= N) {
        int i_ivp65;
        int l_ivp66;
        i_ivp65 = clsr_v_ivp1->environment->internal_v_ivp32->i;
        l_ivp66 = clsr_v_ivp1->environment->internal_v_ivp32->l;
        clsr_v_ivp1->environment->internal_v_ivp34->continuation = clsr_v_ivp1->environment->internal_v_ivp32->continuation;
        fun_ivp28_ivp67(i_ivp65, l_ivp66, clsr_v_ivp1);
    } else {
        clsr_v_ivp1->fptr = clsr_v_ivp1->environment->internal_v_ivp32->continuation;
        void ( *_imopVarPre73 )(struct Clsr *);
        _imopVarPre73 = clsr_v_ivp1->fptr;
        _imopVarPre73(clsr_v_ivp1);
    }
}
void fun_ivp28_ivp67(int i, int l , struct Clsr *clsr_v_ivp1) {
    clsr_v_ivp1->environment->internal_v_ivp34->i = i;
    clsr_v_ivp1->environment->internal_v_ivp34->l = l;
    if (clsr_v_ivp1->environment->internal_v_ivp34->i <= N - clsr_v_ivp1->environment->internal_v_ivp34->l + 1) {
        clsr_v_ivp1->environment->internal_v_ivp34->j = clsr_v_ivp1->environment->internal_v_ivp34->i + clsr_v_ivp1->environment->internal_v_ivp34->l - 1;
        M[clsr_v_ivp1->environment->internal_v_ivp34->i][clsr_v_ivp1->environment->internal_v_ivp34->j] = 0x7fffffff;
        for (clsr_v_ivp1->environment->internal_v_ivp34->k = clsr_v_ivp1->environment->internal_v_ivp34->i; clsr_v_ivp1->environment->internal_v_ivp34->k < clsr_v_ivp1->environment->internal_v_ivp34->j; clsr_v_ivp1->environment->internal_v_ivp34->k++) {
            clsr_v_ivp1->environment->internal_v_ivp34->v = M[clsr_v_ivp1->environment->internal_v_ivp34->i][clsr_v_ivp1->environment->internal_v_ivp34->k] + M[clsr_v_ivp1->environment->internal_v_ivp34->k + 1][clsr_v_ivp1->environment->internal_v_ivp34->j] + P[clsr_v_ivp1->environment->internal_v_ivp34->i - 1] * P[clsr_v_ivp1->environment->internal_v_ivp34->k] * P[clsr_v_ivp1->environment->internal_v_ivp34->j];
            if (clsr_v_ivp1->environment->internal_v_ivp34->v < M[clsr_v_ivp1->environment->internal_v_ivp34->i][clsr_v_ivp1->environment->internal_v_ivp34->j]) {
                M[clsr_v_ivp1->environment->internal_v_ivp34->i][clsr_v_ivp1->environment->internal_v_ivp34->j] = clsr_v_ivp1->environment->internal_v_ivp34->v;
            }
        }
    }
    clsr_v_ivp1->fptr = &clsr_ivp76;
    mWaitAll(clsr_v_ivp1);
}
void clsr_ivp76(struct Clsr *clsr_v_ivp1) {
    clsr_v_ivp1->environment->internal_v_ivp34->_imopVarPre111 = clsr_v_ivp1->environment->internal_v_ivp34->l + 1;
    int i_ivp69;
    int _imopVarPre111_ivp70;
    i_ivp69 = clsr_v_ivp1->environment->internal_v_ivp34->i;
    _imopVarPre111_ivp70 = clsr_v_ivp1->environment->internal_v_ivp34->_imopVarPre111;
    clsr_v_ivp1->environment->internal_v_ivp32->continuation = clsr_v_ivp1->environment->internal_v_ivp34->continuation;
    matrix_paranth_for_len_ivp64(i_ivp69, _imopVarPre111_ivp70, clsr_v_ivp1);
}
