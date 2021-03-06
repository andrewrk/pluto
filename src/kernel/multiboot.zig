// Autogenerated by zig translate-c
pub const multiboot_uint8_t = u8;
pub const multiboot_uint16_t = c_ushort;
pub const multiboot_uint32_t = c_uint;
pub const multiboot_uint64_t = c_ulonglong;
pub const struct_multiboot_header = extern struct {
    magic: multiboot_uint32_t,
    flags: multiboot_uint32_t,
    checksum: multiboot_uint32_t,
    header_addr: multiboot_uint32_t,
    load_addr: multiboot_uint32_t,
    load_end_addr: multiboot_uint32_t,
    bss_end_addr: multiboot_uint32_t,
    entry_addr: multiboot_uint32_t,
    mode_type: multiboot_uint32_t,
    width: multiboot_uint32_t,
    height: multiboot_uint32_t,
    depth: multiboot_uint32_t,
};
pub const struct_multiboot_aout_symbol_table = extern struct {
    tabsize: multiboot_uint32_t,
    strsize: multiboot_uint32_t,
    addr: multiboot_uint32_t,
    reserved: multiboot_uint32_t,
};
pub const multiboot_aout_symbol_table_t = struct_multiboot_aout_symbol_table;
pub const struct_multiboot_elf_section_header_table = extern struct {
    num: multiboot_uint32_t,
    size: multiboot_uint32_t,
    addr: multiboot_uint32_t,
    shndx: multiboot_uint32_t,
};
pub const multiboot_elf_section_header_table_t = struct_multiboot_elf_section_header_table;
pub const struct_multiboot_info = extern struct {
    flags: multiboot_uint32_t,
    mem_lower: multiboot_uint32_t,
    mem_upper: multiboot_uint32_t,
    boot_device: multiboot_uint32_t,
    cmdline: multiboot_uint32_t,
    mods_count: multiboot_uint32_t,
    mods_addr: multiboot_uint32_t,
    u: extern union {
        aout_sym: multiboot_aout_symbol_table_t,
        elf_sec: multiboot_elf_section_header_table_t,
    },
    mmap_length: multiboot_uint32_t,
    mmap_addr: multiboot_uint32_t,
    drives_length: multiboot_uint32_t,
    drives_addr: multiboot_uint32_t,
    config_table: multiboot_uint32_t,
    boot_loader_name: multiboot_uint32_t,
    apm_table: multiboot_uint32_t,
    vbe_control_info: multiboot_uint32_t,
    vbe_mode_info: multiboot_uint32_t,
    vbe_mode: multiboot_uint16_t,
    vbe_interface_seg: multiboot_uint16_t,
    vbe_interface_off: multiboot_uint16_t,
    vbe_interface_len: multiboot_uint16_t,
    framebuffer_addr: multiboot_uint64_t,
    framebuffer_pitch: multiboot_uint32_t,
    framebuffer_width: multiboot_uint32_t,
    framebuffer_height: multiboot_uint32_t,
    framebuffer_bpp: multiboot_uint8_t,
    framebuffer_type: multiboot_uint8_t,
    framebuffer: extern union {
        framebuffer_palette: extern struct {
            framebuffer_palette_addr: multiboot_uint32_t,
            framebuffer_palette_num_colors: multiboot_uint16_t,
        },
        framebuffer_colours: extern struct {
            framebuffer_red_field_position: multiboot_uint8_t,
            framebuffer_red_mask_size: multiboot_uint8_t,
            framebuffer_green_field_position: multiboot_uint8_t,
            framebuffer_green_mask_size: multiboot_uint8_t,
            framebuffer_blue_field_position: multiboot_uint8_t,
            framebuffer_blue_mask_size: multiboot_uint8_t,
        },
    },
};
pub const multiboot_info_t = struct_multiboot_info;
pub const struct_multiboot_color = extern struct {
    red: multiboot_uint8_t,
    green: multiboot_uint8_t,
    blue: multiboot_uint8_t,
};
pub const struct_multiboot_mmap_entry = extern struct {
    size: multiboot_uint32_t,
    addr: multiboot_uint64_t,
    len: multiboot_uint64_t,
    type: multiboot_uint32_t,
};
pub const multiboot_memory_map_t = struct_multiboot_mmap_entry;
pub const struct_multiboot_mod_list = extern struct {
    mod_start: multiboot_uint32_t,
    mod_end: multiboot_uint32_t,
    cmdline: multiboot_uint32_t,
    pad: multiboot_uint32_t,
};
pub const multiboot_module_t = struct_multiboot_mod_list;
pub const struct_multiboot_apm_info = extern struct {
    version: multiboot_uint16_t,
    cseg: multiboot_uint16_t,
    offset: multiboot_uint32_t,
    cseg_16: multiboot_uint16_t,
    dseg: multiboot_uint16_t,
    flags: multiboot_uint16_t,
    cseg_len: multiboot_uint16_t,
    cseg_16_len: multiboot_uint16_t,
    dseg_len: multiboot_uint16_t,
};
pub const __GCC_ATOMIC_TEST_AND_SET_TRUEVAL = 1;
pub const __FLT16_MAX_EXP__ = 15;
pub const __BIGGEST_ALIGNMENT__ = 16;
pub const __SIZEOF_FLOAT__ = 4;
pub const __INT64_FMTd__ = c"ld";
pub const __STDC_VERSION__ = c_long(201112);
pub const __INT_LEAST32_FMTi__ = c"i";
pub const __INT_LEAST8_FMTi__ = c"hhi";
pub const __LDBL_EPSILON__ = -nan;
pub const __LZCNT__ = 1;
pub const __INT_LEAST32_FMTd__ = c"d";
pub const __STDC_UTF_32__ = 1;
pub const __INVPCID__ = 1;
pub const __SIG_ATOMIC_WIDTH__ = 32;
pub const MULTIBOOT_MEMORY_BADRAM = 5;
pub const __UINT_FAST64_FMTX__ = c"lX";
pub const __GCC_ATOMIC_LLONG_LOCK_FREE = 2;
pub const __clang_version__ = c"8.0.0 (tags/RELEASE_800/rc5)";
pub const __UINT_LEAST8_FMTo__ = c"hho";
pub const __SIZEOF_DOUBLE__ = 8;
pub const __INTMAX_FMTd__ = c"ld";
pub const __CLANG_ATOMIC_CHAR_LOCK_FREE = 2;
pub const __INT_LEAST16_FMTi__ = c"hi";
pub const __GCC_ATOMIC_SHORT_LOCK_FREE = 2;
pub const __FMA__ = 1;
pub const __MMX__ = 1;
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16 = 1;
pub const __SIZE_FMTX__ = c"lX";
pub const __WCHAR_WIDTH__ = 32;
pub const __FSGSBASE__ = 1;
pub const __PTRDIFF_FMTd__ = c"ld";
pub const __DBL_MIN_EXP__ = -1021;
pub const __FLT_EVAL_METHOD__ = 0;
pub const __SSE_MATH__ = 1;
pub const __UINT_FAST8_FMTo__ = c"hho";
pub const __UINT_LEAST64_MAX__ = c_ulong(18446744073709551615);
pub const MULTIBOOT_INFO_BOOT_LOADER_NAME = 512;
pub const __UINT_LEAST64_FMTx__ = c"lx";
pub const __INT8_MAX__ = 127;
pub const MULTIBOOT_MEMORY_AVAILABLE = 1;
pub const __DBL_HAS_DENORM__ = 1;
pub const __FLOAT128__ = 1;
pub const __FLT16_HAS_QUIET_NAN__ = 1;
pub const __ATOMIC_RELAXED = 0;
pub const __DBL_DECIMAL_DIG__ = 17;
pub const MULTIBOOT_SEARCH = 8192;
pub const __SIZEOF_SHORT__ = 2;
pub const __UINT16_FMTX__ = c"hX";
pub const __UINT_FAST16_MAX__ = 65535;
pub const __CLANG_ATOMIC_SHORT_LOCK_FREE = 2;
pub const __SSSE3__ = 1;
pub const __CONSTANT_CFSTRINGS__ = 1;
pub const __AVX2__ = 1;
pub const __LDBL_MAX_EXP__ = 16384;
pub const __WINT_MAX__ = c_uint(4294967295);
pub const __NO_MATH_INLINES = 1;
pub const __WCHAR_TYPE__ = int;
pub const __LONG_MAX__ = c_long(9223372036854775807);
pub const __STDC_HOSTED__ = 1;
pub const MULTIBOOT_FRAMEBUFFER_TYPE_EGA_TEXT = 2;
pub const __INT_FAST16_FMTi__ = c"hi";
pub const __PTRDIFF_WIDTH__ = 64;
pub const __INT_LEAST32_TYPE__ = int;
pub const __SCHAR_MAX__ = 127;
pub const __LDBL_DENORM_MIN__ = -nan;
pub const __FLT16_MIN_EXP__ = -14;
pub const MULTIBOOT_INFO_AOUT_SYMS = 16;
pub const __INT64_C_SUFFIX__ = L;
pub const __ELF__ = 1;
pub const __LDBL_MANT_DIG__ = 64;
pub const MULTIBOOT_HEADER_ALIGN = 4;
pub const MULTIBOOT_INFO_CONFIG_TABLE = 256;
pub const __CLANG_ATOMIC_INT_LOCK_FREE = 2;
pub const __SIZEOF_PTRDIFF_T__ = 8;
pub const __SIG_ATOMIC_MAX__ = 2147483647;
pub const __UINT64_FMTX__ = c"lX";
pub const __UINT64_MAX__ = c_ulong(18446744073709551615);
pub const __DBL_MANT_DIG__ = 53;
pub const __FLT_DECIMAL_DIG__ = 9;
pub const __INT_LEAST32_MAX__ = 2147483647;
pub const __DBL_DIG__ = 15;
pub const __ATOMIC_ACQUIRE = 2;
pub const __OPENCL_MEMORY_SCOPE_WORK_GROUP = 1;
pub const __FLT16_HAS_DENORM__ = 1;
pub const __UINT_FAST16_FMTu__ = c"hu";
pub const __INTPTR_FMTi__ = c"li";
pub const MULTIBOOT_INFO_MODS = 8;
pub const __UINT_FAST8_FMTX__ = c"hhX";
pub const __LITTLE_ENDIAN__ = 1;
pub const __SSE__ = 1;
pub const __FLT_HAS_QUIET_NAN__ = 1;
pub const __SIZEOF_SIZE_T__ = 8;
pub const __UINT_LEAST16_FMTo__ = c"ho";
pub const __UINT8_FMTo__ = c"hho";
pub const __UINT_LEAST16_FMTx__ = c"hx";
pub const __CLANG_ATOMIC_WCHAR_T_LOCK_FREE = 2;
pub const __UINT_FAST16_FMTX__ = c"hX";
pub const __VERSION__ = c"4.2.1 Compatible Clang 8.0.0 (tags/RELEASE_800/rc5)";
pub const __UINT_FAST32_FMTx__ = c"x";
pub const __UINTPTR_MAX__ = c_ulong(18446744073709551615);
pub const MULTIBOOT_INFO_ALIGN = 4;
pub const __UINT_FAST8_FMTu__ = c"hhu";
pub const __UINT_LEAST8_FMTu__ = c"hhu";
pub const __UINT_LEAST64_FMTo__ = c"lo";
pub const __UINT_LEAST8_MAX__ = 255;
pub const __RDRND__ = 1;
pub const __SIZEOF_WCHAR_T__ = 4;
pub const __MOVBE__ = 1;
pub const __LDBL_MAX__ = -nan;
pub const __UINT16_MAX__ = 65535;
pub const _LP64 = 1;
pub const __x86_64 = 1;
pub const __code_model_small_ = 1;
pub const linux = 1;
pub const __SIZEOF_WINT_T__ = 4;
pub const MULTIBOOT_INFO_CMDLINE = 4;
pub const __UINTMAX_FMTo__ = c"lo";
pub const __FLT_DIG__ = 6;
pub const __UINT_LEAST8_FMTX__ = c"hhX";
pub const __INT16_MAX__ = 32767;
pub const __WINT_UNSIGNED__ = 1;
pub const __FLT_MAX_10_EXP__ = 38;
pub const __UINTPTR_FMTX__ = c"lX";
pub const __UINT_LEAST16_FMTu__ = c"hu";
pub const __CLANG_ATOMIC_POINTER_LOCK_FREE = 2;
pub const __WINT_WIDTH__ = 32;
pub const __F16C__ = 1;
pub const __SHRT_MAX__ = 32767;
pub const __GCC_ATOMIC_BOOL_LOCK_FREE = 2;
pub const __POINTER_WIDTH__ = 64;
pub const __PTRDIFF_MAX__ = c_long(9223372036854775807);
pub const __tune_corei7__ = 1;
pub const __FLT16_DIG__ = 3;
pub const __INT32_FMTd__ = c"d";
pub const __DBL_MIN__ = -nan;
pub const __SIZEOF_LONG__ = 8;
pub const __INTPTR_WIDTH__ = 64;
pub const MULTIBOOT_INFO_VBE_INFO = 2048;
pub const __FLT16_MAX_10_EXP__ = 4;
pub const __INT_FAST32_TYPE__ = int;
pub const __NO_INLINE__ = 1;
pub const __UINT_FAST32_FMTX__ = c"X";
pub const MULTIBOOT_AOUT_KLUDGE = 65536;
pub const __gnu_linux__ = 1;
pub const __INT_FAST32_MAX__ = 2147483647;
pub const __corei7__ = 1;
pub const __UINTMAX_FMTu__ = c"lu";
pub const MULTIBOOT_FRAMEBUFFER_TYPE_INDEXED = 0;
pub const __BMI__ = 1;
pub const MULTIBOOT_INFO_BOOTDEV = 2;
pub const __FLT_RADIX__ = 2;
pub const MULTIBOOT_INFO_MEMORY = 1;
pub const __FLT16_HAS_INFINITY__ = 1;
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 = 1;
pub const MULTIBOOT_FRAMEBUFFER_TYPE_RGB = 1;
pub const __GCC_ATOMIC_INT_LOCK_FREE = 2;
pub const __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES = 3;
pub const __FLT16_DECIMAL_DIG__ = 5;
pub const __PRAGMA_REDEFINE_EXTNAME = 1;
pub const __INT_FAST8_FMTd__ = c"hhd";
pub const __INT32_TYPE__ = int;
pub const MULTIBOOT_BOOTLOADER_MAGIC = 732803074;
pub const __UINTMAX_WIDTH__ = 64;
pub const __FLT_MIN__ = -nan;
pub const __INT64_FMTi__ = c"li";
pub const __UINT_FAST64_FMTu__ = c"lu";
pub const __INT8_FMTd__ = c"hhd";
pub const __INT_FAST16_TYPE__ = short;
pub const __FLT_MAX_EXP__ = 128;
pub const __XSAVE__ = 1;
pub const __DBL_MAX_10_EXP__ = 308;
pub const __LDBL_MIN__ = -nan;
pub const __INT_FAST64_FMTi__ = c"li";
pub const __INT_LEAST8_FMTd__ = c"hhd";
pub const __CLANG_ATOMIC_LLONG_LOCK_FREE = 2;
pub const __UINT_LEAST32_FMTX__ = c"X";
pub const __UINTMAX_MAX__ = c_ulong(18446744073709551615);
pub const __UINT_FAST16_FMTo__ = c"ho";
pub const __LDBL_DECIMAL_DIG__ = 21;
pub const __UINT_LEAST64_FMTX__ = c"lX";
pub const __clang_minor__ = 0;
pub const __SIZEOF_FLOAT128__ = 16;
pub const __UINT_FAST64_FMTo__ = c"lo";
pub const __SIZE_FMTx__ = c"lx";
pub const __DBL_MAX__ = -nan;
pub const __DBL_EPSILON__ = -nan;
pub const __UINT64_FMTx__ = c"lx";
pub const MULTIBOOT_HEADER = 1;
pub const __CHAR_BIT__ = 8;
pub const __INT16_FMTi__ = c"hi";
pub const _DEBUG = 1;
pub const __GNUC_MINOR__ = 2;
pub const __UINT_FAST32_MAX__ = c_uint(4294967295);
pub const __UINT8_FMTX__ = c"hhX";
pub const __FLT_EPSILON__ = -nan;
pub const __UINTPTR_WIDTH__ = 64;
pub const __llvm__ = 1;
pub const __UINT_FAST64_MAX__ = c_ulong(18446744073709551615);
pub const __INT_FAST32_FMTi__ = c"i";
pub const __FLT_HAS_INFINITY__ = 1;
pub const __AES__ = 1;
pub const __UINT8_FMTx__ = c"hhx";
pub const __INTMAX_C_SUFFIX__ = L;
pub const __ORDER_LITTLE_ENDIAN__ = 1234;
pub const __GCC_ATOMIC_CHAR16_T_LOCK_FREE = 2;
pub const __INT16_FMTd__ = c"hd";
pub const __UINT32_FMTX__ = c"X";
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 = 1;
pub const __UINT32_C_SUFFIX__ = U;
pub const __INT32_MAX__ = 2147483647;
pub const __GCC_ATOMIC_CHAR_LOCK_FREE = 2;
pub const __INTMAX_WIDTH__ = 64;
pub const __CLANG_ATOMIC_BOOL_LOCK_FREE = 2;
pub const __SIZE_FMTo__ = c"lo";
pub const __DBL_HAS_QUIET_NAN__ = 1;
pub const __INT_FAST8_FMTi__ = c"hhi";
pub const __UINT_LEAST32_FMTo__ = c"o";
pub const __STDC_UTF_16__ = 1;
pub const __UINT_LEAST32_MAX__ = c_uint(4294967295);
pub const __ATOMIC_RELEASE = 3;
pub const __UINT_FAST16_FMTx__ = c"hx";
pub const __UINTMAX_C_SUFFIX__ = UL;
pub const __FLT_MIN_EXP__ = -125;
pub const __SIZEOF_LONG_DOUBLE__ = 16;
pub const __UINT_LEAST64_FMTu__ = c"lu";
pub const MULTIBOOT_MOD_ALIGN = 4096;
pub const __GCC_ATOMIC_LONG_LOCK_FREE = 2;
pub const __ORDER_PDP_ENDIAN__ = 3412;
pub const MULTIBOOT_PAGE_ALIGN = 1;
pub const __INT_FAST64_FMTd__ = c"ld";
pub const __CLANG_ATOMIC_LONG_LOCK_FREE = 2;
pub const __GXX_ABI_VERSION = 1002;
pub const __INT16_TYPE__ = short;
pub const __SSE2_MATH__ = 1;
pub const __FLT_MANT_DIG__ = 24;
pub const __UINT_FAST64_FMTx__ = c"lx";
pub const __STDC__ = 1;
pub const __INT_FAST8_MAX__ = 127;
pub const __INTPTR_FMTd__ = c"ld";
pub const __GNUC_PATCHLEVEL__ = 1;
pub const __UINT_LEAST8_FMTx__ = c"hhx";
pub const __SIZE_WIDTH__ = 64;
pub const __INT_LEAST64_FMTi__ = c"li";
pub const __SSE4_2__ = 1;
pub const __AVX__ = 1;
pub const __INT_FAST16_MAX__ = 32767;
pub const __INTPTR_MAX__ = c_long(9223372036854775807);
pub const __CLANG_ATOMIC_CHAR16_T_LOCK_FREE = 2;
pub const __UINT64_FMTu__ = c"lu";
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __SSE2__ = 1;
pub const MULTIBOOT_INFO_FRAMEBUFFER_INFO = 4096;
pub const __INT_MAX__ = 2147483647;
pub const __INTMAX_FMTi__ = c"li";
pub const __DBL_DENORM_MIN__ = -nan;
pub const MULTIBOOT_INFO_APM_TABLE = 1024;
pub const __clang_major__ = 8;
pub const __FLT16_MANT_DIG__ = 11;
pub const __GNUC__ = 4;
pub const __UINT32_MAX__ = c_uint(4294967295);
pub const MULTIBOOT_MEMORY_RESERVED = 2;
pub const __FLT_DENORM_MIN__ = -nan;
pub const __DBL_MAX_EXP__ = 1024;
pub const __INT8_FMTi__ = c"hhi";
pub const __UINT_LEAST16_MAX__ = 65535;
pub const __LDBL_HAS_DENORM__ = 1;
pub const __FLT16_MIN_10_EXP__ = -13;
pub const __LDBL_HAS_QUIET_NAN__ = 1;
pub const __UINT_FAST8_MAX__ = 255;
pub const __DBL_MIN_10_EXP__ = -307;
pub const __UINT8_FMTu__ = c"hhu";
pub const __INT_FAST64_MAX__ = c_long(9223372036854775807);
pub const __SSE3__ = 1;
pub const __UINT16_FMTu__ = c"hu";
pub const __ATOMIC_SEQ_CST = 5;
pub const __SIZE_FMTu__ = c"lu";
pub const __LDBL_MIN_EXP__ = -16381;
pub const __UINT_FAST32_FMTu__ = c"u";
pub const __clang_patchlevel__ = 0;
pub const __SIZEOF_LONG_LONG__ = 8;
pub const __BMI2__ = 1;
pub const MULTIBOOT_INFO_ELF_SHDR = 32;
pub const __GNUC_STDC_INLINE__ = 1;
pub const __PCLMUL__ = 1;
pub const __FXSR__ = 1;
pub const __UINT8_MAX__ = 255;
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 = 1;
pub const __UINT32_FMTx__ = c"x";
pub const __UINT16_FMTo__ = c"ho";
pub const __POPCNT__ = 1;
pub const __OPENCL_MEMORY_SCOPE_DEVICE = 2;
pub const MULTIBOOT_VIDEO_MODE = 4;
pub const __UINT32_FMTu__ = c"u";
pub const __SIZEOF_POINTER__ = 8;
pub const __SIZE_MAX__ = c_ulong(18446744073709551615);
pub const __unix = 1;
pub const __INT_FAST16_FMTd__ = c"hd";
pub const unix = 1;
pub const __UINT_LEAST32_FMTu__ = c"u";
pub const __FLT_MAX__ = -nan;
pub const __corei7 = 1;
pub const __GCC_ATOMIC_WCHAR_T_LOCK_FREE = 2;
pub const __ATOMIC_CONSUME = 1;
pub const __unix__ = 1;
pub const __x86_64__ = 1;
pub const __LDBL_HAS_INFINITY__ = 1;
pub const __UINTMAX_FMTx__ = c"lx";
pub const __UINT64_C_SUFFIX__ = UL;
pub const __INT_LEAST16_MAX__ = 32767;
pub const __FLT_MIN_10_EXP__ = -37;
pub const __UINT32_FMTo__ = c"o";
pub const __UINTPTR_FMTo__ = c"lo";
pub const __INT_LEAST16_FMTd__ = c"hd";
pub const __UINTPTR_FMTx__ = c"lx";
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = 1;
pub const __INT_LEAST64_FMTd__ = c"ld";
pub const __INT_LEAST16_TYPE__ = short;
pub const MULTIBOOT_HEADER_MAGIC = 464367618;
pub const __ORDER_BIG_ENDIAN__ = 4321;
pub const __LDBL_MIN_10_EXP__ = -4931;
pub const __INT_LEAST8_MAX__ = 127;
pub const __SIZEOF_INT__ = 4;
pub const __GCC_ATOMIC_POINTER_LOCK_FREE = 2;
pub const MULTIBOOT_INFO_DRIVE_INFO = 128;
pub const MULTIBOOT_MEMORY_INFO = 2;
pub const __amd64 = 1;
pub const __OBJC_BOOL_IS_BOOL = 0;
pub const __LDBL_MAX_10_EXP__ = 4932;
pub const __SIZEOF_INT128__ = 16;
pub const __UINT_FAST8_FMTx__ = c"hhx";
pub const __linux = 1;
pub const __UINT16_FMTx__ = c"hx";
pub const __UINTPTR_FMTu__ = c"lu";
pub const __UINT_LEAST16_FMTX__ = c"hX";
pub const __amd64__ = 1;
pub const __UINT_FAST32_FMTo__ = c"o";
pub const __linux__ = 1;
pub const __clang__ = 1;
pub const __LP64__ = 1;
pub const __PTRDIFF_FMTi__ = c"li";
pub const __SSE4_1__ = 1;
pub const __LDBL_DIG__ = 18;
pub const __GCC_ATOMIC_CHAR32_T_LOCK_FREE = 2;
pub const __XSAVEOPT__ = 1;
pub const __UINT64_FMTo__ = c"lo";
pub const __INT_FAST32_FMTd__ = c"d";
pub const __ATOMIC_ACQ_REL = 4;
pub const MULTIBOOT_MEMORY_ACPI_RECLAIMABLE = 3;
pub const __LONG_LONG_MAX__ = c_longlong(9223372036854775807);
pub const __OPENCL_MEMORY_SCOPE_SUB_GROUP = 4;
pub const MULTIBOOT_MEMORY_NVS = 4;
pub const MULTIBOOT_INFO_MEM_MAP = 64;
pub const __INTMAX_MAX__ = c_long(9223372036854775807);
pub const __UINT_LEAST32_FMTx__ = c"x";
pub const __WCHAR_MAX__ = 2147483647;
pub const __INT64_MAX__ = c_long(9223372036854775807);
pub const __CLANG_ATOMIC_CHAR32_T_LOCK_FREE = 2;
pub const __INT_LEAST64_MAX__ = c_long(9223372036854775807);
pub const __UINTMAX_FMTX__ = c"lX";
pub const __OPENCL_MEMORY_SCOPE_WORK_ITEM = 0;
pub const __FLT_HAS_DENORM__ = 1;
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __INT32_FMTi__ = c"i";
pub const __DBL_HAS_INFINITY__ = 1;
pub const __FINITE_MATH_ONLY__ = 0;
pub const multiboot_header = struct_multiboot_header;
pub const multiboot_aout_symbol_table = struct_multiboot_aout_symbol_table;
pub const multiboot_elf_section_header_table = struct_multiboot_elf_section_header_table;
pub const multiboot_info = struct_multiboot_info;
pub const multiboot_color = struct_multiboot_color;
pub const multiboot_mmap_entry = struct_multiboot_mmap_entry;
pub const multiboot_mod_list = struct_multiboot_mod_list;
pub const multiboot_apm_info = struct_multiboot_apm_info;
