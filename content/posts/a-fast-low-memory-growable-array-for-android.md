---
title: "A fast, low-memory growable array for Android"
description: "A fast, low-memory growable array for Android"
slug: a-fast-low-memory-growable-array-for-android
date: 2011-11-01 08:02:47
draft: false
summary: "A classic problem: you need an array where you are going to hold a set of values; you do not know that array's size in advance but it may grow to be quite the monster.If you use, say, an ArrayList, you have a memory-hungry beast to deal with, making sure that Android will really think about your app when it needs to kill background processes to reclaim some memory."
image: "16623541-d8d0-4ed7-b4e0-7b4991513c2d.jpg"
---


[![](/images/5587611705_2aa6dfbe31_z-300x200.jpg)](http://www.flickr.com/photos/asirap/5587611705/sizes/z/in/photostream/)A
classic problem: you need an array where you are going to hold a set of
values; you do not know that array's size in advance but it may grow to be
quite the monster.  
If you use, say, an ArrayList, you have a memory-hungry beast to deal with,
making sure that Android will really think about your app when it needs to
kill background processes to reclaim some memory.

The solutions offered here have a few downsides, not least of them being the
copy operations; however they are kept to a minimum.

Upon closer inspection you will notice that this code tries to deal with two-
dimensional arrays by storing booleans in a [row][col] array; it is outside
the scope of this post but, yes, I am using integers as bit fields to
represent these booleans. The memory savings are huge.

**Solution #1 -- for an array growing linearly**  
I know that this table will be filled "top to bottom" so I simply double its
size whenever I am about to reach its current boundary. If I waited to
effectively reach the boundary, a loop relying on size() would not go beyond
its original size. Since we are using this boundary, this is not geometric
growth but staggered linear growth.

```bash
class GridInfo {
    int mSize;
    int mRow[];
    
    public GridInfo() {
        this(2);
    }
    
    public GridInfo(int size) {
        mSize = size;
        mRow = new int[mSize];
    }
    
    public int size() {
        return mSize;
    }
    
    void resize() {
        int resizedArray[] = new int[mSize * 2];
        System.arraycopy(mRow, 0, resizedArray, 0, mSize);
        mRow = resizedArray;
        mSize *= 2;
    }
    
    void flickOn(int row, int col) {
        if(row + 1 >= mSize) resize(row);
        mRow[row] |= (2<<col);
    }
    
    void flickOff(int row, int col) {
        if(row + 1 >= mSize) resize(row);
        mRow[row] &= ~(2<<col);
    }
    
    boolean isFlicked(int row, int col) {
        if(row  + 1 >= mSize) resize(row);
        return ((mRow[row] & (2<<col)) != 0);
    }
}
```

**Solution #2 -- for a random-access array**  
Here, the developer using this class may decide to look ahead for a value that
may or may not exist. By resizing the array to 2 to the power of (log2(our
desired row number's)+1), we make sure that this yet uncharted territory
exists.

```java
class GridInfo {
    int mSize;
    int mRow[];
    
    public GridInfo() {
        this(2);
    }
    
    public GridInfo(int size) {
        mSize = size;
        mRow = new int[mSize];
    }
    
    public int size() {
        return mSize;
    }
    
    void resize(int row) {
        int l2 = 1 + (int)(Math.log(row + 1) / Math.log(2));
        int pw = (int)Math.pow(2, l2);
        if(pw > mSize) {
            int resizedArray[] = new int[pw];
            System.arraycopy(mRow, 0, resizedArray, 0, mSize);
            mRow = resizedArray;
            mSize = pw;
        }
    }
    
    void flickOn(int row, int col) {
        if(row + 1 >= mSize) resize(row);
        mRow[row] |= (2<<col);
    }
    
    void flickOff(int row, int col) {
        if(row + 1 >= mSize) resize(row);
        mRow[row] &= ~(2<<col);
    }
    
    boolean isFlicked(int row, int col) {
        if(row  + 1 >= mSize) resize(row);
        return ((mRow[row] & (2<<col)) != 0);
    }
}
```

Of course, make sure to pick an initial value as close as possible to what you
expect your array's average size to be. "2" is not a very likely choice in
most cases.

