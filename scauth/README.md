**inclue header file**

`CFLAGS+=-I/path/to/scauth`

`#include <sc_auth.h>`

**demo**

* Check whether it is an ASUS device, ensure that the configuration is not missing.

`char buf[]="RT-AC68U";`

`if(is_asuswrt())`

`printf("This is ASUS router.\n");`

`else`

`printf("This is unknown device.\n");`

* Check whether it is a third-party model supported by SWRT.

`char buf[]="R7000P";`

`if(is_swrt())`

`printf("Yes.\n");`

`else`

`printf("No.\n");`

* If you want to do something with the specified model.

`char buf[]="RT-AC68U";`

`if(is_asuswrt()){`

`switch (get_model()){`

`case MODEL_RTAC68U:`

`do something;`

`break;`

`default:`

`break;`

`}`

`}`

**link**

`${CORSS_PREFIX}gcc -static $CFLAGS $LDFLAGS demo.c /path/to/scauth/$ARCH/sc_auth.a -o demo`

about CFLAGS, see[../sc.sh](../sc.sh) 

