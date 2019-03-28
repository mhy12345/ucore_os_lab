#ifndef __KERN_MM_BUDDY_PMM_H__
#define  __KERN_MM_BUDDY_PMM_H__

#include <pmm.h>

extern const struct pmm_manager buddy_pmm_manager;

#define MAX_BUDDY 20

typedef struct {
    size_t size;
    struct Page* header;
} buddy_item_t;

typedef struct {
    uint32_t total;
    buddy_item_t items[MAX_BUDDY];
} buddy_t;

#define LEFT_LEAF(x) (((x)<<1)+1)
#define RIGHT_LEAF(x) (((x)<<1)+2)
#define PARENT(x) (((x)-1)>>1)

#endif /* ! __KERN_MM_BUDDY_PMM_H__ */

