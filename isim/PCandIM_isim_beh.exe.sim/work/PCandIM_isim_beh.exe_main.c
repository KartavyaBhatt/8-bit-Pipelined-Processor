/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    xilinxcorelib_ver_m_00000000001358910285_0767941723_init();
    xilinxcorelib_ver_m_00000000001358910285_0507128168_init();
    xilinxcorelib_ver_m_00000000001687936702_0873297193_init();
    xilinxcorelib_ver_m_00000000000277421008_2357732895_init();
    xilinxcorelib_ver_m_00000000001603977570_0315815083_init();
    work_m_00000000003388451136_0045532000_init();
    work_m_00000000003920629180_1981668267_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000003920629180_1981668267");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
