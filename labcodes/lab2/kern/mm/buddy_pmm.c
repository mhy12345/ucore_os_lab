#include <pmm.h>
#include <list.h>
#include <string.h>
#include <buddy_pmm.h>

uint32_t pow2_round_up(uint32_t x) {
    uint32_t y = 1;
    while (x) x >>= 1, y <<= 1;
    return y;
}

uint32_t pow2_round_down(uint32_t x) {
    return pow2_round_up(x)>>1;
}

uint32_t log2_round_up(uint32_t x) {
    uint32_t y = 0;
    while (x) x>>=1, y++;
    return y+1;
}

bool is_power_of_2(uint32_t x) {
    if (!x)return 0;
    while (!(x&1))x>>=1;
    return x == 1;
}

uint32_t max(uint32_t x, uint32_t y) {
    return x > y ? x : y;
}

buddy_t buddy;

static void 
buddy_init(void) {
    buddy.total = 0;
}

static void
buddy_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    n = pow2_round_down(n);
    uint32_t t = n;
    uint32_t size = n/2;
    int i;

    for (i = 0; i < 2 * size - 1; ++i) {
        struct Page* p = base+i;
        assert(PageReserved(p));
        p->flags = 0;
        set_page_ref(p, 0);
        p->buddy_info.label = buddy.total;
        if (is_power_of_2(i+1))
            t /= 2;
        p->buddy_info.longest = t;
    }

    buddy.items[buddy.total].header = base;
    buddy.items[buddy.total].size = size;
    buddy.total ++;
}



static struct Page *
_buddy_alloc_pages(buddy_item_t *info, size_t n) {
    struct Page* base = info->header;
    uint32_t node_size = info->size;
    uint32_t index = 0;

    if (base->buddy_info.longest < n) 
        return NULL;

    for(node_size = info->size; node_size != n; node_size /= 2 ) {
        if ((base + LEFT_LEAF(index)) -> buddy_info.longest >= n)
            index = LEFT_LEAF(index);
        else
            index = RIGHT_LEAF(index);
    }
    (base + index) -> buddy_info.longest = 0;
    uint32_t offset = (index + 1) * node_size - info->size;

    while (index) {
        index = PARENT(index);
        (base+index)->buddy_info.longest = 
            max(
                    (base + LEFT_LEAF(index))->buddy_info.longest,
                    (base + RIGHT_LEAF(index))->buddy_info.longest);

    }

    ClearPageProperty(base + offset);
    cprintf("BUDDY : ALLOC MEMORY AT %d\n",offset);
    return base + offset;
}

static struct Page *
buddy_alloc_pages(size_t n) {
    uint32_t i=0;
    if (!is_power_of_2(n))
        n = pow2_round_up(n);
    for (i=0; i<buddy.total; i++) {
        struct Page* p = _buddy_alloc_pages(&buddy.items[i], n);
        if (p) return p;
    }
    return NULL;
}
static void
buddy_free_pages(struct Page* page, size_t n) {
    assert(n>0);
    uint32_t label = page->buddy_info.label;
    buddy_item_t *info = &buddy.items[label];
    struct Page* base = info->header;
    uint32_t offset = page - base;
    uint32_t node_size = 1;
    uint32_t index = offset + info->size - 1;
    for (; (base+index)->buddy_info.longest ; index = PARENT(index)) {
        node_size *= 2;
        if (index == 0)
            return;
    }
    (base+index)->buddy_info.longest = node_size;

    while (index) {
        index = PARENT(index);
        node_size *= 2;

        uint32_t left_longest = (base + LEFT_LEAF(index))->buddy_info.longest;
        uint32_t right_longest = (base + RIGHT_LEAF(index))->buddy_info.longest;

        if (left_longest + right_longest == node_size)
            (base+index)->buddy_info.longest = node_size;
        else
            (base+index)->buddy_info.longest = max(left_longest, right_longest);
    }
    cprintf("BUDDY : FREE MEMORY AT %d\n", offset);
}

static size_t
buddy_nr_free_pages(void) {
    int i;
    size_t ans = 0;
    for (i=0; i<buddy.total; i++) {
        ans = max(ans, buddy.items[i].header->buddy_info.longest);
    }
    return ans;
}


// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
buddy_check(void) {
    cprintf("buddy_check()...\n");
    struct Page *p0, *p1, *p2, *p3;
    p0 = p1 = p2 = p3 = NULL;
    cprintf("the max blocks can be alloc : %d\n", nr_free_pages());
    cprintf("alloc page sized 1,2,3,3 ...\n");
    assert((p0 = alloc_pages(1)) != NULL);
    assert((p1 = alloc_pages(2)) != NULL);
    assert((p2 = alloc_pages(3)) != NULL);
    assert((p3 = alloc_pages(3)) != NULL);
    cprintf(">\t 0.11.222.333....\n");
    cprintf("free the first three blocks ...\n");
    free_pages(p0, 1);
    free_pages(p1, 2);
    free_pages(p2, 3);
    cprintf(">\t .........333....\n");
    cprintf("alloc a block sized 8 ...\n");
    assert((p0 = alloc_pages(8)) != NULL);
    cprintf(">\t 444444444333....\n");
    cprintf("the max blocks can be alloc : %d\n", nr_free_pages());
    cprintf("buddy_check() success.\n");
}

const struct pmm_manager buddy_pmm_manager = {
    .name = "buddy_pmm_manager",
    .init = buddy_init,
    .init_memmap = buddy_init_memmap,
    .alloc_pages = buddy_alloc_pages,
    .free_pages = buddy_free_pages,
    .nr_free_pages = buddy_nr_free_pages,
    .check = buddy_check,
};

