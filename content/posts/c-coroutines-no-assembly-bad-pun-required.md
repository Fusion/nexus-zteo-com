---
title: "C coroutines: no assembly (bad pun) required"
description: "C coroutines: no assembly (bad pun) required"
slug: c-coroutines-no-assembly-bad-pun-required
date: 2013-08-21 01:53:06
draft: false
summary: "I was reading Yossi Kreinin's quick'n fun way to implement coroutines in C and, as an embedded development architect, was a bit saddened by the -- necessary -- use of assembly code to manage a separate stack."
image: "0927b440-3633-45de-8724-dc87e55a05b3.jpg"
---


![Image courtesy of machipai/FreeDigitalPhotos.net](/images/ID-100181779.jpg) I was reading Yossi Kreinin's quick'n fun way to [implement coroutines in C](http://www.embeddedrelated.com/showarticle/455.php) and, as an embedded
development architect, was a bit saddened by the -- necessary -- use of
assembly code to manage a separate stack.

Granted, it's only a few lines of code, but hey, why re-invent the wheel when
we can use existing tools and badmouth Posix a little bit in the process?

## Posix?

Well, yes. Reading his solution it is immediately obvious that rather than
setjmp()/longjmp() one could use context management functions. This approach
uses the context maintained for thread management to implement coroutines
persistency. Except, well. Someone working on Posix decided that it was a bad
thing and deprecated these calls, leaving us with a different type of
alternative: nothing!

Or, if you feel like it, you can re invent everything yourself. You know, *no
one* ever got confused by threads, right?

Anyway, deprecated or not you will find that I am not the only one out there
saying "Hey, they still work and they work well!"

## Listing Time!

Here is what our test file will look like. As you can see, I kept it as
similar as possible to Yuri's implementation. I simply added an extra test to
ensure that I can use coroutines multiple times and reuse them if I want to.

```c
#include <stdio.h>
#include "coroutine.h"

typedef struct {
    coroutine* c;
    int max_x, max_y;
    int x, y;
} iter;

void iterate(void* p) {
    iter* it = (iter*)p;
    int x,y;
    for(x=0; xmax_x; x++) {
    for(y=0; ymax_y; y++) {
        it->x = x;
        it->y = y;
        yield(it->c);
    }
    }
}

int main() {
    coroutine c;
    iter it = {&c, 2, 2};
    puts("Running coroutine test...");
    start(&c, &iterate, &it);
    while(next(&c)) {
    printf("%d %d\n", it.x, it.y);
    }
    puts("Can I use a coroutine multiple times?");
    start(&c, &iterate, &it);
    while(next(&c)) {
    printf("%d %d\n", it.x, it.y);
    }
    puts("All done.");
}
```

Of course, a few definitions go into coroutine.h:

```h
#define _XOPEN_SOURCE 600
#include 

enum { COROUTINE_IDLE = 0, COROUTINE_YIELDING, COROUTINE_DONE };

typedef struct {
    ucontext_t callee_context;
    ucontext_t caller_context;
    volatile char state;
} coroutine;

typedef void (*func)(void*);

void start(coroutine* c, func f, void* arg);
void yield(coroutine* c);
int next(coroutine* c);
```

Yes, the first line was necessary to please OS X.

And finally, coroutine.c:

```c
#include "coroutine.h"

void yield(coroutine* c) {
    c->state = COROUTINE_YIELDING;
    swapcontext(&c->callee_context, &c->caller_context);
    c->state = COROUTINE_DONE;
}

int next(coroutine* c) {
    // This first guard check added in case the callee doesn't return.
    // Yes it's an error but at least not a crash.
    if(c->state != COROUTINE_DONE) {
        swapcontext(&c->caller_context, &c->callee_context);
        if(c->state != COROUTINE_DONE) {
            return 1;
        }
    }
    return 0;
}

void coroutine_wrap(coroutine *c, func f, void* p) {
    f(p);
    c->state = COROUTINE_DONE;
}

void start(coroutine* c, func f, void* arg)
{
    c->state = COROUTINE_IDLE;
    getcontext(&c->callee_context);
    const int stack_size = 64*1024;  // Still arbitrary! But at least big enough...
    c->callee_context.uc_stack.ss_sp = malloc(stack_size);
    c->callee_context.uc_stack.ss_size = stack_size;
    c->callee_context.uc_link = &c->caller_context;
    makecontext(&c->callee_context, coroutine_wrap, 3, c, f, arg);
}
```

Fun fact #1:hey look in this implementation I'm leaking the stack!

Fun fact #2: speaking of...make sure your stack is big enough or you will
notice some surprising behaviors such as your app simply failing -- silently
-- to swap contexts.

Fun fact #3: yes, I am aware that context functions themselves are likely to
manipulate the stack using assembly language. Would you rather do it yourself
for all your potential target architectures?

## What's different?

Well, using contexts forced me to change the algorithm somewhat. For instance,
I am now wrapping my coroutine in a function that will make a note of our
coroutine's state change, letting the iterator function know that we are done.
I also check this guard twice to ensure that if we have a runaway coroutine,
at least our main task will not crash.

As you can see, regardless of the method used, it is still feasible to
implement coroutines quite economically.

I am considering pushing this bit of code to Github; after all, like my
[C-Actor library](https://github.com/Fusion/CActor), it's not as much size as
what you can do with it that matters.

