#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <prussdrv.h>
#include <pruss_intc_mapping.h>

#include "digits.h"
#include "counter_bin.h"

tpruss_intc_initdata pruss_intc_initdata = PRUSS_INTC_INITDATA;

int main(int argc, char** argv) {
    printf("\nStarting %s example.\r\n", argv[0]);
    /* Initialize the PRU */
    prussdrv_init();

    /* Open PRU Interrupt */
    int open_result = prussdrv_open(PRU_EVTOUT_0);
    if (open_result) {
        printf("prussdrv_open open failed\n");
        return open_result;
    }

    /* Get the interrupt initialized */
    prussdrv_pruintc_init(&pruss_intc_initdata);

    uint16_t* pruMemory;
    prussdrv_map_prumem(PRUSS0_PRU0_DATARAM, (void**) &pruMemory);
    memcpy(pruMemory, digits, sizeof(digits));

    printf("\tExecuting.\r\n");
    prussdrv_exec_code(PRU0, counter, sizeof(counter));

    printf("\tWaiting for HALT command.\r\n");
    prussdrv_pru_wait_event(PRU_EVTOUT_0);
    prussdrv_pru_clear_event(PRU_EVTOUT_0, PRU0_ARM_INTERRUPT);

    /* Disable PRU and close memory mapping*/
    prussdrv_pru_disable(PRU0);
    prussdrv_exit();

    return(0);

}
