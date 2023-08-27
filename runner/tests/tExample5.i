typedef __builtin_va_list __gnuc_va_list;
typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef short __int16_t;
typedef unsigned short __uint16_t;
typedef int __int32_t;
typedef unsigned int __uint32_t;
typedef long long __int64_t;
typedef unsigned long long __uint64_t;
typedef long __darwin_intptr_t;
typedef unsigned int __darwin_natural_t;
typedef int __darwin_ct_rune_t;
typedef union {
 char __mbstate8[128];
 long long _mbstateL;
} __mbstate_t;
typedef __mbstate_t __darwin_mbstate_t;
typedef long int __darwin_ptrdiff_t;
typedef long unsigned int __darwin_size_t;
typedef __builtin_va_list __darwin_va_list;
typedef int __darwin_wchar_t;
typedef __darwin_wchar_t __darwin_rune_t;
typedef int __darwin_wint_t;
typedef unsigned long __darwin_clock_t;
typedef __uint32_t __darwin_socklen_t;
typedef long __darwin_ssize_t;
typedef long __darwin_time_t;
typedef __int64_t __darwin_blkcnt_t;
typedef __int32_t __darwin_blksize_t;
typedef __int32_t __darwin_dev_t;
typedef unsigned int __darwin_fsblkcnt_t;
typedef unsigned int __darwin_fsfilcnt_t;
typedef __uint32_t __darwin_gid_t;
typedef __uint32_t __darwin_id_t;
typedef __uint64_t __darwin_ino64_t;
typedef __darwin_ino64_t __darwin_ino_t;
typedef __darwin_natural_t __darwin_mach_port_name_t;
typedef __darwin_mach_port_name_t __darwin_mach_port_t;
typedef __uint16_t __darwin_mode_t;
typedef __int64_t __darwin_off_t;
typedef __int32_t __darwin_pid_t;
typedef __uint32_t __darwin_sigset_t;
typedef __int32_t __darwin_suseconds_t;
typedef __uint32_t __darwin_uid_t;
typedef __uint32_t __darwin_useconds_t;
typedef unsigned char __darwin_uuid_t[16];
typedef char __darwin_uuid_string_t[37];
struct __darwin_pthread_handler_rec {
 void (*__routine)(void *);
 void *__arg;
 struct __darwin_pthread_handler_rec *__next;
};
struct _opaque_pthread_attr_t {
 long __sig;
 char __opaque[56];
};
struct _opaque_pthread_cond_t {
 long __sig;
 char __opaque[40];
};
struct _opaque_pthread_condattr_t {
 long __sig;
 char __opaque[8];
};
struct _opaque_pthread_mutex_t {
 long __sig;
 char __opaque[56];
};
struct _opaque_pthread_mutexattr_t {
 long __sig;
 char __opaque[8];
};
struct _opaque_pthread_once_t {
 long __sig;
 char __opaque[8];
};
struct _opaque_pthread_rwlock_t {
 long __sig;
 char __opaque[192];
};
struct _opaque_pthread_rwlockattr_t {
 long __sig;
 char __opaque[16];
};
struct _opaque_pthread_t {
 long __sig;
 struct __darwin_pthread_handler_rec *__cleanup_stack;
 char __opaque[8176];
};
typedef struct _opaque_pthread_attr_t __darwin_pthread_attr_t;
typedef struct _opaque_pthread_cond_t __darwin_pthread_cond_t;
typedef struct _opaque_pthread_condattr_t __darwin_pthread_condattr_t;
typedef unsigned long __darwin_pthread_key_t;
typedef struct _opaque_pthread_mutex_t __darwin_pthread_mutex_t;
typedef struct _opaque_pthread_mutexattr_t __darwin_pthread_mutexattr_t;
typedef struct _opaque_pthread_once_t __darwin_pthread_once_t;
typedef struct _opaque_pthread_rwlock_t __darwin_pthread_rwlock_t;
typedef struct _opaque_pthread_rwlockattr_t __darwin_pthread_rwlockattr_t;
typedef struct _opaque_pthread_t *__darwin_pthread_t;
typedef int __darwin_nl_item;
typedef int __darwin_wctrans_t;
typedef __uint32_t __darwin_wctype_t;
typedef signed char int8_t;
typedef short int16_t;
typedef int int32_t;
typedef long long int64_t;
typedef unsigned char u_int8_t;
typedef unsigned short u_int16_t;
typedef unsigned int u_int32_t;
typedef unsigned long long u_int64_t;
typedef int64_t register_t;
typedef __darwin_intptr_t intptr_t;
typedef unsigned long uintptr_t;
typedef u_int64_t user_addr_t;
typedef u_int64_t user_size_t;
typedef int64_t user_ssize_t;
typedef int64_t user_long_t;
typedef u_int64_t user_ulong_t;
typedef int64_t user_time_t;
typedef int64_t user_off_t;
typedef u_int64_t syscall_arg_t;
typedef __darwin_va_list va_list;
typedef __darwin_size_t size_t;

int renameat(int, const char *, int, const char *) ;
int renamex_np(const char *, const char *, unsigned int) ;
int renameatx_np(int, const char *, int, const char *, unsigned int) ;

typedef __darwin_off_t fpos_t;
struct __sbuf {
 unsigned char *_base;
 int _size;
};
struct __sFILEX;
typedef struct __sFILE {
 unsigned char *_p;
 int _r;
 int _w;
 short _flags;
 short _file;
 struct __sbuf _bf;
 int _lbfsize;
 void *_cookie;
 int (* _close)(void *);
 int (* _read) (void *, char *, int);
 fpos_t (* _seek) (void *, fpos_t, int);
 int (* _write)(void *, const char *, int);
 struct __sbuf _ub;
 struct __sFILEX *_extra;
 int _ur;
 unsigned char _ubuf[3];
 unsigned char _nbuf[1];
 struct __sbuf _lb;
 int _blksize;
 fpos_t _offset;
} FILE;

extern FILE *__stdinp;
extern FILE *__stdoutp;
extern FILE *__stderrp;


void clearerr(FILE *);
int fclose(FILE *);
int feof(FILE *);
int ferror(FILE *);
int fflush(FILE *);
int fgetc(FILE *);
int fgetpos(FILE * restrict, fpos_t *);
char *fgets(char * restrict, int, FILE *);
FILE *fopen(const char * restrict __filename, const char * restrict __mode) __asm("_" "fopen" );
int fprintf(FILE * restrict, const char * restrict, ...) __attribute__((__format__ (__printf__, 2, 3)));
int fputc(int, FILE *);
int fputs(const char * restrict, FILE * restrict) __asm("_" "fputs" );
size_t fread(void * restrict __ptr, size_t __size, size_t __nitems, FILE * restrict __stream);
FILE *freopen(const char * restrict, const char * restrict,
                 FILE * restrict) __asm("_" "freopen" );
int fscanf(FILE * restrict, const char * restrict, ...) __attribute__((__format__ (__scanf__, 2, 3)));
int fseek(FILE *, long, int);
int fsetpos(FILE *, const fpos_t *);
long ftell(FILE *);
size_t fwrite(const void * restrict __ptr, size_t __size, size_t __nitems, FILE * restrict __stream) __asm("_" "fwrite" );
int getc(FILE *);
int getchar(void);
char *gets(char *);
void perror(const char *) __attribute__((__cold__));
int printf(const char * restrict, ...) __attribute__((__format__ (__printf__, 1, 2)));
int putc(int, FILE *);
int putchar(int);
int puts(const char *);
int remove(const char *);
int rename (const char *__old, const char *__new);
void rewind(FILE *);
int scanf(const char * restrict, ...) __attribute__((__format__ (__scanf__, 1, 2)));
void setbuf(FILE * restrict, char * restrict);
int setvbuf(FILE * restrict, char * restrict, int, size_t);
int sprintf(char * restrict, const char * restrict, ...) __attribute__((__format__ (__printf__, 2, 3))) ;
int sscanf(const char * restrict, const char * restrict, ...) __attribute__((__format__ (__scanf__, 2, 3)));
FILE *tmpfile(void);

__attribute__((__deprecated__("This function is provided for compatibility reasons only.  Due to security concerns inherent in the design of tmpnam(3), it is highly recommended that you use mkstemp(3) instead.")))
char *tmpnam(char *);
int ungetc(int, FILE *);
int vfprintf(FILE * restrict, const char * restrict, __gnuc_va_list) __attribute__((__format__ (__printf__, 2, 0)));
int vprintf(const char * restrict, __gnuc_va_list) __attribute__((__format__ (__printf__, 1, 0)));
int vsprintf(char * restrict, const char * restrict, __gnuc_va_list) __attribute__((__format__ (__printf__, 2, 0))) ;


char *ctermid(char *);
FILE *fdopen(int, const char *) __asm("_" "fdopen" );
int fileno(FILE *);


int pclose(FILE *) ;
FILE *popen(const char *, const char *) __asm("_" "popen" ) ;


int __srget(FILE *);
int __svfscanf(FILE *, const char *, __gnuc_va_list) __attribute__((__format__ (__scanf__, 2, 0)));
int __swbuf(int, FILE *);

extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __sputc(int _c, FILE *_p) {
 if (--_p->_w >= 0 || (_p->_w >= _p->_lbfsize && (char)_c != '\n'))
  return (*_p->_p++ = _c);
 else
  return (__swbuf(_c, _p));
}

void flockfile(FILE *);
int ftrylockfile(FILE *);
void funlockfile(FILE *);
int getc_unlocked(FILE *);
int getchar_unlocked(void);
int putc_unlocked(int, FILE *);
int putchar_unlocked(int);
int getw(FILE *);
int putw(int, FILE *);

__attribute__((__deprecated__("This function is provided for compatibility reasons only.  Due to security concerns inherent in the design of tempnam(3), it is highly recommended that you use mkstemp(3) instead.")))
char *tempnam(const char *__dir, const char *__prefix) __asm("_" "tempnam" );

typedef __darwin_off_t off_t;

int fseeko(FILE * __stream, off_t __offset, int __whence);
off_t ftello(FILE * __stream);


int snprintf(char * restrict __str, size_t __size, const char * restrict __format, ...) __attribute__((__format__ (__printf__, 3, 4)));
int vfscanf(FILE * restrict __stream, const char * restrict __format, __gnuc_va_list) __attribute__((__format__ (__scanf__, 2, 0)));
int vscanf(const char * restrict __format, __gnuc_va_list) __attribute__((__format__ (__scanf__, 1, 0)));
int vsnprintf(char * restrict __str, size_t __size, const char * restrict __format, __gnuc_va_list) __attribute__((__format__ (__printf__, 3, 0)));
int vsscanf(const char * restrict __str, const char * restrict __format, __gnuc_va_list) __attribute__((__format__ (__scanf__, 2, 0)));

typedef __darwin_ssize_t ssize_t;

int dprintf(int, const char * restrict, ...) __attribute__((__format__ (__printf__, 2, 3))) ;
int vdprintf(int, const char * restrict, __gnuc_va_list) __attribute__((__format__ (__printf__, 2, 0))) ;
ssize_t getdelim(char ** restrict __linep, size_t * restrict __linecapp, int __delimiter, FILE * restrict __stream) ;
ssize_t getline(char ** restrict __linep, size_t * restrict __linecapp, FILE * restrict __stream) ;
FILE *fmemopen(void * restrict __buf, size_t __size, const char * restrict __mode) ;
FILE *open_memstream(char **__bufp, size_t *__sizep) ;


extern const int sys_nerr;
extern const char *const sys_errlist[];
int asprintf(char ** restrict, const char * restrict, ...) __attribute__((__format__ (__printf__, 2, 3)));
char *ctermid_r(char *);
char *fgetln(FILE *, size_t *);
const char *fmtcheck(const char *, const char *);
int fpurge(FILE *);
void setbuffer(FILE *, char *, int);
int setlinebuf(FILE *);
int vasprintf(char ** restrict, const char * restrict, __gnuc_va_list) __attribute__((__format__ (__printf__, 2, 0)));
FILE *zopen(const char *, const char *, int);
FILE *funopen(const void *,
                 int (* )(void *, char *, int),
                 int (* )(void *, const char *, int),
                 fpos_t (* )(void *, fpos_t, int),
                 int (* )(void *));

extern int __sprintf_chk (char * restrict, int, size_t,
     const char * restrict, ...);
extern int __snprintf_chk (char * restrict, size_t, int, size_t,
      const char * restrict, ...);
extern int __vsprintf_chk (char * restrict, int, size_t,
      const char * restrict, va_list);
extern int __vsnprintf_chk (char * restrict, size_t, int, size_t,
       const char * restrict, va_list);
