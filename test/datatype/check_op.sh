#!/bin/bash

echo "ompi version with AVX512 -- Usage: arg1: count of elements, args2: 'i'|'u'|'f'|'d' : datatype: signed, unsigned, float, double. args3 size of type. args4 operation"
echo "mpirun -mca op_sve_hardware_available 0 -mca op_avx_hardware_available 0 -np 1 Reduce_local_float 1048576  i 8 max"

Orange="\033[0;33m"
Blue="\033[0;34m"
Purple="\033[0;35m"

NC="\033[0m"

echo "=========Signed Integer type all operations & all sizes========"
echo ""
for op in max min sum mul band bor bxor; do
    echo -e "\n===Operation  $op test==="
    for type_size in 8 16 32 64; do
        for size in 0 1 7 15 31 63 127 130; do
            foo=$((1024 * 1024 + $size))
            echo -e "Test \e[1;33m __mm512 instruction for loop \e[m Total_num_bits = $foo * $type_size "
            echo "mpirun -np 1 reduce_local $foo i $type_size $op"
            mpirun -np 1 reduce_local $foo i $type_size $op
        done
        echo -e "\n\n"
    done
    echo -e "\n\n"
done
echo "=========Signed Integer type all operations & all sizes========"
echo -e "\n\n"

echo "=========Unsigned Integer type all operations & all sizes========"
echo ""
for op in max min sum mul band bor bxor; do
    echo -e "\n===Operation  $op test==="
    for type_size in 8 16 32 64; do
        for size in 0 1 7 15 31 63 127 130; do
            foo=$((1024 * 1024 + $size))
            echo -e "Test \e[1;33m __mm512 instruction for loop \e[m Total_num_bits = $foo * $type_size"
            echo "mpirun -np 1 reduce_local $foo u $type_size $op"
            mpirun -np 1 reduce_local $foo u $type_size $op 
        done
    done
done
echo "=========Unsigned Integer type all operations & all sizes========"
echo -e "\n\n"

echo "=======Float type all operations========"
echo ""
for op in max min sum mul; do
    for size in 1024 127 130; do
        foo=$((1024 * 1024 + $size))
        echo -e "Test \e[1;33m __mm512 instruction for loop \e[m Total_num_bits = $foo * 32"
        mpirun -np 1 reduce_local $foo f 32 $op
    done
done

echo "========Double type all operations========="
echo ""
for op in max min sum mul; do
    for size in 1024 127 130; do
        foo=$((1024 * 1024 + $size))
        echo -e "Test \e[1;33m __mm512 instruction for loop \e[m Total_num_bits = $foo * 64"
        mpirun -np 1 reduce_local $foo d 64 $op
    done
done

