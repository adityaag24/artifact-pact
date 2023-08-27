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


    typedef float float_t;
    typedef double double_t;
extern int __math_errhandling(void);
extern int __fpclassifyf(float);
extern int __fpclassifyd(double);
extern int __fpclassifyl(long double);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isfinitef(float);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isfinited(double);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isfinitel(long double);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isinff(float);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isinfd(double);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isinfl(long double);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isnanf(float);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isnand(double);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isnanl(long double);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isnormalf(float);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isnormald(double);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isnormall(long double);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_signbitf(float);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_signbitd(double);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_signbitl(long double);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isfinitef(float __x) {
    return __x == __x && __builtin_fabsf(__x) != __builtin_inff();
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isfinited(double __x) {
    return __x == __x && __builtin_fabs(__x) != __builtin_inf();
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isfinitel(long double __x) {
    return __x == __x && __builtin_fabsl(__x) != __builtin_infl();
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isinff(float __x) {
    return __builtin_fabsf(__x) == __builtin_inff();
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isinfd(double __x) {
    return __builtin_fabs(__x) == __builtin_inf();
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isinfl(long double __x) {
    return __builtin_fabsl(__x) == __builtin_infl();
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isnanf(float __x) {
    return __x != __x;
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isnand(double __x) {
    return __x != __x;
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isnanl(long double __x) {
    return __x != __x;
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_signbitf(float __x) {
    union { float __f; unsigned int __u; } __u;
    __u.__f = __x;
    return (int)(__u.__u >> 31);
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_signbitd(double __x) {
    union { double __f; unsigned long long __u; } __u;
    __u.__f = __x;
    return (int)(__u.__u >> 63);
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_signbitl(long double __x) {
    union {
        long double __ld;
        struct{ unsigned long long __m; unsigned short __sexp; } __p;
    } __u;
    __u.__ld = __x;
    return (int)(__u.__p.__sexp >> 15);
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isnormalf(float __x) {
    return __inline_isfinitef(__x) && __builtin_fabsf(__x) >= 1.17549435082228750796873653722224568e-38F;
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isnormald(double __x) {
    return __inline_isfinited(__x) && __builtin_fabs(__x) >= ((double)2.22507385850720138309023271733240406e-308L);
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) int __inline_isnormall(long double __x) {
    return __inline_isfinitel(__x) && __builtin_fabsl(__x) >= 3.36210314311209350626267781732175260e-4932L;
}
extern float acosf(float);
extern double acos(double);
extern long double acosl(long double);
extern float asinf(float);
extern double asin(double);
extern long double asinl(long double);
extern float atanf(float);
extern double atan(double);
extern long double atanl(long double);
extern float atan2f(float, float);
extern double atan2(double, double);
extern long double atan2l(long double, long double);
extern float cosf(float);
extern double cos(double);
extern long double cosl(long double);
extern float sinf(float);
extern double sin(double);
extern long double sinl(long double);
extern float tanf(float);
extern double tan(double);
extern long double tanl(long double);
extern float acoshf(float);
extern double acosh(double);
extern long double acoshl(long double);
extern float asinhf(float);
extern double asinh(double);
extern long double asinhl(long double);
extern float atanhf(float);
extern double atanh(double);
extern long double atanhl(long double);
extern float coshf(float);
extern double cosh(double);
extern long double coshl(long double);
extern float sinhf(float);
extern double sinh(double);
extern long double sinhl(long double);
extern float tanhf(float);
extern double tanh(double);
extern long double tanhl(long double);
extern float expf(float);
extern double exp(double);
extern long double expl(long double);
extern float exp2f(float);
extern double exp2(double);
extern long double exp2l(long double);
extern float expm1f(float);
extern double expm1(double);
extern long double expm1l(long double);
extern float logf(float);
extern double log(double);
extern long double logl(long double);
extern float log10f(float);
extern double log10(double);
extern long double log10l(long double);
extern float log2f(float);
extern double log2(double);
extern long double log2l(long double);
extern float log1pf(float);
extern double log1p(double);
extern long double log1pl(long double);
extern float logbf(float);
extern double logb(double);
extern long double logbl(long double);
extern float modff(float, float *);
extern double modf(double, double *);
extern long double modfl(long double, long double *);
extern float ldexpf(float, int);
extern double ldexp(double, int);
extern long double ldexpl(long double, int);
extern float frexpf(float, int *);
extern double frexp(double, int *);
extern long double frexpl(long double, int *);
extern int ilogbf(float);
extern int ilogb(double);
extern int ilogbl(long double);
extern float scalbnf(float, int);
extern double scalbn(double, int);
extern long double scalbnl(long double, int);
extern float scalblnf(float, long int);
extern double scalbln(double, long int);
extern long double scalblnl(long double, long int);
extern float fabsf(float);
extern double fabs(double);
extern long double fabsl(long double);
extern float cbrtf(float);
extern double cbrt(double);
extern long double cbrtl(long double);
extern float hypotf(float, float);
extern double hypot(double, double);
extern long double hypotl(long double, long double);
extern float powf(float, float);
extern double pow(double, double);
extern long double powl(long double, long double);
extern float sqrtf(float);
extern double sqrt(double);
extern long double sqrtl(long double);
extern float erff(float);
extern double erf(double);
extern long double erfl(long double);
extern float erfcf(float);
extern double erfc(double);
extern long double erfcl(long double);
extern float lgammaf(float);
extern double lgamma(double);
extern long double lgammal(long double);
extern float tgammaf(float);
extern double tgamma(double);
extern long double tgammal(long double);
extern float ceilf(float);
extern double ceil(double);
extern long double ceill(long double);
extern float floorf(float);
extern double floor(double);
extern long double floorl(long double);
extern float nearbyintf(float);
extern double nearbyint(double);
extern long double nearbyintl(long double);
extern float rintf(float);
extern double rint(double);
extern long double rintl(long double);
extern long int lrintf(float);
extern long int lrint(double);
extern long int lrintl(long double);
extern float roundf(float);
extern double round(double);
extern long double roundl(long double);
extern long int lroundf(float);
extern long int lround(double);
extern long int lroundl(long double);
extern long long int llrintf(float);
extern long long int llrint(double);
extern long long int llrintl(long double);
extern long long int llroundf(float);
extern long long int llround(double);
extern long long int llroundl(long double);
extern float truncf(float);
extern double trunc(double);
extern long double truncl(long double);
extern float fmodf(float, float);
extern double fmod(double, double);
extern long double fmodl(long double, long double);
extern float remainderf(float, float);
extern double remainder(double, double);
extern long double remainderl(long double, long double);
extern float remquof(float, float, int *);
extern double remquo(double, double, int *);
extern long double remquol(long double, long double, int *);
extern float copysignf(float, float);
extern double copysign(double, double);
extern long double copysignl(long double, long double);
extern float nanf(const char *);
extern double nan(const char *);
extern long double nanl(const char *);
extern float nextafterf(float, float);
extern double nextafter(double, double);
extern long double nextafterl(long double, long double);
extern double nexttoward(double, long double);
extern float nexttowardf(float, long double);
extern long double nexttowardl(long double, long double);
extern float fdimf(float, float);
extern double fdim(double, double);
extern long double fdiml(long double, long double);
extern float fmaxf(float, float);
extern double fmax(double, double);
extern long double fmaxl(long double, long double);
extern float fminf(float, float);
extern double fmin(double, double);
extern long double fminl(long double, long double);
extern float fmaf(float, float, float);
extern double fma(double, double, double);
extern long double fmal(long double, long double, long double);
extern float __inff(void)
 ;
extern double __inf(void)
 ;
extern long double __infl(void)
 ;
extern float __nan(void)
 ;
extern float __exp10f(float) ;
extern double __exp10(double) ;
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) void __sincosf(float __x, float *__sinp, float *__cosp);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) void __sincos(double __x, double *__sinp, double *__cosp);
extern float __cospif(float) ;
extern double __cospi(double) ;
extern float __sinpif(float) ;
extern double __sinpi(double) ;
extern float __tanpif(float) ;
extern double __tanpi(double) ;
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) void __sincospif(float __x, float *__sinp, float *__cosp);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) void __sincospi(double __x, double *__sinp, double *__cosp);
struct __float2 { float __sinval; float __cosval; };
struct __double2 { double __sinval; double __cosval; };
extern struct __float2 __sincosf_stret(float);
extern struct __double2 __sincos_stret(double);
extern struct __float2 __sincospif_stret(float);
extern struct __double2 __sincospi_stret(double);
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) void __sincosf(float __x, float *__sinp, float *__cosp) {
    const struct __float2 __stret = __sincosf_stret(__x);
    *__sinp = __stret.__sinval; *__cosp = __stret.__cosval;
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) void __sincos(double __x, double *__sinp, double *__cosp) {
    const struct __double2 __stret = __sincos_stret(__x);
    *__sinp = __stret.__sinval; *__cosp = __stret.__cosval;
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) void __sincospif(float __x, float *__sinp, float *__cosp) {
    const struct __float2 __stret = __sincospif_stret(__x);
    *__sinp = __stret.__sinval; *__cosp = __stret.__cosval;
}
extern __inline __attribute__((__gnu_inline__)) __attribute__ ((__always_inline__)) void __sincospi(double __x, double *__sinp, double *__cosp) {
    const struct __double2 __stret = __sincospi_stret(__x);
    *__sinp = __stret.__sinval; *__cosp = __stret.__cosval;
}
extern double j0(double) ;
extern double j1(double) ;
extern double jn(int, double) ;
extern double y0(double) ;
extern double y1(double) ;
extern double yn(int, double) ;
extern double scalb(double, double);
extern int signgam;
extern long int rinttol(double)
 ;
extern long int roundtol(double)
 ;
extern double drem(double, double)
 ;
extern int finite(double)
 ;
extern double gamma(double)
 ;
extern double significand(double)
 ;
struct exception {
    int type;
    char *name;
    double arg1;
    double arg2;
    double retval;
};

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
typedef int boolean;
typedef struct { double real; double imag; } dcomplex;
extern double randlc(double *, double);
extern void vranlc(int, double *, double, double *);
extern void timer_clear(int);
extern void timer_start(int);
extern void timer_stop(int);
extern double timer_read(int);
extern void c_print_results(char *name, char class, int n1, int n2,
       int n3, int niter, int nthreads, double t,
       double mops, char *optype, int passed_verification,
       char *npbversion, char *compiletime, char *cc,
       char *clink, char *c_lib, char *c_inc,
       char *cflags, char *clinkflags, char *rand);
typedef enum
  {
    memory_order_relaxed = 0,
    memory_order_consume = 1,
    memory_order_acquire = 2,
    memory_order_release = 3,
    memory_order_acq_rel = 4,
    memory_order_seq_cst = 5
  } memory_order;
typedef _Atomic _Bool atomic_bool;
typedef _Atomic char atomic_char;
typedef _Atomic signed char atomic_schar;
typedef _Atomic unsigned char atomic_uchar;
typedef _Atomic short atomic_short;
typedef _Atomic unsigned short atomic_ushort;
typedef _Atomic int atomic_int;
typedef _Atomic unsigned int atomic_uint;
typedef _Atomic long atomic_long;
typedef _Atomic unsigned long atomic_ulong;
typedef _Atomic long long atomic_llong;
typedef _Atomic unsigned long long atomic_ullong;
typedef _Atomic short unsigned int atomic_char16_t;
typedef _Atomic unsigned int atomic_char32_t;
typedef _Atomic int atomic_wchar_t;
typedef _Atomic signed char atomic_int_least8_t;
typedef _Atomic unsigned char atomic_uint_least8_t;
typedef _Atomic short int atomic_int_least16_t;
typedef _Atomic short unsigned int atomic_uint_least16_t;
typedef _Atomic int atomic_int_least32_t;
typedef _Atomic unsigned int atomic_uint_least32_t;
typedef _Atomic long long int atomic_int_least64_t;
typedef _Atomic long long unsigned int atomic_uint_least64_t;
typedef _Atomic signed char atomic_int_fast8_t;
typedef _Atomic unsigned char atomic_uint_fast8_t;
typedef _Atomic short int atomic_int_fast16_t;
typedef _Atomic short unsigned int atomic_uint_fast16_t;
typedef _Atomic int atomic_int_fast32_t;
typedef _Atomic unsigned int atomic_uint_fast32_t;
typedef _Atomic long long int atomic_int_fast64_t;
typedef _Atomic long long unsigned int atomic_uint_fast64_t;
typedef _Atomic long int atomic_intptr_t;
typedef _Atomic long unsigned int atomic_uintptr_t;
typedef _Atomic long unsigned int atomic_size_t;
typedef _Atomic long int atomic_ptrdiff_t;
typedef _Atomic long int atomic_intmax_t;
typedef _Atomic long unsigned int atomic_uintmax_t;
extern void atomic_thread_fence (memory_order);
extern void atomic_signal_fence (memory_order);
typedef _Atomic struct
{
  _Bool __val;
} atomic_flag;
extern _Bool atomic_flag_test_and_set (volatile atomic_flag *);
extern _Bool atomic_flag_test_and_set_explicit (volatile atomic_flag *,
      memory_order);
extern void atomic_flag_clear (volatile atomic_flag *);
extern void atomic_flag_clear_explicit (volatile atomic_flag *, memory_order);
typedef enum{
    NORMAL,
    REDUCTION,
    WAIT
}TYPE_CLOSURE;
typedef struct WaitClsr{
    int n_iters;
    int iteration;
    int start;
    int *waitIterations;
    void (*redFunction)(void *,void *);
    void (*waitFunc)(struct WaitClsr *);
    void *redVar;
    struct Clsr *newK;
}WaitClosure;
typedef struct{
    int n_reductions;
    int iteration;
    void (*combine)(void *,void *);
}ReductionClosure;
typedef struct Clsr{
    void (*fptr)(struct Clsr *);
    TYPE_CLOSURE typeClosure;
    void *env;
    union{
        ReductionClosure *rednClsr;
        WaitClosure *waitClsr;
    }cls;
    struct Clsr *continuation;
}Closure;
Closure *createClosure(TYPE_CLOSURE type,void (*fptr)(Closure *),void *env,Closure *continuationClosure);
typedef struct ClsrNode{
    Closure *closure;
    struct ClsrNode *next;
}ClosureNode;
typedef struct{
    ClosureNode *front,*rear;
}WorkListQueue;
ClosureNode *createClosureNode(Closure *);
WorkListQueue *createWorklistQueue();
void enqueueClosure(WorkListQueue *,Closure *);
Closure *dequeueClosure(WorkListQueue *);
void takeWork(WorkListQueue *,WorkListQueue *,int);
void executeReadyWorkList(WorkListQueue *);
void execute(WorkListQueue *,atomic_flag *,int);
void scheduleClosures(WorkListQueue *,WorkListQueue *, atomic_flag *,int);
int isIdleThreads(int *);
void scheduler(WorkListQueue *,WorkListQueue *,atomic_flag *,int, int *);
int isEmpty(WorkListQueue *);
int fftblock;
int fftblockpad;
static int dims[3][3];
static int xstart[3];
static int ystart[3];
static int zstart[3];
static int xend[3];
static int yend[3];
static int zend[3];
static double ex[(6*(64*64/4+64*64/4+64*64/4))+1];
static dcomplex u[64];
static dcomplex sums[6 +1];
static int niter;
static void evolve(dcomplex u0[64][64][64], dcomplex u1[64][64][64],
     int t, int indexmap[64][64][64], int d[3]);
static void compute_initial_conditions(dcomplex u0[64][64][64], int d[3]);
static void ipow46(double a, int exponent, double *result);
static void setup(void);
static void compute_indexmap(int indexmap[64][64][64], int d[3]);
static void print_timers(void);
static void fft(int dir, dcomplex x1[64][64][64], dcomplex x2[64][64][64]);
static void cffts1(int is, int d[3], dcomplex x[64][64][64],
     dcomplex xout[64][64][64],
     dcomplex y0[64][18],
     dcomplex y1[64][18]);
static void cffts2(int is, int d[3], dcomplex x[64][64][64],
     dcomplex xout[64][64][64],
     dcomplex y0[64][18],
     dcomplex y1[64][18]);
static void cffts3(int is, int d[3], dcomplex x[64][64][64],
     dcomplex xout[64][64][64],
     dcomplex y0[64][18],
     dcomplex y1[64][18]);
static void fft_init (int n);
static void cfftz (int is, int m, int n, dcomplex x[64][18],
     dcomplex y[64][18]);
static void fftz2 (int is, int l, int m, int n, int ny, int ny1,
     dcomplex u[64], dcomplex x[64][18],
     dcomplex y[64][18]);
static int ilog2(int n);
static void checksum(int i, dcomplex u1[64][64][64], int d[3]);
static void verify (int d1, int d2, int d3, int nt,
      boolean *verified, char *class);
int main(int argc, char **argv) {
    int i, ierr;
    static dcomplex u0[64][64][64];
    static dcomplex pad1[3];
    static dcomplex u1[64][64][64];
    static dcomplex pad2[3];
    static dcomplex u2[64][64][64];
    static dcomplex pad3[3];
    static int indexmap[64][64][64];
    int iter;
    int nthreads = 1;
    double total_time, mflops;
    boolean verified;
    char class;
    for (i = 0; i < 7; i++) {
 timer_clear(i);
    }
    setup();
    compute_indexmap(indexmap, dims[2]);
    compute_initial_conditions(u1, dims[0]);
    fft_init (dims[0][0]);
    fft(1, u1, u0);
    for (i = 0; i < 7; i++) {
 timer_clear(i);
    }
    timer_start(0);
    if (0 == 1) timer_start(1);
    compute_indexmap(indexmap, dims[2]);
    compute_initial_conditions(u1, dims[0]);
    fft_init (dims[0][0]);
    if (0 == 1) {
      timer_stop(1);
    }
    if (0 == 1) {
      timer_start(2);
    }
    fft(1, u1, u0);
    if (0 == 1) {
      timer_stop(2);
    }
    for (iter = 1; iter <= niter; iter++) {
     if (0 == 1) {
       timer_start(3);
     }
     evolve(u0, u1, iter, indexmap, dims[0]);
            if (0 == 1) {
       timer_stop(3);
     }
            if (0 == 1) {
       timer_start(2);
     }
            fft(-1, u1, u2);
            if (0 == 1) {
       timer_stop(2);
     }
            if (0 == 1) {
       timer_start(4);
     }
            checksum(iter, u2, dims[0]);
            if (0 == 1) {
       timer_stop(4);
     }
    }
    verify(64, 64, 64, niter, &verified, &class);
        
#pragma omp parallel
  {
        
#pragma omp master
    nthreads = omp_get_num_threads();
  }
    timer_stop(0);
    total_time = timer_read(0);
    if( total_time != 0.0) {
 mflops = 1.0e-6*(double)(262144) *
     (14.8157+7.19641*log((double)(262144))
      + (5.23518+7.21113*log((double)(262144)))*niter)
     /total_time;
    } else {
 mflops = 0.0;
    }
    c_print_results("FT", class, 64, 64, 64, niter, nthreads,
      total_time, mflops, "          floating point", verified,
      "3.0 structured", "03 Jan 2022",
      "gcc-11", "gcc-11", "(none)", "-I../common", "-O3 ", "(none)", "randdp");
    if (0 == 1) print_timers();
}
static void evolve(dcomplex u0[64][64][64], dcomplex u1[64][64][64],
     int t, int indexmap[64][64][64], int d[3]) {
    int i, j, k;
        
#pragma omp parallel for default(shared) private(i,j,k)
    for (k = 0; k < d[2]; k++) {
 for (j = 0; j < d[1]; j++) {
            for (i = 0; i < d[0]; i++) {
       (u1[k][j][i].real = u0[k][j][i].real * ex[t*indexmap[k][j][i]], u1[k][j][i].imag = u0[k][j][i].imag * ex[t*indexmap[k][j][i]]);
     }
 }
    }
}
static void compute_initial_conditions(dcomplex u0[64][64][64], int d[3]) {
    int k;
    double x0, start, an, dummy;
    static double tmp[64*2*64 +1];
    int i,j,t;
    start = 314159265.0;
    ipow46(1220703125.0, (zstart[0]-1)*2*64*64 + (ystart[0]-1)*2*64, &an);
    dummy = randlc(&start, an);
    ipow46(1220703125.0, 2*64*64, &an);
    for (k = 0; k < dims[0][2]; k++) {
 x0 = start;
        vranlc(2*64*dims[0][1], &x0, 1220703125.0, tmp);
 t = 1;
 for (j = 0; j < dims[0][1]; j++)
   for (i = 0; i < 64; i++) {
     u0[k][j][i].real = tmp[t++];
     u0[k][j][i].imag = tmp[t++];
   }
        if (k != dims[0][2]) dummy = randlc(&start, an);
    }
}
static void ipow46(double a, int exponent, double *result) {
    double dummy, q, r;
    int n, n2;
    *result = 1;
    if (exponent == 0) return;
    q = a;
    r = 1;
    n = exponent;
    while (n > 1) {
 n2 = n/2;
 if (n2 * 2 == n) {
            dummy = randlc(&q, q);
            n = n2;
 } else {
            dummy = randlc(&r, q);
            n = n-1;
 }
    }
    dummy = randlc(&r, q);
    *result = r;
}
static void setup(void) {
    int ierr, i, j, fstatus;
    printf("\n\n NAS Parallel Benchmarks 3.0 structured OpenMP C version"
    " - FT Benchmark\n\n");
    niter = 6;
    printf(" Size                : %3dx%3dx%3d\n", 64, 64, 64);
    printf(" Iterations          :     %7d\n", niter);
    for (i = 0;i < 3 ; i++) {
 dims[i][0] = 64;
 dims[i][1] = 64;
 dims[i][2] = 64;
    }
    for (i = 0; i < 3; i++) {
 xstart[i] = 1;
 xend[i] = 64;
 ystart[i] = 1;
        yend[i] = 64;
        zstart[i] = 1;
        zend[i] = 64;
    }
    fftblock = 16;
    fftblockpad = 18;
    if (fftblock != 16) fftblockpad = fftblock+3;
}
static void compute_indexmap(int indexmap[64][64][64], int d[3]) {
    int i, j, k, ii, ii2, jj, ij2, kk;
    double ap;
        
#pragma omp parallel for default(shared) private(i,j,k,ii,ii2,jj,ij2,kk)
    for (i = 0; i < dims[2][0]; i++) {
 ii = (i+1+xstart[2]-2+64/2)%64 - 64/2;
 ii2 = ii*ii;
 for (j = 0; j < dims[2][1]; j++) {
            jj = (j+1+ystart[2]-2+64/2)%64 - 64/2;
            ij2 = jj*jj+ii2;
            for (k = 0; k < dims[2][2]; k++) {
  kk = (k+1+zstart[2]-2+64/2)%64 - 64/2;
  indexmap[k][j][i] = kk*kk+ij2;
     }
 }
    }
    ap = - 4.0 * 1.0e-6 * 3.141592653589793238 * 3.141592653589793238;
    ex[0] = 1.0;
    ex[1] = exp(ap);
    for (i = 2; i <= (6*(64*64/4+64*64/4+64*64/4)); i++) {
 ex[i] = ex[i-1]*ex[1];
    }
}
static void print_timers(void) {
    int i;
    char *tstrings[] = { "          total ",
    "          setup ",
    "            fft ",
    "         evolve ",
    "       checksum ",
    "         fftlow ",
    "        fftcopy " };
    for (i = 0; i < 7; i++) {
 if (timer_read(i) != 0.0) {
            printf("timer %2d(%16s( :%10.6f\n", i, tstrings[i], timer_read(i));
 }
    }
}
static void fft(int dir, dcomplex x1[64][64][64], dcomplex x2[64][64][64]) {
    dcomplex y0[64][18];
    dcomplex y1[64][18];
    if (dir == 1) {
        cffts1(1, dims[0], x1, x1, y0, y1);
        cffts2(1, dims[1], x1, x1, y0, y1);
        cffts3(1, dims[2], x1, x2, y0, y1);
    } else {
 cffts3(-1, dims[2], x1, x1, y0, y1);
    cffts2(-1, dims[1], x1, x1, y0, y1);
    cffts1(-1, dims[0], x1, x2, y0, y1);
    }
}
static void cffts1(int is, int d[3], dcomplex x[64][64][64],
     dcomplex xout[64][64][64],
     dcomplex y0[64][18],
     dcomplex y1[64][18]) {
    int logd[3];
    int i, j, k, jj;
    for (i = 0; i < 3; i++) {
 logd[i] = ilog2(d[i]);
    }
        
#pragma omp parallel default(shared) private(i,j,k,jj) shared(is)
{
dcomplex y0[64][18];
dcomplex y1[64][18];
        
#pragma omp for
    for (k = 0; k < d[2]; k++) {
 for (jj = 0; jj <= d[1] - fftblock; jj+=fftblock) {
            for (j = 0; j < fftblock; j++) {
  for (i = 0; i < d[0]; i++) {
      y0[i][j].real = x[k][j+jj][i].real;
      y0[i][j].imag = x[k][j+jj][i].imag;
  }
     }
            cfftz (is, logd[0],
     d[0], y0, y1);
            for (j = 0; j < fftblock; j++) {
  for (i = 0; i < d[0]; i++) {
    xout[k][j+jj][i].real = y0[i][j].real;
    xout[k][j+jj][i].imag = y0[i][j].imag;
  }
     }
 }
    }
}
}
static void cffts2(int is, int d[3], dcomplex x[64][64][64],
     dcomplex xout[64][64][64],
     dcomplex y0[64][18],
     dcomplex y1[64][18]) {
    int logd[3];
    int i, j, k, ii;
    for (i = 0; i < 3; i++) {
 logd[i] = ilog2(d[i]);
    }
        
#pragma omp parallel default(shared) private(i,j,k,ii) shared(is)
{
dcomplex y0[64][18];
dcomplex y1[64][18];
        
#pragma omp for
    for (k = 0; k < d[2]; k++) {
        for (ii = 0; ii <= d[0] - fftblock; ii+=fftblock) {
     for (j = 0; j < d[1]; j++) {
  for (i = 0; i < fftblock; i++) {
      y0[j][i].real = x[k][j][i+ii].real;
      y0[j][i].imag = x[k][j][i+ii].imag;
  }
     }
     cfftz (is, logd[1],
     d[1], y0, y1);
           for (j = 0; j < d[1]; j++) {
        for (i = 0; i < fftblock; i++) {
     xout[k][j][i+ii].real = y0[j][i].real;
     xout[k][j][i+ii].imag = y0[j][i].imag;
        }
    }
 }
    }
}
}
static void cffts3(int is, int d[3], dcomplex x[64][64][64],
     dcomplex xout[64][64][64],
     dcomplex y0[64][18],
     dcomplex y1[64][18]) {
    int logd[3];
    int i, j, k, ii;
    for (i = 0;i < 3; i++) {
 logd[i] = ilog2(d[i]);
    }
        
#pragma omp parallel default(shared) private(i,j,k,ii) shared(is)
{
dcomplex y0[64][18];
dcomplex y1[64][18];
        
#pragma omp for
    for (j = 0; j < d[1]; j++) {
        for (ii = 0; ii <= d[0] - fftblock; ii+=fftblock) {
     for (k = 0; k < d[2]; k++) {
  for (i = 0; i < fftblock; i++) {
      y0[k][i].real = x[k][j][i+ii].real;
      y0[k][i].imag = x[k][j][i+ii].imag;
  }
     }
           cfftz (is, logd[2],
    d[2], y0, y1);
           for (k = 0; k < d[2]; k++) {
        for (i = 0; i < fftblock; i++) {
     xout[k][j][i+ii].real = y0[k][i].real;
     xout[k][j][i+ii].imag = y0[k][i].imag;
        }
    }
 }
    }
}
}
static void fft_init (int n) {
    int m,nu,ku,i,j,ln;
    double t, ti;
    nu = n;
    m = ilog2(n);
    u[0].real = (double)m;
    u[0].imag = 0.0;
    ku = 1;
    ln = 1;
    for (j = 1; j <= m; j++) {
 t = 3.141592653589793238 / ln;
 for (i = 0; i <= ln - 1; i++) {
            ti = i * t;
            u[i+ku].real = cos(ti);
     u[i+ku].imag = sin(ti);
 }
 ku = ku + ln;
 ln = 2 * ln;
    }
}
static void cfftz (int is, int m, int n, dcomplex x[64][18],
     dcomplex y[64][18]) {
    int i,j,l,mx;
    mx = (int)(u[0].real);
    if ((is != 1 && is != -1) || m < 1 || m > mx) {
 printf("CFFTZ: Either U has not been initialized, or else\n"
        "one of the input parameters is invalid%5d%5d%5d\n",
        is, m, mx);
 exit(1);
    }
    for (l = 1; l <= m; l+=2) {
        fftz2 (is, l, m, n, fftblock, fftblockpad, u, x, y);
        if (l == m) break;
 fftz2 (is, l + 1, m, n, fftblock, fftblockpad, u, y, x);
    }
    if (m % 2 == 1) {
 for (j = 0; j < n; j++) {
     for (i = 0; i < fftblock; i++) {
  x[j][i].real = y[j][i].real;
  x[j][i].imag = y[j][i].imag;
     }
 }
    }
}
static void fftz2 (int is, int l, int m, int n, int ny, int ny1,
     dcomplex u[64], dcomplex x[64][18],
     dcomplex y[64][18]) {
    int k,n1,li,lj,lk,ku,i,j,i11,i12,i21,i22;
    dcomplex u1,x11,x21;
    n1 = n / 2;
    if (l-1 == 0) {
 lk = 1;
    } else {
 lk = 2 << ((l - 1)-1);
    }
    if (m-l == 0) {
 li = 1;
    } else {
 li = 2 << ((m - l)-1);
    }
    lj = 2 * lk;
    ku = li;
    for (i = 0; i < li; i++) {
        i11 = i * lk;
        i12 = i11 + n1;
        i21 = i * lj;
        i22 = i21 + lk;
        if (is >= 1) {
          u1.real = u[ku+i].real;
          u1.imag = u[ku+i].imag;
        } else {
          u1.real = u[ku+i].real;
          u1.imag = -u[ku+i].imag;
        }
        for (k = 0; k < lk; k++) {
     for (j = 0; j < ny; j++) {
  double x11real, x11imag;
  double x21real, x21imag;
  x11real = x[i11+k][j].real;
  x11imag = x[i11+k][j].imag;
  x21real = x[i12+k][j].real;
  x21imag = x[i12+k][j].imag;
  y[i21+k][j].real = x11real + x21real;
  y[i21+k][j].imag = x11imag + x21imag;
  y[i22+k][j].real = u1.real * (x11real - x21real)
      - u1.imag * (x11imag - x21imag);
  y[i22+k][j].imag = u1.real * (x11imag - x21imag)
      + u1.imag * (x11real - x21real);
     }
 }
    }
}
static int ilog2(int n) {
    int nn, lg;
    if (n == 1) {
 return 0;
    }
    lg = 1;
    nn = 2;
    while (nn < n) {
 nn = nn << 1;
 lg++;
    }
    return lg;
}
static void checksum(int i, dcomplex u1[64][64][64], int d[3]) {
        
#pragma omp parallel default(shared)
{
    int j, q,r,s, ierr;
    dcomplex chk,allchk;
    chk.real = 0.0;
    chk.imag = 0.0;
        
#pragma omp for nowait
    for (j = 1; j <= 1024; j++) {
 q = j%64 +1;
 if (q >= xstart[0] && q <= xend[0]) {
            r = (3*j)%64 +1;
            if (r >= ystart[0] && r <= yend[0]) {
  s = (5*j)%64 +1;
  if (s >= zstart[0] && s <= zend[0]) {
    (chk.real = chk.real + u1[s-zstart[0]][r-ystart[0]][q-xstart[0]].real, chk.imag = chk.imag + u1[s-zstart[0]][r-ystart[0]][q-xstart[0]].imag);
  }
     }
 }
    }
        
#pragma omp critical
    {
 sums[i].real += chk.real;
 sums[i].imag += chk.imag;
    }
        
#pragma omp barrier
        
#pragma omp single
  {
    sums[i].real = sums[i].real/(double)(262144);
    sums[i].imag = sums[i].imag/(double)(262144);
    printf("T = %5d     Checksum = %22.12e %22.12e\n",
    i, sums[i].real, sums[i].imag);
  }
}
}
static void verify (int d1, int d2, int d3, int nt,
      boolean *verified, char *class) {
    int ierr, size, i;
    double err, epsilon;
    double vdata_real_s[6+1] = { 0.0,
     5.546087004964e+02,
     5.546385409189e+02,
     5.546148406171e+02,
     5.545423607415e+02,
     5.544255039624e+02,
     5.542683411902e+02 };
    double vdata_imag_s[6+1] = { 0.0,
     4.845363331978e+02,
     4.865304269511e+02,
     4.883910722336e+02,
     4.901273169046e+02,
     4.917475857993e+02,
     4.932597244941e+02 };
    double vdata_real_w[6+1] = { 0.0,
     5.673612178944e+02,
     5.631436885271e+02,
     5.594024089970e+02,
     5.560698047020e+02,
     5.530898991250e+02,
     5.504159734538e+02 };
    double vdata_imag_w[6+1] = { 0.0,
     5.293246849175e+02,
     5.282149986629e+02,
     5.270996558037e+02,
     5.260027904925e+02,
     5.249400845633e+02,
     5.239212247086e+02 };
    double vdata_real_a[6+1] = { 0.0,
     5.046735008193e+02,
     5.059412319734e+02,
     5.069376896287e+02,
     5.077892868474e+02,
     5.085233095391e+02,
     5.091487099959e+02 };
    double vdata_imag_a[6+1] = { 0.0,
     5.114047905510e+02,
     5.098809666433e+02,
     5.098144042213e+02,
     5.101336130759e+02,
     5.104914655194e+02,
     5.107917842803e+02 };
    double vdata_real_b[20+1] = { 0.0,
      5.177643571579e+02,
      5.154521291263e+02,
      5.146409228649e+02,
      5.142378756213e+02,
      5.139626667737e+02,
      5.137423460082e+02,
      5.135547056878e+02,
      5.133910925466e+02,
      5.132470705390e+02,
      5.131197729984e+02,
      5.130070319283e+02,
      5.129070537032e+02,
      5.128182883502e+02,
      5.127393733383e+02,
      5.126691062020e+02,
      5.126064276004e+02,
      5.125504076570e+02,
      5.125002331720e+02,
      5.124551951846e+02,
      5.124146770029e+02 };
    double vdata_imag_b[20+1] = { 0.0,
      5.077803458597e+02,
      5.088249431599e+02,
      5.096208912659e+02,
      5.101023387619e+02,
      5.103976610617e+02,
      5.105948019802e+02,
      5.107404165783e+02,
      5.108576573661e+02,
      5.109577278523e+02,
      5.110460304483e+02,
      5.111252433800e+02,
      5.111968077718e+02,
      5.112616233064e+02,
      5.113203605551e+02,
      5.113735928093e+02,
      5.114218460548e+02,
      5.114656139760e+02,
      5.115053595966e+02,
      5.115415130407e+02,
      5.115744692211e+02 };
    double vdata_real_c[20+1] = { 0.0,
      5.195078707457e+02,
      5.155422171134e+02,
      5.144678022222e+02,
      5.140150594328e+02,
      5.137550426810e+02,
      5.135811056728e+02,
      5.134569343165e+02,
      5.133651975661e+02,
      5.132955192805e+02,
      5.132410471738e+02,
      5.131971141679e+02,
      5.131605205716e+02,
      5.131290734194e+02,
      5.131012720314e+02,
      5.130760908195e+02,
      5.130528295923e+02,
      5.130310107773e+02,
      5.130103090133e+02,
      5.129905029333e+02,
      5.129714421109e+02 };
    double vdata_imag_c[20+1] = { 0.0,
      5.149019699238e+02,
      5.127578201997e+02,
      5.122251847514e+02,
      5.121090289018e+02,
      5.121143685824e+02,
      5.121496764568e+02,
      5.121870921893e+02,
      5.122193250322e+02,
      5.122454735794e+02,
      5.122663649603e+02,
      5.122830879827e+02,
      5.122965869718e+02,
      5.123075927445e+02,
      5.123166486553e+02,
      5.123241541685e+02,
      5.123304037599e+02,
      5.123356167976e+02,
      5.123399592211e+02,
      5.123435588985e+02,
      5.123465164008e+02 };
    epsilon = 1.0e-12;
    *verified = 1;
    *class = 'U';
    if (d1 == 64 &&
 d2 == 64 &&
 d3 == 64 &&
 nt == 6) {
 *class = 'S';
 for (i = 1; i <= nt; i++) {
            err = (sums[i].real - vdata_real_s[i]) / vdata_real_s[i];
            if (fabs(err) > epsilon) {
       *verified = 0;
       break;
     }
            err = (sums[i].imag - vdata_imag_s[i]) / vdata_imag_s[i];
            if (fabs(err) > epsilon) {
       *verified = 0;
       break;
     }
 }
    } else if (d1 == 128 &&
        d2 == 128 &&
        d3 == 32 &&
        nt == 6) {
 *class = 'W';
 for (i = 1; i <= nt; i++) {
            err = (sums[i].real - vdata_real_w[i]) / vdata_real_w[i];
            if (fabs(err) > epsilon) {
       *verified = 0;
       break;
     }
            err = (sums[i].imag - vdata_imag_w[i]) / vdata_imag_w[i];
            if (fabs(err) > epsilon) {
       *verified = 0;
       break;
     }
 }
    } else if (d1 == 256 &&
        d2 == 256 &&
        d3 == 128 &&
        nt == 6) {
 *class = 'A';
 for (i = 1; i <= nt; i++) {
            err = (sums[i].real - vdata_real_a[i]) / vdata_real_a[i];
            if (fabs(err) > epsilon) {
       *verified = 0;
       break;
     }
            err = (sums[i].imag - vdata_imag_a[i]) / vdata_imag_a[i];
            if (fabs(err) > epsilon) {
       *verified = 0;
       break;
     }
 }
    } else if (d1 == 512 &&
        d2 == 256 &&
        d3 == 256 &&
        nt == 20) {
 *class = 'B';
 for (i = 1; i <= nt; i++) {
            err = (sums[i].real - vdata_real_b[i]) / vdata_real_b[i];
            if (fabs(err) > epsilon) {
       *verified = 0;
       break;
     }
            err = (sums[i].imag - vdata_imag_b[i]) / vdata_imag_b[i];
            if (fabs(err) > epsilon) {
       *verified = 0;
       break;
     }
 }
    } else if (d1 == 512 &&
        d2 == 512 &&
        d3 == 512 &&
        nt == 20) {
 *class = 'C';
 for (i = 1; i <= nt; i++) {
            err = (sums[i].real - vdata_real_c[i]) / vdata_real_c[i];
            if (fabs(err) > epsilon) {
       *verified = 0;
       break;
     }
            err = (sums[i].imag - vdata_imag_c[i]) / vdata_imag_c[i];
            if (fabs(err) > epsilon) {
       *verified = 0;
       break;
     }
 }
    }
    if (*class != 'U') {
 printf("Result verification successful\n");
    } else {
 printf("Result verification failed\n");
    }
    printf("class = %1c\n", *class);
}