typedef enum {
 P_ALL,
 P_PID,
 P_PGID
} idtype_t;
typedef __darwin_pid_t pid_t;
typedef __darwin_id_t id_t;
typedef int sig_atomic_t;
struct __darwin_i386_thread_state
{
    unsigned int __eax;
    unsigned int __ebx;
    unsigned int __ecx;
    unsigned int __edx;
    unsigned int __edi;
    unsigned int __esi;
    unsigned int __ebp;
    unsigned int __esp;
    unsigned int __ss;
    unsigned int __eflags;
    unsigned int __eip;
    unsigned int __cs;
    unsigned int __ds;
    unsigned int __es;
    unsigned int __fs;
    unsigned int __gs;
};
struct __darwin_fp_control
{
    unsigned short __invalid :1,
        __denorm :1,
    __zdiv :1,
    __ovrfl :1,
    __undfl :1,
    __precis :1,
      :2,
    __pc :2,
    __rc :2,
             :1,
      :3;
};
typedef struct __darwin_fp_control __darwin_fp_control_t;
struct __darwin_fp_status
{
    unsigned short __invalid :1,
        __denorm :1,
    __zdiv :1,
    __ovrfl :1,
    __undfl :1,
    __precis :1,
    __stkflt :1,
    __errsumm :1,
    __c0 :1,
    __c1 :1,
    __c2 :1,
    __tos :3,
    __c3 :1,
    __busy :1;
};
typedef struct __darwin_fp_status __darwin_fp_status_t;
struct __darwin_mmst_reg
{
 char __mmst_reg[10];
 char __mmst_rsrv[6];
};
struct __darwin_xmm_reg
{
 char __xmm_reg[16];
};
struct __darwin_ymm_reg
{
 char __ymm_reg[32];
};
struct __darwin_zmm_reg
{
 char __zmm_reg[64];
};
struct __darwin_opmask_reg
{
 char __opmask_reg[8];
};
struct __darwin_i386_float_state
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 char __fpu_rsrv4[14*16];
 int __fpu_reserved1;
};
struct __darwin_i386_avx_state
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 char __fpu_rsrv4[14*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
};
struct __darwin_i386_avx512_state
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 char __fpu_rsrv4[14*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
 struct __darwin_opmask_reg __fpu_k0;
 struct __darwin_opmask_reg __fpu_k1;
 struct __darwin_opmask_reg __fpu_k2;
 struct __darwin_opmask_reg __fpu_k3;
 struct __darwin_opmask_reg __fpu_k4;
 struct __darwin_opmask_reg __fpu_k5;
 struct __darwin_opmask_reg __fpu_k6;
 struct __darwin_opmask_reg __fpu_k7;
 struct __darwin_ymm_reg __fpu_zmmh0;
 struct __darwin_ymm_reg __fpu_zmmh1;
 struct __darwin_ymm_reg __fpu_zmmh2;
 struct __darwin_ymm_reg __fpu_zmmh3;
 struct __darwin_ymm_reg __fpu_zmmh4;
 struct __darwin_ymm_reg __fpu_zmmh5;
 struct __darwin_ymm_reg __fpu_zmmh6;
 struct __darwin_ymm_reg __fpu_zmmh7;
};
struct __darwin_i386_exception_state
{
 __uint16_t __trapno;
 __uint16_t __cpu;
 __uint32_t __err;
 __uint32_t __faultvaddr;
};
struct __darwin_x86_debug_state32
{
 unsigned int __dr0;
 unsigned int __dr1;
 unsigned int __dr2;
 unsigned int __dr3;
 unsigned int __dr4;
 unsigned int __dr5;
 unsigned int __dr6;
 unsigned int __dr7;
};
struct __x86_pagein_state
{
 int __pagein_error;
};
struct __darwin_x86_thread_state64
{
 __uint64_t __rax;
 __uint64_t __rbx;
 __uint64_t __rcx;
 __uint64_t __rdx;
 __uint64_t __rdi;
 __uint64_t __rsi;
 __uint64_t __rbp;
 __uint64_t __rsp;
 __uint64_t __r8;
 __uint64_t __r9;
 __uint64_t __r10;
 __uint64_t __r11;
 __uint64_t __r12;
 __uint64_t __r13;
 __uint64_t __r14;
 __uint64_t __r15;
 __uint64_t __rip;
 __uint64_t __rflags;
 __uint64_t __cs;
 __uint64_t __fs;
 __uint64_t __gs;
};
struct __darwin_x86_thread_full_state64
{
 struct __darwin_x86_thread_state64 __ss64;
 __uint64_t __ds;
 __uint64_t __es;
 __uint64_t __ss;
 __uint64_t __gsbase;
};
struct __darwin_x86_float_state64
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 struct __darwin_xmm_reg __fpu_xmm8;
 struct __darwin_xmm_reg __fpu_xmm9;
 struct __darwin_xmm_reg __fpu_xmm10;
 struct __darwin_xmm_reg __fpu_xmm11;
 struct __darwin_xmm_reg __fpu_xmm12;
 struct __darwin_xmm_reg __fpu_xmm13;
 struct __darwin_xmm_reg __fpu_xmm14;
 struct __darwin_xmm_reg __fpu_xmm15;
 char __fpu_rsrv4[6*16];
 int __fpu_reserved1;
};
struct __darwin_x86_avx_state64
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 struct __darwin_xmm_reg __fpu_xmm8;
 struct __darwin_xmm_reg __fpu_xmm9;
 struct __darwin_xmm_reg __fpu_xmm10;
 struct __darwin_xmm_reg __fpu_xmm11;
 struct __darwin_xmm_reg __fpu_xmm12;
 struct __darwin_xmm_reg __fpu_xmm13;
 struct __darwin_xmm_reg __fpu_xmm14;
 struct __darwin_xmm_reg __fpu_xmm15;
 char __fpu_rsrv4[6*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
 struct __darwin_xmm_reg __fpu_ymmh8;
 struct __darwin_xmm_reg __fpu_ymmh9;
 struct __darwin_xmm_reg __fpu_ymmh10;
 struct __darwin_xmm_reg __fpu_ymmh11;
 struct __darwin_xmm_reg __fpu_ymmh12;
 struct __darwin_xmm_reg __fpu_ymmh13;
 struct __darwin_xmm_reg __fpu_ymmh14;
 struct __darwin_xmm_reg __fpu_ymmh15;
};
struct __darwin_x86_avx512_state64
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 struct __darwin_xmm_reg __fpu_xmm8;
 struct __darwin_xmm_reg __fpu_xmm9;
 struct __darwin_xmm_reg __fpu_xmm10;
 struct __darwin_xmm_reg __fpu_xmm11;
 struct __darwin_xmm_reg __fpu_xmm12;
 struct __darwin_xmm_reg __fpu_xmm13;
 struct __darwin_xmm_reg __fpu_xmm14;
 struct __darwin_xmm_reg __fpu_xmm15;
 char __fpu_rsrv4[6*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
 struct __darwin_xmm_reg __fpu_ymmh8;
 struct __darwin_xmm_reg __fpu_ymmh9;
 struct __darwin_xmm_reg __fpu_ymmh10;
 struct __darwin_xmm_reg __fpu_ymmh11;
 struct __darwin_xmm_reg __fpu_ymmh12;
 struct __darwin_xmm_reg __fpu_ymmh13;
 struct __darwin_xmm_reg __fpu_ymmh14;
 struct __darwin_xmm_reg __fpu_ymmh15;
 struct __darwin_opmask_reg __fpu_k0;
 struct __darwin_opmask_reg __fpu_k1;
 struct __darwin_opmask_reg __fpu_k2;
 struct __darwin_opmask_reg __fpu_k3;
 struct __darwin_opmask_reg __fpu_k4;
 struct __darwin_opmask_reg __fpu_k5;
 struct __darwin_opmask_reg __fpu_k6;
 struct __darwin_opmask_reg __fpu_k7;
 struct __darwin_ymm_reg __fpu_zmmh0;
 struct __darwin_ymm_reg __fpu_zmmh1;
 struct __darwin_ymm_reg __fpu_zmmh2;
 struct __darwin_ymm_reg __fpu_zmmh3;
 struct __darwin_ymm_reg __fpu_zmmh4;
 struct __darwin_ymm_reg __fpu_zmmh5;
 struct __darwin_ymm_reg __fpu_zmmh6;
 struct __darwin_ymm_reg __fpu_zmmh7;
 struct __darwin_ymm_reg __fpu_zmmh8;
 struct __darwin_ymm_reg __fpu_zmmh9;
 struct __darwin_ymm_reg __fpu_zmmh10;
 struct __darwin_ymm_reg __fpu_zmmh11;
 struct __darwin_ymm_reg __fpu_zmmh12;
 struct __darwin_ymm_reg __fpu_zmmh13;
 struct __darwin_ymm_reg __fpu_zmmh14;
 struct __darwin_ymm_reg __fpu_zmmh15;
 struct __darwin_zmm_reg __fpu_zmm16;
 struct __darwin_zmm_reg __fpu_zmm17;
 struct __darwin_zmm_reg __fpu_zmm18;
 struct __darwin_zmm_reg __fpu_zmm19;
 struct __darwin_zmm_reg __fpu_zmm20;
 struct __darwin_zmm_reg __fpu_zmm21;
 struct __darwin_zmm_reg __fpu_zmm22;
 struct __darwin_zmm_reg __fpu_zmm23;
 struct __darwin_zmm_reg __fpu_zmm24;
 struct __darwin_zmm_reg __fpu_zmm25;
 struct __darwin_zmm_reg __fpu_zmm26;
 struct __darwin_zmm_reg __fpu_zmm27;
 struct __darwin_zmm_reg __fpu_zmm28;
 struct __darwin_zmm_reg __fpu_zmm29;
 struct __darwin_zmm_reg __fpu_zmm30;
 struct __darwin_zmm_reg __fpu_zmm31;
};
struct __darwin_x86_exception_state64
{
    __uint16_t __trapno;
    __uint16_t __cpu;
    __uint32_t __err;
    __uint64_t __faultvaddr;
};
struct __darwin_x86_debug_state64
{
 __uint64_t __dr0;
 __uint64_t __dr1;
 __uint64_t __dr2;
 __uint64_t __dr3;
 __uint64_t __dr4;
 __uint64_t __dr5;
 __uint64_t __dr6;
 __uint64_t __dr7;
};
struct __darwin_x86_cpmu_state64
{
 __uint64_t __ctrs[16];
};
struct __darwin_mcontext32
{
 struct __darwin_i386_exception_state __es;
 struct __darwin_i386_thread_state __ss;
 struct __darwin_i386_float_state __fs;
};
struct __darwin_mcontext_avx32
{
 struct __darwin_i386_exception_state __es;
 struct __darwin_i386_thread_state __ss;
 struct __darwin_i386_avx_state __fs;
};
struct __darwin_mcontext_avx512_32
{
 struct __darwin_i386_exception_state __es;
 struct __darwin_i386_thread_state __ss;
 struct __darwin_i386_avx512_state __fs;
};
struct __darwin_mcontext64
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_state64 __ss;
 struct __darwin_x86_float_state64 __fs;
};
struct __darwin_mcontext64_full
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_full_state64 __ss;
 struct __darwin_x86_float_state64 __fs;
};
struct __darwin_mcontext_avx64
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_state64 __ss;
 struct __darwin_x86_avx_state64 __fs;
};
struct __darwin_mcontext_avx64_full
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_full_state64 __ss;
 struct __darwin_x86_avx_state64 __fs;
};
struct __darwin_mcontext_avx512_64
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_state64 __ss;
 struct __darwin_x86_avx512_state64 __fs;
};
struct __darwin_mcontext_avx512_64_full
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_full_state64 __ss;
 struct __darwin_x86_avx512_state64 __fs;
};
typedef struct __darwin_mcontext64 *mcontext_t;
typedef __darwin_pthread_attr_t pthread_attr_t;
struct __darwin_sigaltstack
{
 void *ss_sp;
 __darwin_size_t ss_size;
 int ss_flags;
};
typedef struct __darwin_sigaltstack stack_t;
struct __darwin_ucontext
{
 int uc_onstack;
 __darwin_sigset_t uc_sigmask;
 struct __darwin_sigaltstack uc_stack;
 struct __darwin_ucontext *uc_link;
 __darwin_size_t uc_mcsize;
 struct __darwin_mcontext64 *uc_mcontext;
};
typedef struct __darwin_ucontext ucontext_t;
typedef __darwin_sigset_t sigset_t;
typedef __darwin_uid_t uid_t;
union sigval {
 int sival_int;
 void *sival_ptr;
};
struct sigevent {
 int sigev_notify;
 int sigev_signo;
 union sigval sigev_value;
 void (*sigev_notify_function)(union sigval);
 pthread_attr_t *sigev_notify_attributes;
};
typedef struct __siginfo {
 int si_signo;
 int si_errno;
 int si_code;
 pid_t si_pid;
 uid_t si_uid;
 int si_status;
 void *si_addr;
 union sigval si_value;
 long si_band;
 unsigned long __pad[7];
} siginfo_t;
union __sigaction_u {
 void (*__sa_handler)(int);
 void (*__sa_sigaction)(int, struct __siginfo *,
     void *);
};
struct __sigaction {
 union __sigaction_u __sigaction_u;
 void (*sa_tramp)(void *, int, int, siginfo_t *, void *);
 sigset_t sa_mask;
 int sa_flags;
};
struct sigaction {
 union __sigaction_u __sigaction_u;
 sigset_t sa_mask;
 int sa_flags;
};
typedef void (*sig_t)(int);
struct sigvec {
 void (*sv_handler)(int);
 int sv_mask;
 int sv_flags;
};
struct sigstack {
 char *ss_sp;
 int ss_onstack;
};

    void(*signal(int, void (*)(int)))(int);

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;
typedef int8_t int_least8_t;
typedef int16_t int_least16_t;
typedef int32_t int_least32_t;
typedef int64_t int_least64_t;
typedef uint8_t uint_least8_t;
typedef uint16_t uint_least16_t;
typedef uint32_t uint_least32_t;
typedef uint64_t uint_least64_t;
typedef int8_t int_fast8_t;
typedef int16_t int_fast16_t;
typedef int32_t int_fast32_t;
typedef int64_t int_fast64_t;
typedef uint8_t uint_fast8_t;
typedef uint16_t uint_fast16_t;
typedef uint32_t uint_fast32_t;
typedef uint64_t uint_fast64_t;
typedef long int intmax_t;
typedef long unsigned int uintmax_t;
struct timeval
{
 __darwin_time_t tv_sec;
 __darwin_suseconds_t tv_usec;
};
typedef __uint64_t rlim_t;
struct rusage {
 struct timeval ru_utime;
 struct timeval ru_stime;
 long ru_maxrss;
 long ru_ixrss;
 long ru_idrss;
 long ru_isrss;
 long ru_minflt;
 long ru_majflt;
 long ru_nswap;
 long ru_inblock;
 long ru_oublock;
 long ru_msgsnd;
 long ru_msgrcv;
 long ru_nsignals;
 long ru_nvcsw;
 long ru_nivcsw;
};
typedef void *rusage_info_t;
struct rusage_info_v0 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
};
struct rusage_info_v1 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
 uint64_t ri_child_user_time;
 uint64_t ri_child_system_time;
 uint64_t ri_child_pkg_idle_wkups;
 uint64_t ri_child_interrupt_wkups;
 uint64_t ri_child_pageins;
 uint64_t ri_child_elapsed_abstime;
};
struct rusage_info_v2 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
 uint64_t ri_child_user_time;
 uint64_t ri_child_system_time;
 uint64_t ri_child_pkg_idle_wkups;
 uint64_t ri_child_interrupt_wkups;
 uint64_t ri_child_pageins;
 uint64_t ri_child_elapsed_abstime;
 uint64_t ri_diskio_bytesread;
 uint64_t ri_diskio_byteswritten;
};
struct rusage_info_v3 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
 uint64_t ri_child_user_time;
 uint64_t ri_child_system_time;
 uint64_t ri_child_pkg_idle_wkups;
 uint64_t ri_child_interrupt_wkups;
 uint64_t ri_child_pageins;
 uint64_t ri_child_elapsed_abstime;
 uint64_t ri_diskio_bytesread;
 uint64_t ri_diskio_byteswritten;
 uint64_t ri_cpu_time_qos_default;
 uint64_t ri_cpu_time_qos_maintenance;
 uint64_t ri_cpu_time_qos_background;
 uint64_t ri_cpu_time_qos_utility;
 uint64_t ri_cpu_time_qos_legacy;
 uint64_t ri_cpu_time_qos_user_initiated;
 uint64_t ri_cpu_time_qos_user_interactive;
 uint64_t ri_billed_system_time;
 uint64_t ri_serviced_system_time;
};
struct rusage_info_v4 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
 uint64_t ri_child_user_time;
 uint64_t ri_child_system_time;
 uint64_t ri_child_pkg_idle_wkups;
 uint64_t ri_child_interrupt_wkups;
 uint64_t ri_child_pageins;
 uint64_t ri_child_elapsed_abstime;
 uint64_t ri_diskio_bytesread;
 uint64_t ri_diskio_byteswritten;
 uint64_t ri_cpu_time_qos_default;
 uint64_t ri_cpu_time_qos_maintenance;
 uint64_t ri_cpu_time_qos_background;
 uint64_t ri_cpu_time_qos_utility;
 uint64_t ri_cpu_time_qos_legacy;
 uint64_t ri_cpu_time_qos_user_initiated;
 uint64_t ri_cpu_time_qos_user_interactive;
 uint64_t ri_billed_system_time;
 uint64_t ri_serviced_system_time;
 uint64_t ri_logical_writes;
 uint64_t ri_lifetime_max_phys_footprint;
 uint64_t ri_instructions;
 uint64_t ri_cycles;
 uint64_t ri_billed_energy;
 uint64_t ri_serviced_energy;
 uint64_t ri_interval_max_phys_footprint;
 uint64_t ri_runnable_time;
};
typedef struct rusage_info_v4 rusage_info_current;
struct rlimit {
 rlim_t rlim_cur;
 rlim_t rlim_max;
};
struct proc_rlimit_control_wakeupmon {
 uint32_t wm_flags;
 int32_t wm_rate;
};

