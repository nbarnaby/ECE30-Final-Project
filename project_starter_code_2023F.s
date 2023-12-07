////////////////////////
//                    //
// Project Submission //
//                    //
////////////////////////

// Partner1: Nathaniel Barnaby, A16648285
// Partner2: Alec Nial, A17180937

////////////////////////
//                    //
//       main         //
//                    //
////////////////////////

    // Print Input Array
    lda x0, arr1        // x0 = &list1
    lda x1, arr1_length // x1 = &list1_length
    ldur x1, [x1, #0]   // x1 = list1_length
    bl printList

    // Test Swap Function
    bl printSwapNumbers // print the original values
    lda x0, swap_test   // x0 = &swap_test[0]
    addi x1, x0, #8     // x1 = &swap_test[1]
    bl Swap             // Swap(&swap_test[0], &swap_test[1])
    bl printSwapNumbers // print the swapped values

    // Test GetNextGap Function
    addi x0, xzr, #1    // x0 = 1
    bl GetNextGap       // x0 = GetNextGap(1) = 0
    putint x0           // print x0
    addi x1, xzr, #32   // x1 = ' '
    putchar x1          // print x1

    addi x0, xzr, #6    // x0 = 6
    bl GetNextGap       // x0 = GetNextGap(6) = 3
    putint x0           // print x0
    addi x1, xzr, #32   // x1 = ' '
    putchar x1          // print x1

    addi x0, xzr, #7    // x0 = 7
    bl GetNextGap       // x0 = GetNextGap(7) = 4
    putint x0           // print x0
    addi x1, xzr, #10   // x1 = '\n'
    putchar x1          // print x1


    // Test inPlaceMerge Function
    lda x0, merge_arr_length // x1 = &merge_arr1_length
    ldur x0, [x0, #0]        // x0 = merge_arr1_length
    bl GetNextGap            // x0 = GetNextGap(merge_arr1_length)
    addi x2, x0, #0          // x2 = x0 = gap
    lda x0, merge_arr        // x0 = &merge_arr1
    lda x3, merge_arr_length // x3 = &merge_arr1_length
    ldur x3, [x3, #0]        // x3 = merge_arr1_length
    subi x3, x3, #1          // x3 = x3 - 1     to get the last element
    lsl x3, x3, #3           // x3 = x3 * 8 <- convert length to bytes
    add x1, x3, x0           // x1 = x3 + x0 <- x1 = &merge_arr1[0] + length in bytes
    bl inPlaceMerge          // inPlaceMerge(&merge_arr1[0], &merge_arr1[0] + length in bytes, gap)
    lda x0, merge_arr
    lda x1, merge_arr_length // x1 = &merge_arr1_length
    ldur x1, [x1, #0]        // x1 = list1_length
    bl printList             // print the merged list


    // Test MergeSort Function
    lda x0, arr1            // x0 = &merge_arr1
    lda x2, arr1_length     // x2 = &merge_arr1_length
    ldur x2, [x2, #0]       // x2 = merge_arr1_length
    subi x2, x2, #1         // x2 = x2 - 1     to get the last element
    lsl x2, x2, #3          // x2 = x2 * 8 <-- convert length to bytes
    add x1, x2, x0          // x1 = x2 + x0 <-- x1 = &merge_arr1[0] + length in bytes
    bl MergeSort            // inPlaceMerge(&merge_arr1[0], &merge_arr1[0] + length in bytes, gap)
    lda x1, arr1_length     // x1 = &list1_length
    ldur x1, [x1, #0]       // x1 = list1_length
    bl printList            // print the merged list


    // [BONUS QUESTION] Binary Search Extension
    // load the sorted array's start and end indices
    lda x0, arr1            // x0 = &merge_arr1
    lda x2, arr1_length     // x2 = &merge_arr1_length
    ldur x2, [x2, #0]       // x2 = merge_arr1_length
    subi x2, x2, #1         // x2 = x2 - 1     to get the last element
    lsl x2, x2, #3          // x2 = x2 * 8 <-- convert length to bytes
    add x1, x2, x0          // x1 = x2 + x0 <-- x1 = &merge_arr1[0] + length in bytes

    // Write your code here to check if each values of binary_search_queries are in the sorted array
    // You must loop through the binary_search_queries array and print 1 if the index is found else 0
    // Hint: use binary_search_query_length and binary_search_queries pointers to loop through the queries
    //       and preserve x0 and x1 values, ie. the starting and ending address which you need to pass
    //       in every function call)

    // [BONUS QUESTION] INSERT YOUR CODE HERE

    stop

////////////////////////
//                    //
//        Swap        //
//                    //
////////////////////////
Swap:
    // input:
    //     x0: the address of the first value
    //     x1: the address of the second value

    // INSERT YOUR CODE HERE
    ldur x9, [x0, #0]       // create temp value of x0
    ldur x10, [x1, #0]      // create temp value of x1
    stur x9, [x1, #0]       // store x0 value in x1(swap)
    stur x10, [x0, #0]      // store x1 value in x0(swap)

    br lr

////////////////////////
//                    //
//     GetNextGap     //
//                    //
////////////////////////
GetNextGap:
    // input:
    //     x0: The previous value for gap

    // output:
    //     x0: the updated gap value

    // INSERT YOUR CODE HERE
    SUBIS XZR, X0, #1       // Check if X0 is 1
    B.GT nonzero            // If X0>1, go to nonzero
    ADDI X0, XZR, #0        // Returns 0 if X0<=1
    br lr
nonzero:
    ADDI X10, XZR, #2       // Sets temperorary variable X10 to 2
    ANDI X9, X0, #1         // Returns 1 if X0 is odd, 0 if X0 is even
    SUBIS XZR, X9, #1       // Checks if X9 is a 0 or 1
    B.NE even               // Skips next command if X0 is even
    ADDI X0, X0, #1         // Adds 1 to X0 before dividing it if odd
even:
    UDIV X0, X0, X10        // Divides gap by 2
    br lr



////////////////////////
//                    //
//    inPlaceMerge    //
//                    //
////////////////////////
inPlaceMerge:
    // input:
    //    x0: The address of the starting element of the first sub-array.
    //    x1: The address of the last element of the second sub-array.
    //    x2: The gap used in comparisons for shell sorting

    // INSERT YOUR CODE HERE
    SUBI SP, SP, #24        // Allocate space on stack
    STUR FP, [SP, #0]       // Push FP on stack
    ADDI FP, SP, #16        // New FP
    STUR LR, [FP, #0]       // Push LR on stack
    SUBIS XZR, X2, #1       // Check if gap<1
    B.LT zero               // If gap<1, return
    ADDI X11, X0, #0        // Set X11 to initial X0
    ADDI X12, X1, #0        // Set X12 to initial X1
    ADDI X9, XZR, #8        // Set X9 to 8 for multiply function
    MUL X10, X2, X9         // Set X10 to gap*8, which is the gap in terms of address number
    ADD X1, X0, X10         // Assuming X0 is left, X1 is now right=left+gap
loop:
    LDUR X9, [X0, #0]       // Load left value
    LDUR X10, [X1, #0]      // Load right value
    SUBS XZR, X9, X10       // Check if left value is greater than right value
    B.LE noswap             // If left value isn't, don't swap them
    BL Swap                 // If left value is, the they are swapped
noswap:
    ADDI X0, X0, #8         // Change X0 to next element in array
    ADDI X1, X1, #8         // Change X1 to next element in array
    SUBS XZR, X1, X12       // Check if right element (X1) is still within the last element of the second sub-array
    B.LE loop               // If it is, then loop. If it isn't, then continue

    ADDI X0, X2, #0         // Set X0 to gap for GetNextGap
    BL GetNextGap           // Call GetNextGap
    ADDI X2, X0, #0         // Set X2 to gap from GetNextGap
    ADDI X0, X11, #0        // Set X0 back to initial value
    ADDI X1, X12, #0        // Set X1 back to initial value
    BL inPlaceMerge         // Re-call inPlaceMerge (happens until gap is 0)
zero:
    LDUR LR, [FP, #0]       // Restore LR
    LDUR FP, [FP, #-16]     // Restore FP
    ADDI SP, SP, #24        // Restore SP
    br lr


////////////////////////
//                    //
//      MergeSort     //
//                    //
////////////////////////
MergeSort:
    // input:
    //     x0: The starting address of the array.
    //     x1: The ending address of the array

    // INSERT YOUR CODE HERE
    SUBI SP, SP, #48
    STUR FP, [SP, #0]
    ADDI FP, SP, #40
    STUR LR, [FP, #0]
    LSR X0,X0,#3
    LSR X1,X1,#3
    SUBS XZR, X1, X0
    B.EQ done
    ADD X14, X0,X1
    LSR X14, X14, #1
    LSL X0, X0, #3
    LSL X1, X1, #3
    LSL X14, X14, #3
    STUR X1, [FP, #-8]
    STUR X0, [FP, #-16]
    STUR X14, [FP, #-24]
    ORR X1,X14, XZR
    BL MergeSort
    LDUR X0, [FP, #-24]
    ADDI X0, X0, #8
    LDUR X1, [FP, #-8]
    BL MergeSort
    LDUR X1, [FP, #-8]
    LDUR X0, [FP, #-16]
    LSR X0,X0,#3
    LSR X1,X1,#3
    SUB X0, X1, X0
    ADDI X0, X0, #1
    BL GetNextGap
    ORR X2, X0, XZR
    LDUR X1, [FP, #-8]
    LDUR X0, [FP, #-16]
    BL inPlaceMerge

done:
    LDUR LR, [FP, #0]
    LDUR FP, [FP, #-40]
    ADDI SP, SP, #48
    br lr

////////////////////////
//                    //
//      [BONUS]       //
//   Binary Search    //
//                    //
////////////////////////
BinarySearch:
    // input:
    //     x0: The starting address of the sorted array.
    //     x1: The ending address of the sorted array
    //     x2: The value to search for in the sorted array
    // output:
    //     x3: 1 if value is found, 0 if not found

    // INSERT YOUR CODE HERE

    br lr

////////////////////////
//                    //
//     printList      //
//                    //
////////////////////////

printList:
    // x0: start address
    // x1: length of array
    addi x3, xzr, #32       // x3 = ' '
    addi x4, xzr, #10       // x4 = '\n'
printList_loop:
    subis xzr, x1, #0       // if (x1 == 0) break
    b.eq printList_loopEnd  // break
    subi x1, x1, #1         // x1 = x1 - 1
    ldur x2, [x0, #0]       // x2 = x0->val
    putint x2               // print x2
    addi x0, x0, #8         // x0 = x0 + 8
    putchar x3              // print x3 ' '
    b printList_loop        // continue
printList_loopEnd:
    putchar x4              // print x4 '\n'
    br lr                   // return


////////////////////////
//                    //
//  helper functions  //
//                    //
////////////////////////
printSwapNumbers:
    lda x2, swap_test   // x0 = &swap_test
    ldur x0, [x2, #0]   // x1 = swap_test[0]
    ldur x1, [x2, #8]   // x2 = swap_test[1]
    addi x3, xzr, #32   // x3 = ' '
    addi x4, xzr, #10   // x4 = '\n'
    putint x0           // print x1
    putchar x3          // print ' '
    putint x1           // print x2
    putchar x4          // print '\n'
    br lr               // return
