#include <stdint.h>
#include <string.h>

#include "stm32f0xx.h"


volatile char str[] = "Hello!";

uint8_t data_array[] = {1,2,3,4,5}; 

int main(void)
{
	
	//check string functions from stdlib
	int len = strlen(str);

	uint8_t stack_array[sizeof(data_array)];
	
	if( len != sizeof(data_array) )
	{
		len = sizeof(data_array);
	}
	
	memcpy(stack_array, data_array, len);
	
	while(1)
	{
		// infinite loop
	}
	
	return 0;
}