int getpriority(int, id_t);
int getiopolicy_np(int, int) ;
int getrlimit(int, struct rlimit *) __asm("_" "getrlimit" );
int getrusage(int, struct rusage *);
int setpriority(int, id_t, int);
int setiopolicy_np(int, int, int) ;
int setrlimit(int, const struct rlimit *) __asm("_" "setrlimit" );

static inline
__uint16_t
_OSSwapInt16(
 __uint16_t _data
 )
{
 return (__uint16_t)((_data << 8) | (_data >> 8));
}
static inline
__uint32_t
_OSSwapInt32(
 __uint32_t _data
 )
{
 __asm__ ("bswap   %0" : "+r" (_data));
 return _data;
}
static inline
__uint64_t
_OSSwapInt64(
 __uint64_t _data
 )
{
 __asm__ ("bswap   %0" : "+r" (_data));
 return _data;
}
union wait {
 int w_status;
 struct {
  unsigned int w_Termsig:7,
      w_Coredump:1,
      w_Retcode:8,
      w_Filler:16;
 } w_T;
 struct {
  unsigned int w_Stopval:8,
      w_Stopsig:8,
      w_Filler:16;
 } w_S;
};

pid_t wait(int *) __asm("_" "wait" );
pid_t waitpid(pid_t, int *, int) __asm("_" "waitpid" );
int waitid(idtype_t, id_t, siginfo_t *, int) __asm("_" "waitid" );
pid_t wait3(int *, int, struct rusage *);
pid_t wait4(pid_t, int *, int, struct rusage *);


void *alloca(size_t);

typedef __darwin_ct_rune_t ct_rune_t;
typedef __darwin_rune_t rune_t;
typedef __darwin_wchar_t wchar_t;
typedef struct {
 int quot;
 int rem;
} div_t;
typedef struct {
 long quot;
 long rem;
} ldiv_t;
typedef struct {
 long long quot;
 long long rem;
} lldiv_t;
extern int __mb_cur_max;

void *malloc(size_t __size) __attribute__((__warn_unused_result__)) __attribute__((alloc_size(1)));
void *calloc(size_t __count, size_t __size) __attribute__((__warn_unused_result__)) __attribute__((alloc_size(1,2)));
void free(void *);
void *realloc(void *__ptr, size_t __size) __attribute__((__warn_unused_result__)) __attribute__((alloc_size(2)));
void *valloc(size_t) __attribute__((alloc_size(1)));
void *aligned_alloc(size_t __alignment, size_t __size) __attribute__((__warn_unused_result__)) __attribute__((alloc_size(2))) ;
int posix_memalign(void **__memptr, size_t __alignment, size_t __size) ;


void abort(void) __attribute__((__cold__)) __attribute__((__noreturn__));
int abs(int) __attribute__((__const__));
int atexit(void (* )(void));
double atof(const char *);
int atoi(const char *);
long atol(const char *);
long long
  atoll(const char *);
void *bsearch(const void *__key, const void *__base, size_t __nel,
     size_t __width, int (* __compar)(const void *, const void *));
div_t div(int, int) __attribute__((__const__));
void exit(int) __attribute__((__noreturn__));
char *getenv(const char *);
long labs(long) __attribute__((__const__));
ldiv_t ldiv(long, long) __attribute__((__const__));
long long
  llabs(long long);
lldiv_t lldiv(long long, long long);
int mblen(const char *__s, size_t __n);
size_t mbstowcs(wchar_t * restrict , const char * restrict, size_t);
int mbtowc(wchar_t * restrict, const char * restrict, size_t);
void qsort(void *__base, size_t __nel, size_t __width,
     int (* __compar)(const void *, const void *));
int rand(void) ;
void srand(unsigned) ;
double strtod(const char *, char **) __asm("_" "strtod" );
float strtof(const char *, char **) __asm("_" "strtof" );
long strtol(const char *__str, char **__endptr, int __base);
long double
  strtold(const char *, char **);
long long
  strtoll(const char *__str, char **__endptr, int __base);
unsigned long
  strtoul(const char *__str, char **__endptr, int __base);
unsigned long long
  strtoull(const char *__str, char **__endptr, int __base);



int system(const char *) __asm("_" "system" );
size_t wcstombs(char * restrict, const wchar_t * restrict, size_t);
int wctomb(char *, wchar_t);
void _Exit(int) __attribute__((__noreturn__));
long a64l(const char *);
double drand48(void);
char *ecvt(double, int, int *restrict, int *restrict);
double erand48(unsigned short[3]);
char *fcvt(double, int, int *restrict, int *restrict);
char *gcvt(double, int, char *);
int getsubopt(char **, char * const *, char **);
int grantpt(int);
char *initstate(unsigned, char *, size_t);
long jrand48(unsigned short[3]) ;
char *l64a(long);
void lcong48(unsigned short[7]);
long lrand48(void) ;
char *mktemp(char *);
int mkstemp(char *);
long mrand48(void) ;
long nrand48(unsigned short[3]) ;
int posix_openpt(int);
char *ptsname(int);
int ptsname_r(int fildes, char *buffer, size_t buflen) ;
int putenv(char *) __asm("_" "putenv" );
long random(void) ;
int rand_r(unsigned *) ;
char *realpath(const char * restrict, char * restrict) __asm("_" "realpath" "$DARWIN_EXTSN");
unsigned short
 *seed48(unsigned short[3]);
