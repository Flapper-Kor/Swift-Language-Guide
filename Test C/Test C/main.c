//
//  main.c
//  Test C
//
//  Created by 이희웅 on 2022/11/04.
//

#include <stdio.h>

int main(int argc, const char * argv[]) {
    
    // CH01 1장의 TypeSafety 비교
    float a = 0.000001;
    double b = 0.00000000000001;
    int c = 1;
    char d = 'A';
    
    double result = a+b+c+d;
    
    printf("%.14f\n", result);
    return 0;
}

