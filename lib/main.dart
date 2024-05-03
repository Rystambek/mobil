#include<stdio.h>
#include<stddef.h>
#include "mymalloc.h"


void initialize(){
 freeList->size=20000-sizeof(struct block);
 freeList->free=1;
 freeList->next=NULL;
}


void split(struct block *fitting_slot,size_t size){
 struct block *new=(void*)((void*)fitting_slot+size+sizeof(struct block));
 new->size=(fitting_slot->size)-size-sizeof(struct block);
 new->free=1;
 new->next=fitting_slot->next;
 fitting_slot->size=size;
 fitting_slot->free=0;
 fitting_slot->next=new;
}


void merge(){
 struct block *curr,*prev;
 curr=freeList;
 while((curr->next)!=NULL){
  if((curr->free) && (curr->next->free)){
   curr->size+=(curr->next->size)+sizeof(struct block);
   curr->next=curr->next->next;
  }
  prev=curr;
  curr=curr->next;
 }
}


void *MyMalloc(size_t noOfBytes){
 struct block *curr,*prev;
 void *result;
 if (freeList == NULL) {
        initialize();
    }

    curr = freeList;
    while (curr != NULL) {
        if (curr->size == noOfBytes && curr->free) {
            // Found a block exactly fitting the request
            curr->free = 0; // Mark block as allocated
            result = (void *)(++curr);
            break;
        } else if (curr->size > noOfBytes && curr->free) {
            // Found a block larger than required
            split(curr, noOfBytes);
            curr->free = 0; // Mark block as allocated
            result = (void *)(++curr);
            break;
        }
        prev = curr;
        curr = curr->next;
    }

    if (result == NULL) {
        // Insufficient memory
        printf("Sorry. No sufficient memory to allocate.\n");
    }

    return result;
}


void MyFree(void* ptr){
 if (ptr == NULL) {
        // Cannot free NULL pointer
        return;
    }

    struct block *toFree = (struct block *)((char *)ptr - sizeof(struct block)); // Get the block header

    // Check if the pointer is within the address range of our memory array
    if (toFree >= freeList && toFree < (struct block *)((char *)freeList + 20000)) {
        // Mark the block as free
        toFree->free = 1;
        // Merge any adjacent free blocks
        merge();
    } else {
        // Pointer is not within the address range of our memory array
        printf("Please provide a valid allocated pointer.\n");
    }
}
