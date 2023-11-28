// ECE 30 Project: In-place merge sort
// Reference: https://www.geeksforgeeks.org/in-place-merge-sort/
#include <stdio.h>
#include <stdbool.h>

// Function for swapping
void swap(int arr[], int i, int j) {
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

// Calculating next gap
int nextGap(int gap) {
    if (gap <= 1)
        return 0;

    return (gap / 2) + (gap & 1); // ceil(gap/2)
}

// Merging the subarrays using shell sorting in O(1) space
// Time Complexity: O(nlog n)
void inPlaceMerge(int arr[], int start, int end, int gap) {
    if (gap < 1)
        return;

    for(int left = start; left + gap <= end; left++) {
        int right = left + gap;

        if (arr[left] > arr[right])
            swap(arr, left, right);
    }

    gap = nextGap(gap);
    inPlaceMerge(arr, start, end, gap);
}

// Merge Sort (Recursive)
void mergeSort(int arr[], int left, int right) {
    if (left < right) {
        int mid = (left + right) / 2;

        mergeSort(arr, left, mid);
        mergeSort(arr, mid + 1, right);

        inPlaceMerge(arr, left, right, nextGap(right - left + 1));     // recursive function calling another function
    }
}

// Bonus Extension: Binary Search
bool binarySearch(int arr[], int left, int right, int target) {
    if (right >= left) {
        int mid = left + (right - left) / 2;

        if (arr[mid] == target) // if target is found at the middle
            return true;

        if (arr[mid] > target)  // if target is smaller than mid
            return binarySearch(arr, left, mid - 1, target);

        return binarySearch(arr, mid + 1, right, target);   // if target is greater than mid
    }

    return false;
}


int main() {
    int arr[] = { 12, 11, 13, 5, 6, 7, 2, -1, 20, 30, 15, 10, 8, 17 };
    int arr_size = sizeof(arr) / sizeof(arr[0]);

    // Inplace Merge Sort
    mergeSort(arr, 0, arr_size-1);

    for(int i = 0; i < arr_size; i++) {
        printf("%d ", arr[i]);
    }

    // Bonus Extension: Binary Search
    printf("\n");

    int target = 20;
    bool found = binarySearch(arr, 0, arr_size - 1, target);
    printf("Target %d is %s\n", target, found ? "found" : "not found");

    target = 21;
    found = binarySearch(arr, 0, arr_size - 1, target);
    printf("Target %d is %s\n", target, found ? "found" : "not found");

    return 0;
}

/*  =========== Output ===============
    $ gcc ece30.c && ./a.exe
    -1 2 5 6 7 8 10 11 12 13 15 17 20 30
    Target 20 is found
    Target 21 is not found
*/
