/*
 * Copyright 2021-2025, SWRTdev
 * Copyright 2021-2025, paldier <paldier@hotmail.com>.
 * Copyright 2021-2025, lostlonger<lostlonger.g@gmail.com>.
 * All Rights Reserved.
 */

#ifndef _sc_auth_h_
#define _sc_auth_h_

struct model_s {
	char *pid;
	int model;
};

enum {
	SOC_BCM470X = 1,
	SOC_BCMHND,
	SOC_QCA,
	SOC_MTK,
	SOC_LANTIQ,
	SOC_X86
};

enum {
	SWRT_MODEL_SWRTMIN = 0,
	SWRT_MODEL_K3,
	SWRT_MODEL_XWR3100,
	SWRT_MODEL_R7000P,
	SWRT_MODEL_EA6700,
	SWRT_MODEL_SBRAC1900P,
	SWRT_MODEL_F9K1118,
	SWRT_MODEL_SBRAC3200P,
	SWRT_MODEL_R8500,
	SWRT_MODEL_R8000P,
	SWRT_MODEL_K3C,
	SWRT_MODEL_TY6201_RTK,
	SWRT_MODEL_TY6201_BCM,
	SWRT_MODEL_RAX120,
	SWRT_MODEL_DIR868L,
	SWRT_MODEL_R6300V2,
	SWRT_MODEL_MR60,
	SWRT_MODEL_MS60,
	SWRT_MODEL_RAX70,
	SWRT_MODEL_TY6202,
	SWRT_MODEL_360V6,
	SWRT_MODEL_GLAX1800,
	SWRT_MODEL_RMAC2100,
	SWRT_MODEL_R6800,
	SWRT_MODEL_PGBM1,
	SWRT_MODEL_JCGQ10PRO,
	SWRT_MODEL_H3CTX1801,
	SWRT_MODEL_RMAX6000,
	SWRT_MODEL_UNR030N,
	SWRT_MODEL_RAX200,
	SWRT_MODEL_TYAX5400,
	SWRT_MODEL_RGMA2820A,
	SWRT_MODEL_RGMA2820B,
	SWRT_MODEL_JDCAX1800,
	SWRT_MODEL_RGMA3062,
	SWRT_MODEL_TY6201PRO,
	SWRT_MODEL_XMCR660X,
	SWRT_MODEL_JCGQ20,
	SWRT_MODEL_360T7,
	SWRT_MODEL_RAX80,
	SWRT_MODEL_JDCBE6500,
	SWRT_MODEL_JDCAX3000,
	SWRT_MODEL_SWRTMAX
};

