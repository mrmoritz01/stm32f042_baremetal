/* Entry Point */
ENTRY(Reset_Handler)

/* Highest address of the user mode stack */
_stack_end = 0x200017FF;    /* end of RAM */

/* Generate a link error if heap and stack don't fit into RAM */
_Stack_Size = 128; /* required amount of stack */

/* Specify the memory areas */
MEMORY
{
FLASH (rx)      : ORIGIN = 0x8000000, LENGTH = 16K
RAM (xrw)       : ORIGIN = 0x20000000, LENGTH = 6K
}

/* Define output sections */
SECTIONS
{
  .vector_table :
  {
    . = ALIGN(4);
    KEEP(*(.vector_table))
    . = ALIGN(4);
  } >FLASH

   .text :
  {
    . = ALIGN(4);
    *(.text)           /* .text sections (code) */
    *(.text*)          /* .text* sections (code) */
    *(.eh_frame)
    KEEP (*(.init))
    KEEP (*(.fini))

    . = ALIGN(4);
    _text_end = .;        /* define a global symbols at end of code */
  } >FLASH

  .rodata :
  {
    . = ALIGN(4);
    *(.rodata)  
    *(.rodata*)
    . = ALIGN(4);
  } >FLASH

  .ARM.extab   : { *(.ARM.extab* .gnu.linkonce.armextab.*) } >FLASH
  .ARM : {
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
  } >FLASH

  _sidata = LOADADDR(.data);

  .data : 
  {
    . = ALIGN(4);
    _data_start = .;        /* create a global symbol at data start */
    *(.data)           /* .data sections */
    *(.data*)          /* .data* sections */

    . = ALIGN(4);
    _data_end = .;        /* define a global symbol at data end */
  } >RAM AT> FLASH

  . = ALIGN(4);
  .bss :
  {
    _bss_start = .;
    __bss_start__ = _bss_start;
    *(.bss)
    *(.bss*)
    *(COMMON)

    . = ALIGN(4);
    _bss_end = .;
    __bss_end__ = _bss_end;
  } >RAM

  /* User_heap_stack section, used to check that there is enough RAM left */
  ._user_heap_stack :
  {
    . = ALIGN(4);
    PROVIDE ( end = . );
    PROVIDE ( _end = . );
    . = . + _Stack_Size;
    . = ALIGN(4);
  } >RAM

  .ARM.attributes 0 : { *(.ARM.attributes) }
}