int setenv(const char * __name, const char * __value, int __overwrite) __asm("_" "setenv" );
void setkey(const char *) __asm("_" "setkey" );
char *setstate(const char *);
void srand48(long);
void srandom(unsigned);
int unlockpt(int);
int unsetenv(const char *) __asm("_" "unsetenv" );
typedef __darwin_dev_t dev_t;
typedef __darwin_mode_t mode_t;
uint32_t arc4random(void);
void arc4random_addrandom(unsigned char * , int )
   
   
   
    ;
void arc4random_buf(void * __buf, size_t __nbytes) ;
void arc4random_stir(void);
uint32_t
  arc4random_uniform(uint32_t __upper_bound) ;
char *cgetcap(char *, const char *, int);
int cgetclose(void);
int cgetent(char **, char **, const char *);
int cgetfirst(char **, char **);
int cgetmatch(const char *, const char *);
int cgetnext(char **, char **);
int cgetnum(char *, const char *, long *);
int cgetset(const char *);
int cgetstr(char *, const char *, char **);
int cgetustr(char *, const char *, char **);
int daemon(int, int) __asm("_" "daemon" "$1050") ;
char *devname(dev_t, mode_t);
char *devname_r(dev_t, mode_t, char *buf, int len);
char *getbsize(int *, long *);
int getloadavg(double [], int);
const char
 *getprogname(void);
void setprogname(const char *);
int heapsort(void *__base, size_t __nel, size_t __width,
     int (* __compar)(const void *, const void *));
int mergesort(void *__base, size_t __nel, size_t __width,
     int (* __compar)(const void *, const void *));
void psort(void *__base, size_t __nel, size_t __width,
     int (* __compar)(const void *, const void *))
     ;
void psort_r(void *__base, size_t __nel, size_t __width, void *,
     int (* __compar)(void *, const void *, const void *))
     ;
void qsort_r(void *__base, size_t __nel, size_t __width, void *,
     int (* __compar)(void *, const void *, const void *));
int radixsort(const unsigned char **__base, int __nel, const unsigned char *__table,
     unsigned __endbyte);
int rpmatch(const char *)
 ;
int sradixsort(const unsigned char **__base, int __nel, const unsigned char *__table,
     unsigned __endbyte);
void sranddev(void);
void srandomdev(void);
void *reallocf(void *__ptr, size_t __size) __attribute__((alloc_size(2)));
long long
  strtoq(const char *__str, char **__endptr, int __base);
unsigned long long
  strtouq(const char *__str, char **__endptr, int __base);
extern char *suboptarg;

typedef struct
{
  unsigned char _x[64]
    __attribute__((__aligned__(8)));
} omp_lock_t;
typedef struct
{
  unsigned char _x[80]
    __attribute__((__aligned__(8)));
} omp_nest_lock_t;
typedef enum omp_sched_t
{
  omp_sched_static = 1,
  omp_sched_dynamic = 2,
  omp_sched_guided = 3,
  omp_sched_auto = 4,
  omp_sched_monotonic = 0x80000000U
} omp_sched_t;
typedef enum omp_proc_bind_t
{
  omp_proc_bind_false = 0,
  omp_proc_bind_true = 1,
  omp_proc_bind_master = 2,
  omp_proc_bind_close = 3,
  omp_proc_bind_spread = 4
} omp_proc_bind_t;
typedef enum omp_sync_hint_t
{
  omp_sync_hint_none = 0,
  omp_lock_hint_none = omp_sync_hint_none,
  omp_sync_hint_uncontended = 1,
  omp_lock_hint_uncontended = omp_sync_hint_uncontended,
  omp_sync_hint_contended = 2,
  omp_lock_hint_contended = omp_sync_hint_contended,
  omp_sync_hint_nonspeculative = 4,
  omp_lock_hint_nonspeculative
    = omp_sync_hint_nonspeculative,
  omp_sync_hint_speculative = 8,
  omp_lock_hint_speculative = omp_sync_hint_speculative
} omp_sync_hint_t;
typedef omp_sync_hint_t omp_lock_hint_t;
typedef struct __attribute__((__aligned__ (sizeof (void *)))) omp_depend_t
{
  char __omp_depend_t__[2 * sizeof (void *)];
} omp_depend_t;
typedef enum omp_pause_resource_t
{
  omp_pause_soft = 1,
  omp_pause_hard = 2
} omp_pause_resource_t;
typedef long unsigned int omp_uintptr_t;
typedef enum omp_memspace_handle_t
{
  omp_default_mem_space = 0,
  omp_large_cap_mem_space = 1,
  omp_const_mem_space = 2,
  omp_high_bw_mem_space = 3,
  omp_low_lat_mem_space = 4,
  __omp_memspace_handle_t_max__ = 0xffffffffffffffffUL
} omp_memspace_handle_t;
typedef enum omp_allocator_handle_t
{
  omp_null_allocator = 0,
  omp_default_mem_alloc = 1,
  omp_large_cap_mem_alloc = 2,
  omp_const_mem_alloc = 3,
  omp_high_bw_mem_alloc = 4,
  omp_low_lat_mem_alloc = 5,
  omp_cgroup_mem_alloc = 6,
  omp_pteam_mem_alloc = 7,
  omp_thread_mem_alloc = 8,
  __omp_allocator_handle_t_max__ = 0xffffffffffffffffUL
} omp_allocator_handle_t;
typedef enum omp_alloctrait_key_t
{
  omp_atk_sync_hint = 1,
  omp_atk_alignment = 2,
  omp_atk_access = 3,
  omp_atk_pool_size = 4,
  omp_atk_fallback = 5,
  omp_atk_fb_data = 6,
  omp_atk_pinned = 7,
  omp_atk_partition = 8
} omp_alloctrait_key_t;
typedef enum omp_alloctrait_value_t
{
  omp_atv_default = (long unsigned int) -1,
  omp_atv_false = 0,
  omp_atv_true = 1,
  omp_atv_contended = 3,
  omp_atv_uncontended = 4,
  omp_atv_serialized = 5,
  omp_atv_sequential = omp_atv_serialized,
  omp_atv_private = 6,
  omp_atv_all = 7,
  omp_atv_thread = 8,
  omp_atv_pteam = 9,
  omp_atv_cgroup = 10,
  omp_atv_default_mem_fb = 11,
  omp_atv_null_fb = 12,
  omp_atv_abort_fb = 13,
  omp_atv_allocator_fb = 14,
  omp_atv_environment = 15,
  omp_atv_nearest = 16,
  omp_atv_blocked = 17,
  omp_atv_interleaved = 18
} omp_alloctrait_value_t;
typedef struct omp_alloctrait_t
{
  omp_alloctrait_key_t key;
  omp_uintptr_t value;
} omp_alloctrait_t;
typedef enum omp_event_handle_t
{
  __omp_event_handle_t_max__ = 0xffffffffffffffffUL
} omp_event_handle_t;
extern void omp_set_num_threads (int) __attribute__((__nothrow__));
extern int omp_get_num_threads (void) __attribute__((__nothrow__));
extern int omp_get_max_threads (void) __attribute__((__nothrow__));
extern int omp_get_thread_num (void) __attribute__((__nothrow__));
extern int omp_get_num_procs (void) __attribute__((__nothrow__));
extern int omp_in_parallel (void) __attribute__((__nothrow__));
extern void omp_set_dynamic (int) __attribute__((__nothrow__));
extern int omp_get_dynamic (void) __attribute__((__nothrow__));
extern void omp_set_nested (int) __attribute__((__nothrow__)) ;
extern int omp_get_nested (void) __attribute__((__nothrow__)) ;
extern void omp_init_lock (omp_lock_t *) __attribute__((__nothrow__));
extern void omp_init_lock_with_hint (omp_lock_t *, omp_sync_hint_t)
  __attribute__((__nothrow__));
extern void omp_destroy_lock (omp_lock_t *) __attribute__((__nothrow__));
extern void omp_set_lock (omp_lock_t *) __attribute__((__nothrow__));
extern void omp_unset_lock (omp_lock_t *) __attribute__((__nothrow__));
extern int omp_test_lock (omp_lock_t *) __attribute__((__nothrow__));
extern void omp_init_nest_lock (omp_nest_lock_t *) __attribute__((__nothrow__));
extern void omp_init_nest_lock_with_hint (omp_nest_lock_t *, omp_sync_hint_t)
  __attribute__((__nothrow__));
