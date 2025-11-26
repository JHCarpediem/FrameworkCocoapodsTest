//
//  TDCacheHelper.m
//  TDBasis
//
//  Created by Fench on 2025/10/20.
//

#import "TDCacheHelper.h"

NS_ASSUME_NONNULL_BEGIN

/* --- GENERATED FRAGMENTS FOR kkey --- */
static const uint8_t kkey_frag_0[] = {
    0x37, 0x40, 0x31, 0x4b, 0x82
};
static const uint8_t kkey_frag_1[] = {
    0xf7, 0xfd, 0x81, 0xf1, 0x0d
};
static const uint8_t kkey_frag_2[] = {
    0xca, 0xc4, 0xef, 0x91, 0x94, 0xb9
};
static const uint8_t kkey_frag_3[] = {
    0x3a, 0x6a, 0x84, 0xea, 0xcc, 0x6f, 0xbb
};
static const uint8_t kkey_xorkey_0[] = {
    0xd3, 0x55, 0x4b, 0x69, 0x27
};
static const uint8_t kkey_xorkey_1[] = {
    0xdd, 0x85, 0x59, 0x5f, 0xb5
};
static const uint8_t kkey_xorkey_2[] = {
    0x98, 0xbc, 0x63, 0x8a, 0xdf, 0x52
};
static const uint8_t kkey_xorkey_3[] = {
    0x53, 0x5b, 0x92, 0x32, 0xd4, 0x36, 0x5d
};
static const size_t kkey_fragment_lens[] = { 5, 5, 6, 7 };
static const uint8_t * _Nonnull kkey_fragments[] = { kkey_frag_0, kkey_frag_1, kkey_frag_2, kkey_frag_3 };
static const uint8_t * _Nonnull kkey_xor_keys[] = { kkey_xorkey_0, kkey_xorkey_1, kkey_xorkey_2, kkey_xorkey_3 };
static const uint8_t kkey_adds[] = { 46, 63, 5, 3 };
static const uint8_t kkey_rots[] = { 6, 3, 4, 1 };
static const size_t kkey_frag_count = 4;
static const uint8_t kkey_rounds = 2;
static const uint8_t kkey_order[] = { 2, 1, 0, 255 };
static const uint8_t kkey_is_real[] = { 1, 1, 1, 0 };
/* --- END GENERATED FRAGMENTS FOR kkey --- */


/* --- GENERATED FRAGMENTS FOR lkey --- */
static const uint8_t lkey_frag_0[] = {
    0xab, 0x1c, 0x9a, 0x8c, 0x32
};
static const uint8_t lkey_frag_1[] = {
    0xe4, 0xb2, 0xc2, 0xa4, 0xdf
};
static const uint8_t lkey_frag_2[] = {
    0xae, 0xc9, 0x9a, 0xa4, 0x5b, 0xf9
};
static const uint8_t lkey_frag_3[] = {
    0x3a, 0x6a, 0x84, 0xea, 0xcc, 0x6f, 0xbb
};
static const uint8_t lkey_xorkey_0[] = {
    0xd3, 0x55, 0x4b, 0x69, 0x27
};
static const uint8_t lkey_xorkey_1[] = {
    0xdd, 0x85, 0x59, 0x5f, 0xb5
};
static const uint8_t lkey_xorkey_2[] = {
    0x98, 0xbc, 0x63, 0x8a, 0xdf, 0x52
};
static const uint8_t lkey_xorkey_3[] = {
    0x53, 0x5b, 0x92, 0x32, 0xd4, 0x36, 0x5d
};
static const size_t lkey_fragment_lens[] = { 5, 5, 6, 7 };
static const uint8_t * _Nonnull lkey_fragments[] = { lkey_frag_0, lkey_frag_1, lkey_frag_2, lkey_frag_3 };
static const uint8_t * _Nonnull lkey_xor_keys[] = { lkey_xorkey_0, lkey_xorkey_1, lkey_xorkey_2, lkey_xorkey_3 };
static const uint8_t lkey_adds[] = { 46, 63, 5, 3 };
static const uint8_t lkey_rots[] = { 6, 3, 4, 1 };
static const size_t lkey_frag_count = 4;
static const uint8_t lkey_rounds = 2;
static const uint8_t lkey_order[] = { 2, 1, 0, 255 };
static const uint8_t lkey_is_real[] = { 1, 1, 1, 0 };
/* --- END GENERATED FRAGMENTS FOR lkey --- */



@implementation TDCacheHelper
// 将指针内存置0
static inline void secure_zero(void *p, size_t n) {
    if (!p || n == 0) return;
    volatile uint8_t *vp = (volatile uint8_t *)p;
    while (n--) *vp++ = 0;
}

// 反向右循环（8 位
static inline uint8_t ror8(uint8_t b, uint8_t r) {
    uint8_t rr = r & 7;
    return (uint8_t)((b >> rr) | (b << (8 - rr)));
}

