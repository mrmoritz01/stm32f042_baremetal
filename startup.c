#include "stm32f0xx.h"

//Cortex IRQs
void SVC_Handler(void);
void SVC_Handler(void);
void PendSV_Handler(void);
void NMI_Handler(void);
void SysTick_Handler(void);
void Reset_Handler(void);
void Hardfault_Handler(void);
void default_handler(void);

void copy_data(void);
void bss_zero(void);
void stm32f0_init(void);

extern int main (void);

/*Linker Symbols*/
extern unsigned long _stack_end;
extern unsigned long _bss_start;
extern unsigned long _bss_end;
extern unsigned long _rodata_start;
extern unsigned long _rodata_end;
extern unsigned long _data_start;
extern unsigned long _data_end;

void* isr_vectors[]  __attribute__ ((section (".vector_table"))) = {
   (void (*)) &_stack_end,
   Reset_Handler,
   NMI_Handler,
   Hardfault_Handler,
   0,
   0,
   0,
   0,
   0,
   0,
   0,
   SVC_Handler,
   0,
   0,
   PendSV_Handler,
   SysTick_Handler,
   default_handler,		//WWDG_IRQHandler,
   default_handler,		//PVD_VDDIO2_IRQHandler,
   default_handler,		//RTC_IRQHandler,
   default_handler,		//FLASH_IRQHandler,
   default_handler,		//RCC_CRS_IRQHandler,
   default_handler,		//EXTI0_1_IRQHandler,
   default_handler,		//EXTI2_3_IRQHandler,
   default_handler,		//EXTI4_15_IRQHandler,
   default_handler,		//TSC_IRQHandler,
   default_handler,		//DMA1_Channel1_IRQHandler,
   default_handler,		//DMA1_Channel2_3_IRQHandler,
   default_handler,		//DMA1_Channel4_5_IRQHandler,
   default_handler,		//ADC1_IRQHandler ,
   default_handler,		//TIM1_BRK_UP_TRG_COM_IRQHandler,
   default_handler,		//TIM1_CC_IRQHandler,
   default_handler,		//TIM2_IRQHandler,
   default_handler,		//TIM3_IRQHandler,
   0  ,
   0  ,
   default_handler,		//TIM14_IRQHandler,
   0   ,
   default_handler,		//TIM16_IRQHandler,
   default_handler,		//TIM17_IRQHandler,
   default_handler,		//I2C1_IRQHandler,
   0  ,
   default_handler,		//SPI1_IRQHandler,
   default_handler,		//SPI2_IRQHandler,
   default_handler,		//USART1_IRQHandler,
   default_handler,		//USART2_IRQHandler,
   0,
   default_handler,		//CEC_CAN_IRQHandler,
   default_handler		//USB_IRQHandler        
};

//Cortex IRQs
void SVC_Handler(void)
{

}

void PendSV_Handler(void)
{
	
}

void NMI_Handler(void)
{
	
}

void Hardfault_Handler(void)
{
	while(1);
}

void SysTick_Handler(void)
{
	
}

void Reset_Handler(void)
{
	copy_data();
	
	bss_zero();
	
	SystemInit();
	
	/*call main application entry point*/
	main();
}


void default_handler(void)
{
	
}


/*system helpers*/
void copy_data(void)
{	
	unsigned long* dest_p;
	unsigned long* src_p;
	
	src_p = &_rodata_start;
	for(dest_p = &_data_start; dest_p<=&_data_end; dest_p++)
	{
		*dest_p = *src_p++;
	}
}

void bss_zero(void)
{
	unsigned long* dest_p;
	
	for(dest_p = &_bss_start; dest_p<=&_bss_end; dest_p++)
	{
		*dest_p = 0U;
	}
}
  