extern void omp_destroy_nest_lock (omp_nest_lock_t *) __attribute__((__nothrow__));
extern void omp_set_nest_lock (omp_nest_lock_t *) __attribute__((__nothrow__));
extern void omp_unset_nest_lock (omp_nest_lock_t *) __attribute__((__nothrow__));
extern int omp_test_nest_lock (omp_nest_lock_t *) __attribute__((__nothrow__));
extern double omp_get_wtime (void) __attribute__((__nothrow__));
extern double omp_get_wtick (void) __attribute__((__nothrow__));
extern void omp_set_schedule (omp_sched_t, int) __attribute__((__nothrow__));
extern void omp_get_schedule (omp_sched_t *, int *) __attribute__((__nothrow__));
extern int omp_get_thread_limit (void) __attribute__((__nothrow__));
extern void omp_set_max_active_levels (int) __attribute__((__nothrow__));
extern int omp_get_max_active_levels (void) __attribute__((__nothrow__));
extern int omp_get_supported_active_levels (void) __attribute__((__nothrow__));
extern int omp_get_level (void) __attribute__((__nothrow__));
extern int omp_get_ancestor_thread_num (int) __attribute__((__nothrow__));
extern int omp_get_team_size (int) __attribute__((__nothrow__));
extern int omp_get_active_level (void) __attribute__((__nothrow__));
extern int omp_in_final (void) __attribute__((__nothrow__));
extern int omp_get_cancellation (void) __attribute__((__nothrow__));
extern omp_proc_bind_t omp_get_proc_bind (void) __attribute__((__nothrow__));
extern int omp_get_num_places (void) __attribute__((__nothrow__));
extern int omp_get_place_num_procs (int) __attribute__((__nothrow__));
extern void omp_get_place_proc_ids (int, int *) __attribute__((__nothrow__));
extern int omp_get_place_num (void) __attribute__((__nothrow__));
extern int omp_get_partition_num_places (void) __attribute__((__nothrow__));
extern void omp_get_partition_place_nums (int *) __attribute__((__nothrow__));
extern void omp_set_default_device (int) __attribute__((__nothrow__));
extern int omp_get_default_device (void) __attribute__((__nothrow__));
extern int omp_get_num_devices (void) __attribute__((__nothrow__));
extern int omp_get_num_teams (void) __attribute__((__nothrow__));
extern int omp_get_team_num (void) __attribute__((__nothrow__));
extern int omp_is_initial_device (void) __attribute__((__nothrow__));
extern int omp_get_initial_device (void) __attribute__((__nothrow__));
extern int omp_get_max_task_priority (void) __attribute__((__nothrow__));
extern void omp_fulfill_event (omp_event_handle_t) __attribute__((__nothrow__));
extern void *omp_target_alloc (long unsigned int, int) __attribute__((__nothrow__));
extern void omp_target_free (void *, int) __attribute__((__nothrow__));
extern int omp_target_is_present (const void *, int) __attribute__((__nothrow__));
extern int omp_target_memcpy (void *, const void *, long unsigned int,
         long unsigned int, long unsigned int, int, int)
  __attribute__((__nothrow__));
extern int omp_target_memcpy_rect (void *, const void *, long unsigned int, int,
       const long unsigned int *,
       const long unsigned int *,
       const long unsigned int *,
       const long unsigned int *,
       const long unsigned int *, int, int)
  __attribute__((__nothrow__));
extern int omp_target_associate_ptr (const void *, const void *, long unsigned int,
         long unsigned int, int) __attribute__((__nothrow__));
extern int omp_target_disassociate_ptr (const void *, int) __attribute__((__nothrow__));
extern void omp_set_affinity_format (const char *) __attribute__((__nothrow__));
extern long unsigned int omp_get_affinity_format (char *, long unsigned int)
  __attribute__((__nothrow__));
extern void omp_display_affinity (const char *) __attribute__((__nothrow__));
extern long unsigned int omp_capture_affinity (char *, long unsigned int, const char *)
  __attribute__((__nothrow__));
extern int omp_pause_resource (omp_pause_resource_t, int) __attribute__((__nothrow__));
extern int omp_pause_resource_all (omp_pause_resource_t) __attribute__((__nothrow__));
extern omp_allocator_handle_t omp_init_allocator (omp_memspace_handle_t,
        int,
        const omp_alloctrait_t [])
  __attribute__((__nothrow__));
extern void omp_destroy_allocator (omp_allocator_handle_t) __attribute__((__nothrow__));
extern void omp_set_default_allocator (omp_allocator_handle_t) __attribute__((__nothrow__));
extern omp_allocator_handle_t omp_get_default_allocator (void) __attribute__((__nothrow__));
extern void *omp_alloc (long unsigned int,
   omp_allocator_handle_t )
  __attribute__((__nothrow__)) __attribute__((__malloc__, __alloc_size__ (1)));
extern void omp_free (void *,
        omp_allocator_handle_t )
  __attribute__((__nothrow__));