// 反向解密密钥
static NSString *load_cache_identify(const uint8_t **out_frag_ptrs,
                                                           const uint8_t **out_xor_ptrs,
                                                           const size_t *out_frag_lens,
                                                           const uint8_t *out_adds,
                                                           const uint8_t *out_rots,
                                                           size_t out_frag_count,
                                                           const uint8_t *out_order,
                                                           const uint8_t *out_is_real,
                                                           uint8_t rounds)
{
    if (!out_frag_ptrs || !out_xor_ptrs || !out_frag_lens || !out_order || !out_is_real) return nil;

    // 首先确定有多少个真实片段（并确认 orig_idx 边界）
    size_t real_count = 0;
    for (size_t out_i = 0; out_i < out_frag_count; out_i++) {
        if (out_is_real[out_i]) {
            uint8_t orig = out_order[out_i];
            if (orig + 1 > real_count) real_count = orig + 1;
        }
    }
    if (real_count == 0) return nil;

    // 计算总长度，仅求和实际片段的长度（使用 out_order 映射）
    size_t total = 0;
    for (size_t out_i = 0; out_i < out_frag_count; out_i++) {
        if (!out_is_real[out_i]) continue;
        size_t flen = out_frag_lens[out_i];
        if (flen > SIZE_MAX / 2) return nil;
        total += flen;
    }
    if (total == 0) return nil;

    uint8_t *buf = (uint8_t *)malloc(total);
    if (!buf) return nil;

    // 分配 real_count 大小的临时数组（原始片段索引 0..real_count-1）
    const uint8_t **reordered_frags = (const uint8_t **)calloc(real_count, sizeof(const uint8_t *));
    const uint8_t **reordered_xorkeys = (const uint8_t **)calloc(real_count, sizeof(const uint8_t *));
    size_t *reordered_lens = (size_t *)calloc(real_count, sizeof(size_t));
    uint8_t *reordered_adds = (uint8_t *)calloc(real_count, sizeof(uint8_t));
    uint8_t *reordered_rots = (uint8_t *)calloc(real_count, sizeof(uint8_t));
    if (!reordered_frags || !reordered_xorkeys || !reordered_lens || !reordered_adds || !reordered_rots) {
        free(buf);
        free(reordered_frags); free(reordered_xorkeys); free(reordered_lens); free(reordered_adds); free(reordered_rots);
        return nil;
    }

    // 仅为真实条目填充重新排序的数组
    for (size_t out_i = 0; out_i < out_frag_count; out_i++) {
        if (!out_is_real[out_i]) continue;
        uint8_t orig = out_order[out_i];
        if (orig >= real_count) continue; // safety
        reordered_frags[orig] = out_frag_ptrs[out_i];
        reordered_xorkeys[orig] = out_xor_ptrs[out_i];
        reordered_lens[orig] = out_frag_lens[out_i];
        reordered_adds[orig] = out_adds[out_i];
        reordered_rots[orig] = out_rots[out_i];
    }

    // 按原始索引顺序解码真实片段
    size_t pos = 0;
    for (size_t f = 0; f < real_count; f++) {
        const uint8_t *frag = reordered_frags[f];
        const uint8_t *xorkey = reordered_xorkeys[f];
        size_t flen = reordered_lens[f];
        if (!frag || !xorkey || flen == 0) continue;
        uint8_t add = reordered_adds[f];
        uint8_t rot = reordered_rots[f] & 7;
        for (size_t i = 0; i < flen; i++) {
            uint8_t v = frag[i];
            for (uint8_t rr = 0; rr < rounds; rr++) {
                uint8_t x = v ^ xorkey[i];
                uint8_t y = (uint8_t)((int)x - (int)add) & 0xff;
                v = ror8(y, rot);
            }
            buf[pos++] = v;
        }
    }

    NSString *s = [[NSString alloc] initWithBytes:buf length:pos encoding:NSUTF8StringEncoding];
    if (!s) s = [[NSString alloc] initWithBytes:buf length:pos encoding:NSASCIIStringEncoding];

    // 释放缓存
    secure_zero(buf, total);
    free(buf);
    free(reordered_frags);
    free(reordered_xorkeys);
    free(reordered_lens);
    free(reordered_adds);
    free(reordered_rots);

    return s;
}

// 替换或添加这两个 accessor（确保变量名与 Python 生成的符号一致）
+ (NSString *)cacheIdentifer {
    return load_cache_identify(kkey_fragments, kkey_xor_keys, kkey_fragment_lens, kkey_adds, kkey_rots, kkey_frag_count, kkey_order, kkey_is_real, kkey_rounds);
}

+ (NSString *)localCacheIdentifer {
    return load_cache_identify(lkey_fragments, lkey_xor_keys, lkey_fragment_lens, lkey_adds, lkey_rots, lkey_frag_count, lkey_order, lkey_is_real, lkey_rounds);
}

@end

NS_ASSUME_NONNULL_END