enum {
	MODEL_GENERIC = -1,
	MODEL_UNKNOWN = 0,
	MODEL_DSLN55U,
	MODEL_DSLAC68U,
	MODEL_EAN66,
	MODEL_RTN11P,
	MODEL_RTN300,
	MODEL_RTN13U,
	MODEL_RTN14U,
	MODEL_RTAC52U,
	MODEL_RTAC51U,
	MODEL_RTN54U,
	MODEL_RTAC54U,
	MODEL_RTN56UB1,
	MODEL_RTN56UB2,
	MODEL_RTAC1200HP,
	MODEL_RTAC55U,
	MODEL_RTAC55UHP,
	MODEL_RT4GAC55U,
	MODEL_RTAC59U,
	MODEL_PLN12,
	MODEL_PLAC56,
	MODEL_PLAC66U,
	MODEL_RTAC58U,
	MODEL_RT4GAC53U,
	MODEL_RTAC82U,
	MODEL_MAPAC1300,
	MODEL_MAPAC2200,
	MODEL_VZWAC1300,
	MODEL_MAPAC1750,
	MODEL_RTAC95U,
	MODEL_MAPAC2200V,
	MODEL_RTN36U3,
	MODEL_RTN56U,
	MODEL_RTN65U,
	MODEL_RTN67U,
	MODEL_RTN12,
	MODEL_RTN12B1,
	MODEL_RTN12C1,
	MODEL_RTN12D1,
	MODEL_RTN12VP,
	MODEL_RTN12HP,
	MODEL_RTN12HP_B1,
	MODEL_APN12,
	MODEL_APN12HP,
	MODEL_RTN16,
	MODEL_RTN18U,
	MODEL_RTN15U,
	MODEL_RTN53,
	MODEL_RTN66U,
	MODEL_RTAC66U,
	MODEL_RTAC68U,
	MODEL_RTAC87U,
	MODEL_RTAC56S,
	MODEL_RTAC56U,
	MODEL_RTAC53U,
	MODEL_RTAC3200,
	MODEL_RTAC88U,
	MODEL_RTAC3100,
	MODEL_RTAC5300,
	MODEL_GTAC5300,
	MODEL_RTN14UHP,
	MODEL_RTN10U,
	MODEL_RTN10P,
	MODEL_RTN10D1,
	MODEL_RTN10PV2,
	MODEL_RTAC1200,
	MODEL_RTAC1200G,
	MODEL_RTAC1200GP,
	MODEL_RTAC1200GA1,
	MODEL_RTAC1200GU,
	MODEL_RPAC66,
	MODEL_RPAC51,
	MODEL_RTAC51UP,
	MODEL_RTAC53,
	MODEL_RTN11P_B1,
	MODEL_RPAC87,
	MODEL_RTAC85U,
	MODEL_RTAC85P,
	MODEL_RTACRH26,
	MODEL_RTN800HP,
	MODEL_RTAC88N,
	MODEL_BRTAC828,
	MODEL_RTAC88S,
	MODEL_RPAC53,
	MODEL_RPAC68U,
	MODEL_RPAC55,
	MODEL_RTAC86U,
	MODEL_GTAC9600,
	MODEL_BLUECAVE,
	MODEL_RTAD7200,
	MODEL_GTAXY16000,
	MODEL_GTAX6000N,
	MODEL_RTAX89U,
	MODEL_RTAC1200V2,
	MODEL_RTN19,
	MODEL_TUFAC1750,
	MODEL_RTAX88U,
	MODEL_GTAX11000,
	MODEL_RTAX92U,
	MODEL_RTAX95Q,
	MODEL_RTAXE95Q,
	MODEL_RTAX56_XD4,
	MODEL_RTAX58U,
	MODEL_RTAX56U,
	MODEL_RPAX56,
	MODEL_SHAC1300,
	MODEL_RPAC92,
	MODEL_RTAC59CD6R,
	MODEL_RTAC59CD6N,
	MODEL_RTAX86U,
	MODEL_RTAX68U,
	MODEL_RT4GAC56,
	MODEL_DSLAX82U,
	MODEL_RTAX55,
	MODEL_GTAXE11000,
	MODEL_RTACRH18,
	MODEL_PLAX56XP4,
	MODEL_CTAX56_XD4,
	MODEL_RTAC68U_V4,
	MODEL_GTAX11000_PRO,
	MODEL_ET12,
	MODEL_XT12,
	MODEL_ETJ,
	MODEL_RT4GAC86U,
	MODEL_RT4GAX56,
	MODEL_RTAX53U,
	MODEL_RTAX58U_V2,
	MODEL_GTAX6000,
	MODEL_XD4PRO,
	MODEL_XC5,
	MODEL_XT8PRO,
	MODEL_RTAX86U_PRO,
	MODEL_TUFAX3000_V2,
	MODEL_RTAX82_XD6S,
	MODEL_RPAX58,
	MODEL_ET8PRO,
	MODEL_GTAXE16000,
	MODEL_RTAXE7800,
	MODEL_RTAX57Q,
	MODEL_XT8_V2,
	MODEL_RTAX54,
	MODEL_XD4S,
	MODEL_GT10,
	MODEL_RTAX3000N,
	MODEL_RTAX82U_V2,
	MODEL_PANTHERA,
	MODEL_PANTHERB,
	MODEL_CHEETAH,
	MODEL_TUFAX4200,
	MODEL_TUFAX5400_V2,
	MODEL_BM68,
	MODEL_RTAX88U_PRO,
	MODEL_ET8_V2,
	MODEL_TUFAX6000,
	MODEL_XD6_V2,
	MODEL_RTAX59U,
	MODEL_RTAX5400,
	MODEL_BR63,
	MODEL_BC109,
	MODEL_EBG19,
	MODEL_EBG15,
	MODEL_EBP15,
	MODEL_BC105,
	MODEL_GTBE98,
	MODEL_RTBE96U,
	MODEL_GTBE98_PRO,
	MODEL_BT12,
	MODEL_BQ16,
	MODEL_PRTAX57GO,
	MODEL_RTAX52,
	MODEL_RTAX9000,
	MODEL_GTBE96,
	MODEL_BQ16_PRO,
	MODEL_RTBE88U,
	MODEL_RTBE86U,
	MODEL_RTBE58U,
	MODEL_GTBE19000,
	MODEL_BT10,
	MODEL_RTBE92U,
	MODEL_RTBE95U,
	MODEL_RTBE82U,
	MODEL_TUFBE6500,
	MODEL_RMAC2100,
	MODEL_R6800,
	MODEL_PGBM1,
	MODEL_JCGQ10PRO,
	MODEL_H3CTX1801,
	MODEL_RMAX6000,
	MODEL_R7000P,
	MODEL_SBRAC3200P,
	MODEL_UNR030N,
	MODEL_XMCR660X,
	MODEL_JCGQ20,
	MODEL_360T7,
	MODEL_JDCAX3000,
	MODEL_MAX
};

extern int get_model(char *pid);
extern char *get_modelid(int model);
extern int get_modelname(char *pid);
extern char *get_modelnameid(int model);
extern int is_asuswrt(char *pid);
extern int is_swrt(char *pid);
extern char *nvram_get(const char *name);
extern int nvram_set(const char *name, const char *value);
extern int nvram_unset(const char *name);
extern int nvram_commit(void);
extern int f_exists(const char *path);
extern int d_exists(const char *path);
extern unsigned long f_size(const char *path);
extern int pidof(const char *name);
extern void killall_tk(const char *name);
extern int ether_atoe(const char *a, unsigned char *e);
extern int get_socvendors(void);
extern int RCisSupport(const char *name);
#endif /* _sc_auth_h_ */