struct Clsr;
struct WaitClsr;
struct RedClsr;
struct WLQueue;
struct ClsrNode;
struct QueueNode;
struct QueueStruct;
struct CommStruct;
struct PostBoxStruct;
struct Msg;
enum typeClsr;
omp_lock_t *lock;
struct Msg *createMessage(void *);
struct QueueNode *createNode(void *);
struct QueueStruct *createQueue();
void printMessage(struct Msg *);
void printQueue(struct QueueStruct *);
void enQueueMessage(struct QueueStruct *, void *);
struct Msg *deQueueMessage(struct QueueStruct *);
void incrementCounter(int ,int );
void decrementCounter(int ,int );
int checkPostbox(int, int );
void postMessage(int, int, void *);
void initialisePostBox(int ,int );
void myWait(int,int,int *);
void myWaitAll(int,int,int);
void mWait(int ,struct Clsr *, int *, int, int);
void executeWaitClosure(struct Clsr *closure);
struct WaitClsr *createWaitClosureAll(int, int,void *(*combine)(void *,void *),void (*copy)(void *,struct RedClsr *),void *,int,int,struct Clsr *);
struct WaitClsr *createWaitClosure(int , int ,void *(*combine)(void *,void *),void (*copy)(void *,struct RedClsr *),void *, int , int ,int *,struct Clsr *);
struct Clsr *createClosure(enum typeClsr ,void (*fptr)(struct Clsr *),void *, struct Clsr *);
void createReadyWorklist();
void createPendingWorklist();
struct WLQueue *createWorklistQueue();
struct ClsrNode *createClosureNode(struct Clsr *);
int isEmptyWorklist(struct WLQueue *);
void enqueueClosure(struct WLQueue *,struct Clsr *);
struct Clsr *dequeueClosure(struct WLQueue *);
void executeReadyWorkList(struct WLQueue *,int *);
int isIdleThreads(int *);
void mySignal(int ,int ,int *);
void mySignalAll(int,int,int);
void mSignalAll(int,int,void *,int,int,struct Clsr *);
void mSignal(int, int,void *,int ,int *,struct Clsr *);
void scheduler(struct WLQueue *, omp_lock_t *,int ,int *);
void lastFunction(struct Clsr *closure){
    if(closure != 0){
        free(closure);
    }
}
struct Msg{
    void *message;
};
struct QueueNode{
    struct Msg *message;
    struct QueueNode *next;
};
struct QueueStruct{
    struct QueueNode *front,*rear;
};
struct CommStruct{
    int counter;
    omp_lock_t *lock;
    struct QueueStruct *messages;
};
struct PostBoxStruct{
    struct CommStruct *communicators;
};
struct PostBoxStruct **p;
void COPYINT(void *result, struct RedClsr *reductionClosure){
    *(int *)(reductionClosure->redVar) = *(int *)result;
}
void COPYFLOAT(void *result, struct RedClsr *reductionClosure){
    *(float *)(reductionClosure->redVar) = *(float *)result;
}
void COPYDOUBLE(void *result, struct RedClsr *reductionClosure){
    *(double *)(reductionClosure->redVar) = *(double *)result;
}
void COPYCHAR(void *result, struct RedClsr *reductionClosure){
    *(char *)(reductionClosure->redVar) = *(char *)result;
}
void *ADDINT(void *operand1, void *operand2){
    int op1 = *(int *)operand1;
    int op2 = *(int *)operand2;
    int *result = (int *)malloc(sizeof(int));
    *result = op1 + op2;
    return result;
}
void *ADDFLOAT(void *operand1, void *operand2){
    float op1 = *(float *)operand1;
    float op2 = *(float *)operand2;
    float *result = (float *)malloc(sizeof(float));
    *result = op1 + op2;
    return result;
}
void *ADDDOUBLE(void *operand1, void *operand2){
    double op1 = *(double *)operand1;
    double op2 = *(double *)operand2;
    double *result = (double *)malloc(sizeof(double));
    *result = op1 + op2;
    return result;
}
void *SUBINT(void *operand1, void *operand2){
    int op1 = *(int *)operand1;
    int op2 = *(int *)operand2;
    int *result = (int *)malloc(sizeof(int));
    *result = op1 - op2;
    return result;
}
void *SUBFLOAT(void *operand1, void *operand2){
    float op1 = *(float *)operand1;
    float op2 = *(float *)operand2;
    float *result = (float *)malloc(sizeof(float));
    *result = op1 - op2;
    return result;
}
void *SUBDOUBLE(void *operand1, void *operand2){
    double op1 = *(double *)operand1;
    double op2 = *(double *)operand2;
    double *result = (double *)malloc(sizeof(double));
    *result = op1 - op2;
    return result;
}
void *MULINT(void *operand1, void *operand2){
    int op1 = *(int *)operand1;
    int op2 = *(int *)operand2;
    int *result = (int *)malloc(sizeof(int));
    *result = op1 * op2;
    return result;
}
void *MULFLOAT(void *operand1, void *operand2){
    float op1 = *(float *)operand1;
    float op2 = *(float *)operand2;
    float *result = (float *)malloc(sizeof(float));
    *result = op1 * op2;
    return result;
}
void *MULDOUBLE(void *operand1, void *operand2){
    double op1 = *(double *)operand1;
    double op2 = *(double *)operand2;
    double *result = (double *)malloc(sizeof(double));
    *result = op1 * op2;
    return result;
}
void *DIVINT(void *operand1, void *operand2){
    int op1 = *(int *)operand1;
    int op2 = *(int *)operand2;
    int *result = (int *)malloc(sizeof(int));
    *result = op1 / op2;
    return result;
}
void *DIVFLOAT(void *operand1, void *operand2){
    float op1 = *(float *)operand1;
    float op2 = *(float *)operand2;
    float *result = (float *)malloc(sizeof(float));
    *result = op1 / op2;
    return result;
}
void *DIVDOUBLE(void *operand1, void *operand2){
    double op1 = *(double *)operand1;
    double op2 = *(double *)operand2;
    double *result = (double *)malloc(sizeof(double));
    *result = op1 / op2;
    return result;
}
struct Msg *createMessage(void *message){
    struct Msg *msg = (struct Msg *)malloc(sizeof(struct Msg));
    if(msg==0){
        printf("Couldn't create Message.\n");
        return 0;
    }else{
        msg->message = message;
        return msg;
    }
}
struct QueueNode *createNode(void *message){
    struct Msg *msg = createMessage(message);
    struct QueueNode *tempNode = (struct QueueNode *)malloc(sizeof(struct QueueNode));
    if(tempNode==0){
        printf("Couldn't create Queue Node.\n");
        return 0;
    }else{
        tempNode->message = msg;
        tempNode->next = 0;
        return tempNode;
    }
}
struct QueueStruct *createQueue(){
    struct QueueStruct *queue = (struct QueueStruct *)malloc(sizeof(struct QueueStruct));
    if(queue==0){
        printf("Couldn't create Queue.\n");
        return 0;
    }else{
        queue->front = 0;
        queue->rear = 0;
        return queue;
    }
}
int isEmpty(struct QueueStruct *queue){
    if(queue==0){
        return 1;
    }
    if(queue->front==0){
        return 1;
    }
    return 0;
}
struct Msg *deQueueMessage(struct QueueStruct *queue){
     if(isEmpty(queue)){
        return 0;
    }
    struct QueueNode *qNode = queue->front;
    queue->front = queue->front->next;
    if(queue->front==0){
        queue = 0;
    }
    return qNode->message;
}
void enQueueMessage(struct QueueStruct *queue, void *message){
    struct QueueNode *newNode = createNode(message);
    if(queue->rear==0){
        queue->front=newNode;
        queue->rear=newNode;
        return;
    }
    queue->rear->next = newNode;
    queue->rear = newNode;
}
void incrementCounter(int from,int to){
    (p[to]->communicators[from].counter)++;
}
void decrementCounter(int from,int to){
    (p[from]->communicators[to].counter)--;
}
int checkPostbox(int currentIteration, int waitIteration){
    while(!omp_test_lock(p[currentIteration]->communicators[waitIteration].lock));
    int counter = p[currentIteration]->communicators[waitIteration].counter;
    if(counter > 0){
        decrementCounter(currentIteration,waitIteration);
        omp_unset_lock(p[currentIteration]->communicators[waitIteration].lock);
        return 1;
    }
    omp_unset_lock(p[currentIteration]->communicators[waitIteration].lock);
    return 0;
}
struct Msg *receiveMessage(int receiver,int sender){
    while(!omp_test_lock(p[receiver]->communicators[sender].lock));
    struct CommStruct communicator = p[receiver]->communicators[sender];
    struct QueueStruct *messages = communicator.messages;
    struct Msg *message = deQueueMessage(messages);
    omp_unset_lock(p[receiver]->communicators[sender].lock);
    return message;
}
void postMessage(int from, int to, void *message){
    while(!omp_test_lock(p[to]->communicators[from].lock));
    incrementCounter(from,to);
    enQueueMessage(p[to]->communicators[from].messages,message);
    omp_unset_lock(p[to]->communicators[from].lock);
}
void initialisePostBox(int n_p,int n_c){
   p = (struct PostBoxStruct **)malloc(n_p*sizeof(struct PostBoxStruct *));
   int i,j;
   for(i = 0;i < n_p;i++){
       p[i] = (struct PostBoxStruct *)malloc(sizeof(struct PostBoxStruct));
       p[i]->communicators = (struct CommStruct *)malloc(n_c*sizeof(struct CommStruct));
       for(j = 0;j < n_c;j++){
           p[i]->communicators[j].messages = createQueue();
           p[i]->communicators[j].lock = (omp_lock_t *)malloc(sizeof(omp_lock_t));
           omp_init_lock(p[i]->communicators[j].lock);
       }
   }
}
enum typeClsr{
    NORMAL,
    REDUCTION,
    WAIT
};
struct WaitClsr{
    int currentIteration;
    int expr;
    int n_iters;
    int start;
    int startRange;
    int endRange;
    int *waitIterations;
    struct RedClsr *rednClsr;
    void (*waitFunc)(struct Clsr *);
};
struct RedClsr{
    int nReductions;
    int iteration;
    struct Msg *messages;
    void (*copyFunction)(void *,struct RedClsr *);
    void *(*redFunction)(void *,void *);
    void *redVar;
};
struct Clsr{
    void (*fptr)(struct Clsr *);
    enum typeClsr typeClosure;
    void *environment;
    struct WaitClsr *waitClsr;
    struct Clsr *continuation;
};
struct Clsr *createClosure(enum typeClsr type,void (*fptr)(struct Clsr *),void *env, struct Clsr *continuation){
    struct Clsr *closure = (struct Clsr *)malloc(sizeof(struct Clsr));
    closure->typeClosure = type;
    closure->fptr = fptr;
    closure->environment = env;
    closure->continuation = continuation;
    return closure;
}
struct ClsrNode{
    struct Clsr *closure;
    struct ClsrNode *next;
};
struct WLQueue{
    struct ClsrNode *front,*rear;
};
struct WLQueue *globalWorklist;
struct WLQueue *createWorklistQueue(){
    struct WLQueue *workListQueue = (struct WLQueue *)malloc(sizeof(struct WLQueue));
    workListQueue->front = ((void *)0);
    workListQueue->rear = ((void *)0);
    return workListQueue;
}
struct ClsrNode *createClosureNode(struct Clsr *closure){
    struct ClsrNode *closureNode = (struct ClsrNode *)malloc(sizeof(struct ClsrNode));
    closureNode->closure = closure;
    closureNode->next = ((void *)0);
    return closureNode;
}
int isEmptyWorklist(struct WLQueue *workListQueue){
    if(workListQueue==((void *)0)){
        return 1;
    }
    if(workListQueue->front==((void *)0)){
        return 1;
    }
    return 0;
}
void enqueueClosure(struct WLQueue *queue,struct Clsr *closure){
    struct ClsrNode *closureNode = createClosureNode(closure);
    if(isEmptyWorklist(queue)){
        queue->front = closureNode;
        queue->rear = closureNode;
        return;
    }
    queue->rear->next = closureNode;
    queue->rear = closureNode;
}
struct Clsr *dequeueClosure(struct WLQueue *queue){
    if(isEmptyWorklist(queue)){
        return ((void *)0);
    }
    struct ClsrNode *closureNode = queue->front;
    struct Clsr *closure = closureNode->closure;
    queue->front = queue->front->next;
    if(queue->front==((void *)0)){
        queue = ((void *)0);
    }
    return closure;
}
int checkThreadStatus(int *threadStatus){
    int i = 0;
    for(i = 0;i<omp_get_num_threads();i++){
        if(threadStatus[i]){
            return 1;
        }
    }
    return 0;
}
void executeReadyWorkList(struct WLQueue *readyWorkList,int *threadStatus){
    while(!isEmptyWorklist(readyWorkList)){
        struct Clsr *closure = dequeueClosure(readyWorkList);
        if(closure == ((void *)0)){
            return;
        }
        if(closure->typeClosure == NORMAL){
            closure->fptr(closure);
        }else if (closure->typeClosure==WAIT){
             struct WaitClsr *waitClsr = closure->waitClsr;
            waitClsr->waitFunc(closure);
        }
    }
    threadStatus[omp_get_thread_num()] = 0;
}
void scheduler(struct WLQueue *readyWorklist, omp_lock_t *lock,int K,int *threadStatus){
    while(1){
        while(!omp_test_lock(lock));
        int isEmptyGlobalWorklist = isEmptyWorklist(globalWorklist);
        if(isEmptyGlobalWorklist){
            int threadStatusFlag = checkThreadStatus(threadStatus);
            if(threadStatusFlag){
                omp_unset_lock(lock);
                continue;
            }else{
                omp_unset_lock(lock);
                break;
            }
        }else{
            int count = K;
            while(count--){
                struct Clsr *closure = dequeueClosure(globalWorklist);
                if(closure==((void *)0)){
                    break;
                }
                enqueueClosure(readyWorklist,closure);
            }
            threadStatus[omp_get_thread_num()] = 1;
            omp_unset_lock(lock);
            executeReadyWorkList(readyWorklist,threadStatus);
            threadStatus[omp_get_thread_num()] = 0;
        }
    }
}
void *COPY(void *a,struct RedClsr *redClsr){
    return 0;
}
void *ADD(void *a,void *b){
    return 0;
}
void *SUB(void *a,void *b){
    return 0;
}
void *MULT(void *a,void *b){
    return 0;
}
void *DIV(void *a,void *b){
    return 0;
}
void myWaitAll(int x,int start,int end){
    return;
}
void myWait(int x,int N, int *p){
    return;
}
void myWaitRed(int x,void *reductionVariable,int N,int *p,void *(*fptr)(struct Msg *m1, struct Msg *m2)){
    return;
}
void myWaitAllRed(int x,void *reductionVariable,int start,int end,void *(*fptr)(struct Msg *m1, struct Msg *m2)){
    return;
}
struct Msg *performReduction(struct RedClsr *reductionClosure){
    int i;
    int N = reductionClosure->nReductions;
    struct Msg *result = (struct Msg *)malloc(sizeof(struct Msg));
    for(i=0;i<N;i++){
        struct Msg message = reductionClosure->messages[i];
        if(i==0){
            result->message = message.message;
        }else{
            result->message = reductionClosure->redFunction(result->message,message.message);
        }
        reductionClosure->copyFunction(result->message,reductionClosure);
    }
    printf("Result = %lf\n",result->message);
    return result;
}
void mWaitAll(int currentIteration, int n_iters,struct Clsr *closure,int startRange, int endRange){
    int i;
    struct RedClsr *reductionClosure = 0;
    if(closure->waitClsr->rednClsr!=0){
        reductionClosure = closure->waitClsr->rednClsr;
    }
    for(i=startRange;i<=endRange;i++){
        int waitIteration = i;
        if(!checkPostbox(currentIteration,waitIteration)){
            break;
        }
        if(reductionClosure!=0){
            struct Msg *message = receiveMessage(currentIteration,waitIteration);
            reductionClosure->messages[(reductionClosure->iteration)++] = *message;
        }
    }
    if(i!=n_iters){
        closure->waitClsr->startRange = i;
        enqueueClosure(globalWorklist,closure);
    }else{
        if(reductionClosure!=0){
            struct Msg *result = performReduction(reductionClosure);
        }
        closure->typeClosure = NORMAL;
        closure->fptr(closure);
    }
}
void mWait(int currentIteration,struct Clsr *closure,
                    int *waitIterations, int n_iters,
                    int start){
    int i;
    struct RedClsr *reductionClosure = 0;
    if(closure->waitClsr->rednClsr!=0){
        reductionClosure = closure->waitClsr->rednClsr;
    }
    for(i=start;i<n_iters;i++){
        int waitIteration = waitIterations[i];
        if(!checkPostbox(currentIteration,waitIteration)){
            break;
        }
        if(reductionClosure!=0){
            struct Msg *message = receiveMessage(currentIteration,waitIteration);
            reductionClosure->messages[reductionClosure->iteration++] = *message;
        }
    }
    if(i!=n_iters){
        closure->waitClsr->start = i;
        enqueueClosure(globalWorklist,closure);
    }else{
        if(reductionClosure!=0){
            struct Msg *result = performReduction(reductionClosure);
        }
        closure->typeClosure = NORMAL;
        closure->fptr(closure);
    }
}
void executeWaitClosureAll(struct Clsr *closure){
    struct WaitClsr *waitClosure = closure->waitClsr;
    int currentIteration = waitClosure->currentIteration;
    int expr = waitClosure->expr;
    int startRange = waitClosure->startRange;
    int endRange = waitClosure->endRange;
    int n_iters = waitClosure->n_iters;
    mWaitAll(currentIteration,n_iters, closure, startRange, endRange);
}
void executeWaitClosure(struct Clsr *closure){
    struct WaitClsr *waitClosure = closure->waitClsr;
    int currentIteration = waitClosure->currentIteration;
    int expr = waitClosure->expr;
    int n_iters = waitClosure->n_iters;
    int start = waitClosure->start;
    int *waitIterations = waitClosure->waitIterations;
    mWait(currentIteration, closure,waitIterations, n_iters, start);
}
struct WaitClsr *createWaitClosureAll(int currentIteration, int expr,void *(*combine)(void *,void *),void (*copy)(void *,struct RedClsr *),
                                             void *redVar,int startRange,int endRange,struct Clsr *newK){
    if(!expr){
            return 0;
    }
    struct WaitClsr *waitClosure = ( struct WaitClsr *)malloc(sizeof( struct WaitClsr ));
    waitClosure->currentIteration = currentIteration;
    waitClosure->expr = expr;
    waitClosure->startRange = startRange;
    waitClosure->endRange = endRange;
    waitClosure->n_iters = endRange - startRange + 1;
    waitClosure->waitFunc = &executeWaitClosureAll;
    if(combine!=0){
        waitClosure->rednClsr = (struct RedClsr *)malloc(sizeof(struct RedClsr));
        waitClosure->rednClsr->nReductions = waitClosure->n_iters;
        waitClosure->rednClsr->iteration = 0;
        waitClosure->rednClsr->redFunction = combine;
        waitClosure->rednClsr->redVar = redVar;
        waitClosure->rednClsr->copyFunction = copy;
        waitClosure->rednClsr->messages = (struct Msg *)malloc(waitClosure->n_iters * sizeof(struct Msg ));
    }
    return waitClosure;
}
struct WaitClsr *createWaitClosure(int currentIteration, int expr,void *(*combine)(void *,void *),void (*copy)(void *,struct RedClsr *),
                                              void *redVar, int start, int n_iters,
                                              int *waitIterations,struct Clsr *newK){
    if(!expr){
            return 0;
    }
    printf("n_iters=%d\n",n_iters);
    struct WaitClsr *waitClosure = (struct WaitClsr *)malloc(sizeof(struct WaitClsr));
    waitClosure->currentIteration = currentIteration;
    waitClosure->expr = expr;
    waitClosure->start = start;
    waitClosure->waitIterations = waitIterations;
    waitClosure->waitFunc = &executeWaitClosure;
    if(combine!=0){
        waitClosure->rednClsr = (struct RedClsr *)malloc(sizeof(struct RedClsr));
        waitClosure->rednClsr->nReductions = n_iters;
        waitClosure->rednClsr->iteration = 0;
        waitClosure->rednClsr->redFunction = combine;
        waitClosure->rednClsr->redVar = redVar;
        waitClosure->rednClsr->copyFunction = copy;
        waitClosure->rednClsr->messages = (struct Msg *)malloc(n_iters * sizeof(struct Msg ));
    }
    return waitClosure;
}
void mySignalAllSend(int expr,void *message,int start,int end){
    return;
}
void mySignalAll(int expr,int start,int end){
    return;
}
void mySignalSend(int expr,void *message,int N,int *p){
    return;
}
void mySignal(int e,int N,int *p){
    return;
}
void mSignalAll(int expr,int from, void *message, int start,int end,struct Clsr *closure){
    if(!expr){
        closure->fptr(closure);
        return;
    }
    int i;
    for(i=start;i<=end;i++){
        int signalIteration = i;
        postMessage(from,signalIteration,message);
    }
    closure->fptr(closure);
}
void mSignal(int expr, int from,void *message,int n_iters,int *signalIterations,struct Clsr *closure){
    if(!expr){
        closure->fptr(closure);
        return;
    }
    printf("Signaling iteration %d from iteration %d\n",signalIterations[0],from);
    int i;
    for(i = 0;i < n_iters;i++){
        int signalIteration = signalIterations[i];
        postMessage(from,signalIteration,message);
    }
    closure->fptr(closure);
}
int main(){
    int i;
    int x = 0;
    int y = 0;
#pragma omp parallel private(i)
    {
        int n_iters = 1;
#pragma omp for
        for (i=0;i<100;i++)
        {
            {int p[]={i-1};int n_iters = sizeof(p)/sizeof(p[0]); int *q_ivp =(int *) malloc(n_iters * sizeof(int)); int i_ivp = 0; for(i_ivp=0;i_ivp<n_iters;i_ivp++) q_ivp[i_ivp] = p[i_ivp]; mySignalSend(i==2,3, n_iters, q_ivp);}
            {int p[]={i+1};int n_iters = sizeof(p)/sizeof(p[0]); int *q_ivp =(int *) malloc(n_iters * sizeof(int)); int i_ivp = 0; for(i_ivp=0;i_ivp<n_iters;i_ivp++) q_ivp[i_ivp] = p[i_ivp]; mySignalSend(i==0,4, n_iters, q_ivp);}
            { int p[] = {i-1,i+1}; int n_iters = sizeof(p)/sizeof(p[0]); int *q = (int *)malloc(n_iters * sizeof(int)); int i_ivp = 0;for(i_ivp=0;i_ivp<n_iters;i_ivp++) q[i_ivp] = p[i_ivp]; myWaitRed(i==1,x,n_iters,q,ADD);}
            printf("%d\n",x);
        }
    }
}
